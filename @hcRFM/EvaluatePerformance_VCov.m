function performance = EvaluatePerformance_VCov( obj, prediction )
%EvaluatePerformance Bundles up some performance stats based on prediction
% Detailed explanation goes here
%
% James Lloyd, June 2012
  
  %%%% Not sure this is the best architecture at the moment
  %%%% Should maybe also just pass the error function?
  if (nargin > 1) && (~isempty(prediction))
    obj.prediction_VCov = prediction.VCov;
  end
  performance = cell(length(obj.prediction_VCov), 1);
  for i = 1:length(performance)
    switch obj.ObservationModel_VCov{i}
      case ObservationModels.Logit
        performance{i} = calcBinErrorStats  (obj.prediction_VCov{i}, obj.data_VCov.test_X_v{i});
      case {ObservationModels.Gaussian, ObservationModels.Poisson}
        performance{i} = calcRealErrorStats (obj.prediction_VCov{i}, obj.data_VCov.test_X_v{i});
    end
  end
end

