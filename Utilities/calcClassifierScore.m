function [ClassifierScore]=calcClassifierScore(probs, links)
%Describe me!

  if ~isempty(probs)
    %This calculates the proportion of missclassified links
    %using 50% cutoff
    ClassifierScore = sum(links.*(probs<0.5) + (1-links).*(probs>=0.5));
    %%%% Is this a justified standardisation?
    ClassifierScore = ClassifierScore / length(links); 
  else
    ClassifierScore = -1;
  end

end


