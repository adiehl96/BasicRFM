function GewekeTest( params )
%GewekeTest Calls RFM with various parameters
% This will deal with all the fiddly code of loading data etc
%
% James Lloyd, June 2012

  %%%% Use params to setup
  
  if nargin < 1
    % Setup up Geweke specific default behaviour
    params.UU_Filename = 'Highschool.csv';
  end
  
  % Other Geweke necessities
  params.UU_Folds = value_or_default(params, 'UU_Folds', 1);
  params.UU_Fold = value_or_default(params, 'UU_Fold', 1);
  params.burn = 0;
  params.iterations = 10000;
  
  [RFM, MCMC] = SetupObjects (params);
  MCMC.geweke_modulus = 10;
  test_function = value_or_default(params, 'test_function', @RFMFirstMoments);
  
  %%%% Run the sampler tester
  
  MCMC.GewekeTest (test_function);
  
  %%%% Free memory
  
  % save (SaveFilename, 'Performance', 'RFM', 'MCMC');
  delete (RFM);
  delete (MCMC);

end

