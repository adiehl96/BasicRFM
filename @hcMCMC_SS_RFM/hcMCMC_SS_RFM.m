classdef hcMCMC_SS_RFM < handle
  %hcMCMC_SS_RFM Slice sampler object for RFM
  % Coordinates MCMC
  %
  % Written by James Lloyd, June 2012
  
  % For now, all properties are generic
  % If releasing code it may be advisable to make some protected etc.
  properties
    
    % Model reference
    
    RFM
    
    % Slice sampling parameters
    
    U_width = 4;
    U_step_out = true;
    U_max_attempts = 6;
        
    pp_width = 4;
    pp_step_out = false;
    pp_max_attempts = 6;
    
    kern_par_widths;
    kern_par_step_out = false;
    kern_par_max_attempts = 6;
    
    T_iterations = 50;
    pp_iterations = 10;
    
    surf_sample = true;
    
    % Sampling parameters
    
    LV_modulus = 1;
    pp_modulus = 1;
    kern_par_modulus = 1;
    data_par_modulus = 1;
    T_modulus = 1;
    plot_modulus = 1;
    talk_modulus = 1;
    
    geweke_modulus = 10;
    
    burn = 200;
    iterations = 1000;
    
    init_method = InitialisationMethods.None;
    
    % Sampling traces
    
    RFM_state = cell(0);
    performance = cell(0);
    predictions = cell(0);
    predictions_average = cell(0);
    
    % Results
    
    MAP;
    elapsed = 0;
    
    % Experimentation practicalities
    
    split_experiment = false;
    batch = 0;
    batches = 0;
    predictions_sum = cell(0);
    
  end
  
  methods
      
    Sample (obj, newrun); % Perform MCMC
    SampleStep (obj, i); % Perform one MCMC update
    GewekeTest (obj, test_function); % Perform Geweke MCMC test
    
    % Constructor
    function obj = hcMCMC_SS_RFM
      obj.kern_par_widths.UU = [0.5; 0.5; 0.1];
    end
    
  end
  
end
