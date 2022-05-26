function llh = Bernoulli_llh(p, y)
%BERNOULLI_LLH Calculate conditional llh for independent Bernoulli data
% p is probabilities
% y is {0, 1} values
%
% Written by James Lloyd, June 2012

  % Avoid numerical weirdness
  p(p<eps)     = eps;
  p(p>(1-eps)) = 1-eps;
  % Calculate
  llh = sum(sum(y.*log(p) + (1-y).*log(1-p)));
end


