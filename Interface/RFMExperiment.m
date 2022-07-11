function RFMExperiment( params )
%RFMEXPERIMENT Calls RFM with various parameters
% This will deal with all the fiddly code of loading data etc
%
% James Lloyd, June 2012

  %%%% Use params to setup

  if nargin < 1
    params = [];
  end
%   SaveFilename = value_or_default(params, 'SaveFilename', 'DefaultSaveFile.mat');
  SaveTraces = value_or_default(params, 'SaveTraces', false);
  SavePrediction = value_or_default(params, 'SavePrediction', false);
  
  % Load objects using params
  [RFM, MCMC] = SetupObjects (params);
  
  %%%% Run the sampler
  MCMC.Sample;
  
  %%%% Evaluate summary stats

  Performance = RFM.Performance (false, MCMC.predictions_average);
  fprintf('\n **** Average performance **** \n\n');
  RFM.Talk (Performance);
  fprintf('\n');
  
  %%%% Save and free memory
  
  % TODO - are the object references correct when saving, or does RFM get
  % saved twice separately?
  % Also, should I save MAP when not saving the trace?
  
  if SaveTraces
%     save (SaveFilename, 'Performance', 'RFM', 'MCMC');
  else
    if SavePrediction
      Prediction = MCMC.predictions_average;
%       save (SaveFilename, 'Performance', 'Prediction');
    else
%       save (SaveFilename, 'Performance');
    end
  end
  delete (RFM);
  delete (MCMC);

end

