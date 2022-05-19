%%%% ERRORS / CRITICAL UPDATES / QUESTIONS
%%%%  - Will I ever want to have uncertainty estimates - or can I average
%%%%  predictions (taking conditional means) as I am doing currently?

%%%% TODO, currently in no particular order
%%%%  - Make saving ROC an option
%%%%  - Try some sensible gamma priors on the length scales (with scale
%%%%  free on noise)
%%%%  - Save MAP as standard
%%%%  - Extend comparison algorithms
%%%%  - Test test test

%%%% TODO, non-urgent
%%%%  - Check Gaussian likelihood is sampling properly - almost certainly
%%%%  is
%%%%  - Permute other things
%%%%  - Make all likelihood models a cell
%%%%  - Extend Geweke tests
%%%%  - Place a proper prior on gaussian likelihood precision
%%%%  - The interface for splitting experiment / initilisation is blurred -
%%%%  make it nicer

%%%% To think about
%%%%  - In high dimensions, probably need gradients (a la Alan Qi LBFGS)

classdef hcRFM < handle
  %hcRFM Random function model
  % Contains
  %  - A reference to data
  %  - Methods to evaluate likelihoods
  %  - Methods to perform inference
  %  - The current state of all model variables
  %
  % Written by James Lloyd, June 2012
  
  % For now, all properties are generic
  % If releasing code it may be advisable to make some protected etc.
  % Some properties are conceptually dependent but this is not great for
  % speed and memory (I think?)
  properties
    
    % Local reference to data
    
    data_UU
        
    % Dimensions / specifications of model
    
    D_L_U = 1; % Number of latent row dimensions
    n_pp_UU = 50; % Number of pseudo points - this might become a cell in future
    
    % Prior specification
    
    ObservationModel_UU = ObservationModels.Logit; % Could become a cell
    
    DataPrecision_UU = 1; % Observation noise precision for Gaussian likelihood
    
    arrayKern_UU % Kernel for 2-array (same for each array dimension)
    U_sd = 1;
    pp_UU_sd = 1;
    
    % Variables
    
    U = []; % Row r.v.s (rows x latent dimensions)
    pp_UU = cell(0); % 2-array pseudo points
    T_UU = cell(0); % Target points of sparse GP
    
    % Cached quantities
    
    ip_UU = cell(0); % 2-array training input points
    
    pred_ip_UU = cell(0); % 2-array test input points
    K_ip_pp_UU = cell(0); % Kernel matrix between input and pseudo points
    K_pp_pp_UU = cell(0); % Kernel matrix between pseudo points
    chol_K_pp_pp_UU = cell(0); % Cholesky decompostion of above
    perm_UU = cell(0); % Saved permutation for MCMC mixing
    %%%% TODO - add more permutations
    iperm_UU = cell(0); % Saved inverse permutation for MCMC mixing
    
    prediction_UU = cell(0); % Saved predictions for each data set
    performance;
    
    % Memory pre-allocation
    
    W_UU = cell(0); % Output of GP at input points
    K_pred_pp_UU = cell(0); % Kernel matrix between prediction and pseudo points
    
  end
  
  methods
    
    % Prior
    
    llh = Prior_U (obj);
    llh = Prior_pp_UU (obj, index); % Prior for one set of pseudo points - determined by index
    
    % Likelihoods
    
    llh = Cond_llh_ArrayParams_UU (obj, params);
    llh = Cond_llh_pp_UU (obj, pp_index, array_index);
    llh = Cond_llh_U (obj, U_index, ~);
    
    % MCMC routines
    
    Init_U_Rand (obj);
    Init_pp_T (obj);
    Init_Cache (obj);
    ESS_T (obj, iterations);
    SS_ArrayKernParams (obj, widths, step_out, max_attempts);
    SS_pp (obj, iterations, width, step_out, max_attempts, surf);
    SS_U (obj, width, step_out, max_attepts);
    
    state = State (obj); % Returns a struct with the current variable values
    prediction = Prediction (obj); % Returns a cell with predictions
    performance = Performance (obj, predict, prediction); % Returns a struct with various error parameters
    performance = EvaluatePerformance_U (obj, prediction); % Returns a struct with various 
                                                                % error parameters
                                                                
    % Geweke routines
    
    SampleParamsPrior (obj);
    SampleData (obj);
    
    % Utilities

    new_RFM = Duplicate (obj);
    
    llh = llh (obj); % Full log likelihood; calculated using cache
    
    UpdateKernelMatrices_UU (obj);
    UpdateKernelMatrices_ip_UU (obj, ip_indices, array_index);
    UpdateKernelMatrices_pp_UU (obj, pp_index, array_index);
    NewPermutation (obj);
    Permute (obj);
    InversePermute (obj);
    Plot (obj);
    Talk (obj, performance); % Tell the world about various performance stats
    P_Sum = SumPredictions (obj, P1, P2);
    P_Div = DividePredictions (obj, P, Divisor);
    
    % Constructor
    function obj = hcRFM
      obj.arrayKern_UU   = vcKernel;
    end
      
  end
  
end
