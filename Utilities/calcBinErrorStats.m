function stats = calcBinErrorStats( probs, links )
%CALCBINERRORSTATS Summary of this function goes here
% Detailed explanation goes here
%
% James Lloyd, June 2012
  %[stats.AUC,stats.TPR,stats.FPR] = calcAUC([],[],[], probs, links);
  %No longer saves ROC curve - too large for running many jobs in parallel
  %%%% Make me an option!!!
  [stats.AUC,~,~] = calcAUC([],[],[], probs, links);
  stats.KLS = calcKLScore(probs, links);
  stats.CLS = calcClassScore(probs, links);
  stats.ClassifierError = calcClassifierScore(probs, links);
  stats.RMSE = calcRMSE(probs, links);
end

