function RFMExperiment( params )
%RFMEXPERIMENT Calls RFM with various parameters
% This will deal with all the fiddly code of loading data etc
%
% James Lloyd, June 2012

  %%%% Use params to setup

  if nargin < 1
    params = [];
  end
  
  % Load objects using params
  [RFM, MCMC] = SetupObjects (params);
  
  %%%% Run the sampler
  MCMC.Sample;
  
  %%%% Evaluate summary stats
  Performance = RFM.Performance (false, MCMC.predictions_average);
  fprintf('\n **** Average performance **** \n\n');
  RFM.Talk (Performance);
  fprintf('\n');
  
  %%%% Free memory
  delete (RFM);
  delete (MCMC);
end

