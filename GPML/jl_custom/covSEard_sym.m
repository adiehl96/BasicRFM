function K = covSEiso_sym(hyp, x, z, i)

% Squared Exponential covariance function with Automatic Relevance Detemination
% (ARD) distance measure. The covariance function is parameterized as:
%
% k(x^p,x^q) = sf2 * exp(-(x^p - x^q)'*inv(P)*(x^p - x^q)/2)
%
% where the P matrix is diagonal with ARD parameters ell_1^2,...,ell_D^2, where
% D is the dimension of the input space and sf2 is the signal variance. The
% hyperparameters are:
%
% hyp = [ log(ell_1)
%         log(ell_2)
%          .
%         log(ell_D)
%         log(sqrt(sf2)) ]
%
% Copyright (c) by Carl Edward Rasmussen and Hannes Nickisch, 2010-09-10.
%
% See also COVFUNCTIONS.M.
%
% Modified by James Lloyd to produce symmetric functions, July 2012

if nargin<2, K = '2'; return; end                  % report number of parameters
if nargin<3, z = x; end                                   % make sure, z exists

K1 = covSEard(hyp, x, z);
d = size(x, 2);
swapped_x = [x(:,(((d/2)+1):d)), x(:,1:(d/2))];
K2 = covSEard(hyp, swapped_x, z);
K = (K1 + K2)./2;

end
