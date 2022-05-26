function stats = calcRealErrorStats( prediction, truth )
%CALCBINERRORSTATS Summary of this function goes here
% Detailed explanation goes here
%
% James Lloyd, June 2012
  
  %[stats.AUC,stats.TPR,stats.FPR] = calcAUC([],[],[], probs, links);
  %stats.KLS = calcKLScore(probs, links);
  %stats.CLS = calcClassScore(probs, links);
  %stats.ClassifierError = calcClassifierScore(probs, links);
  stats.RMSE = calcRMSE(prediction, truth);
  stats.MAE  = calcMAE (prediction, truth);
end

