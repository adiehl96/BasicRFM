function [ClassScore]=calcClassScore(probs, links)
%Describe me!

  if ~isempty(probs)
    ClassScore = sum(links.*probs + (1-links).*(1-probs));
    %%%% Is this a justified standardisation?
    ClassScore = ClassScore / length(links); 
  else
    ClassScore = -1;
  end

end


