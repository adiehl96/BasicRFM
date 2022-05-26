function performance = EvaluatePerformance_UCov( obj, prediction )
%EvaluatePerformance Bundles up some performance stats based on prediction
% Detailed explanation goes here
%
% James Lloyd, June 2012
  
  if (nargin > 1) && (~isempty(prediction))
    obj.prediction_UCov = prediction.UCov;
  end
  performance = cell(length(obj.prediction_UCov), 1);
  for i = 1:length(performance)
    switch obj.ObservationModel_UCov{i}
      case ObservationModels.Logit
        performance{i} = calcBinErrorStats  (obj.prediction_UCov{i}, obj.data_UCov.test_X_v{i});
      case {ObservationModels.Gaussian, ObservationModels.Poisson}
        performance{i} = calcRealErrorStats (obj.prediction_UCov{i}, obj.data_UCov.test_X_v{i});
    end
  end
end

