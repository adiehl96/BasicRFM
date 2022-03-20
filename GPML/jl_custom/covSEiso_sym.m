function K = covSEiso_sym(hyp, x, z, i)

% Squared Exponential covariance function with isotropic distance measure. The 
% covariance function is parameterized as:
%
% k(x^p,x^q) = sf^2 * exp(-(x^p - x^q)'*inv(P)*(x^p - x^q)/2) 
%
% where the P matrix is ell^2 times the unit matrix and sf^2 is the signal
% variance. The hyperparameters are:
%
% hyp = [ log(ell)
%         log(sf)  ]
%
% For more help on design of covariance functions, try "help covFunctions".
%
% Copyright (c) by Carl Edward Rasmussen and Hannes Nickisch, 2010-09-10.
%
% See also COVFUNCTIONS.M.

if nargin<2, K = '2'; return; end                  % report number of parameters
if nargin<3, z = x; end                                   % make sure, z exists

K1 = covSEiso(hyp, x, z);
d = size(x, 2);
swapped_x = [x(:,(((d/2)+1):d)), x(:,1:(d/2))];
K2 = covSEiso(hyp, swapped_x, z);
K = (K1 + K2)./2;

end
