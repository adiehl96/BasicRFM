function matrix = Matrix( obj, X, Z )
%MATRIX Calls appropriate GPML kernel function
% When matrix is square, noise is added
%
% Written by James Lloyd, June 2012

%%%% TODO - Speed ups could come from rewriting the kernel functions, the
%%%% function sqdist is called very frequently - is there a holistic way of
%%%% calculating these quantities - probably not imho

  if (strcmp (obj.name, 'covSEard_sym'))
    % Need to double up length scales
    cov_params = [obj.params(1:(end-1)); obj.params(1:(end-1)); obj.params(end)];
  else
    cov_params = obj.params;
  end
  if nargin <= 2
    matrix = feval(obj.name, cov_params, X);
    % Now add diagonal noise and jitter for numerical reasons
    matrix = matrix + ((obj.jitter * max(max(matrix))) + ...
                       exp(2 * obj.diagNoise)) * eye(size(matrix));
  else
    matrix = feval(obj.name, cov_params, X, Z);
  end
end

