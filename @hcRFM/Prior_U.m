function llh = Prior_U( obj )
%PRIOR_U Calculates prior llh of variable U
% Normal distribution
%
% Written by James Lloyd, June 2012
  llh = - 0.5 * (obj.U(:)' * obj.U(:)) / (obj.U_sd ^ 2);
end

