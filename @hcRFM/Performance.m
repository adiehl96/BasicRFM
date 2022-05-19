function performance = Performance( obj, predict, prediction )
%Performance Bundles up some performance stats
% Detailed explanation goes here
%
% James Lloyd, June 2012
  
  % Do we need to create the prediction?
  
  if predict
    obj.Prediction; % Call the prediction, to cache the current predictions
    prediction = []; % Set prediction to nil, to prevent re-prediction in later routines
  end
  
  % Call various performance routines
  
  obj.performance.UU = obj.EvaluatePerformance_UU (prediction);
  obj.performance.UCov = obj.EvaluatePerformance_UCov (prediction);
  
  % Return various stats
  
  performance = obj.performance;
  
end

