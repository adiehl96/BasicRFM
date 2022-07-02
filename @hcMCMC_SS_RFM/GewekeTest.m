function GewekeTest( obj, test_function )
%SAMPLE Main Geweke MCMC test coordination code
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % Randomness
  Official_Random_Number = 27;

  % Construct independent RFM copies  
  RFM_Prior = obj.RFM.Duplicate;
  RFM_Posterior = RFM_Prior.Duplicate;

  % Initialise the models
  InitialiseRand (Official_Random_Number);
  RFM_Prior.Initialise_Rand;

  InitialiseRand (Official_Random_Number);
  RFM_Posterior.Initialise_Rand;

  % Initialise MCMC traces

  RFM_Prior_state   = cell(obj.burn + obj.iterations, 1);
  RFM_Posterior_state   = cell(obj.burn + obj.iterations, 1);
    
  start_index = 1;
  
  % Main MCMC iterations

  for i = start_index:(obj.burn+obj.iterations)

    % Randomly permute the data to improve mixing

    RFM_Posterior.NewPermutation;
    RFM_Posterior.Permute;

    % Sample from posterior

    if mod(i, obj.T_modulus) == 0 
      RFM_Posterior.ESS_T (round(obj.T_iterations / 2));
    end
    if mod(i, obj.LV_modulus) == 0 
      RFM_Posterior.SS_U (obj.U_width, obj.U_step_out, obj.U_max_attempts);
      RFM_Posterior.SS_V (obj.V_width, obj.V_step_out, obj.V_max_attempts);
    end
    if mod(i, obj.pp_modulus) == 0 
      RFM_Posterior.SS_pp (obj.pp_iterations, obj.pp_width, obj.pp_step_out,...
                           obj.pp_max_attempts, obj.surf_sample);
    end
    if mod(i, obj.kern_par_modulus) == 0 
      RFM_Posterior.SS_ArrayKernParams (obj.kern_par_widths, obj.kern_par_step_out, ...
                                  obj.kern_par_max_attempts);
    end
    if mod(i, obj.data_par_modulus) == 0 
      RFM_Posterior.GS_DataParams;
    end
    if mod(i, obj.T_modulus) == 0 
      RFM_Posterior.ESS_T (round(obj.T_iterations / 2));
    end

    % Reverse the permutation

    RFM_Prior.InversePermute;
    RFM_Posterior.InversePermute;
    
    % Resample the data
    
    RFM_Posterior.SampleData;
    
    % Sample from prior
    
    RFM_Prior.SampleParamsPrior;

    % Record traces

    RFM_Prior_state{i} = RFM_Prior.State;
    RFM_Posterior_state{i} = RFM_Posterior.State;

    % Output
    
    if mod(i, obj.geweke_modulus) == 0
      fprintf('Iter %05d / %05d', i-obj.burn, obj.iterations);
      % Call the Geweke test
      test_function(RFM_Prior_state, RFM_Posterior_state, i)
    end
   
  end
  
end

