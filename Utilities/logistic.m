function y = logistic( x, gain )
%LOGISTIC Summary of this function goes here
%   Detailed explanation goes here
  if nargin < 2
    gain = 1;
  end
  y = 1 ./ (1 + exp(-gain*x));
end

