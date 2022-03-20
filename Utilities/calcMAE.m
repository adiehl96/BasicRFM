function [MAE]=calcMAE(predictions, truth)
%Describe me!

  if ~isempty(truth)
    MAE = mean(abs(predictions - truth));
  else
    MAE = -1;
  end

end


