function inputs = CreateGPInputPoints( ii, jj, u, v )
%CREATEGPINPUTPOINTS Create 2d input locations
%   ii, jj: coords of inputs
%   u     : latent positions
  
  if nargin < 4
    inputs = [u(ii,:) u(jj,:)];
  else
    inputs = [u(ii,:) v(jj,:)];
  end
end

