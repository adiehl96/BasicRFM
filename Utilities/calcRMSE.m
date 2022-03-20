function [RMSE]=calcRMSE(predictions, truth)
%Describe me!

if ~isempty(truth)
  RMSE = sqrt(mean((predictions - truth).^2));
else
  RMSE = -1;
end

end


