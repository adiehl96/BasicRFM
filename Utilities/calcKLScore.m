function [KLScore]=calcKLScore(probs, links)
%Describe me!

  if ~isempty(probs)
    probs(probs<eps)    = eps;
    probs(probs>(1-eps)) = 1-eps;
    KLScore = sum(links.*log(probs) + (1-links).*log(1-probs));
    %%%% Is this a justified standardisation?
    KLScore = KLScore / length(links); 
  else
    KLScore = -1;
  end

end


