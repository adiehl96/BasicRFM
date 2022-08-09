function Sample( obj, newrun )
%SAMPLE Main MCMC coordination code
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % If no arguments, then assume that this is a new run i.e. delete traces
  if nargin < 2
    newrun = true;
  end

  % Initialise the model
  
  if newrun
    % Initialise everything
    switch obj.init_method
      case InitialisationMethods.None
        obj.RFM.Initialise_Rand;
      case InitialisationMethods.PCA
        obj.RFM.Initialise_PCA;
    end
  else
    % Just initialise the cache in case anything was not up to date
    obj.RFM.Init_Cache;
  end
  
  % Perform initialisation if new run
  
  if newrun && (obj.init_method ~= InitialisationMethods.None) && ...
               (obj.init_method ~= InitialisationMethods.PCA)
    for repeat = 1:5
      for i = 1:50
        % Randomly permute the data to improve mixing

        obj.RFM.NewPermutation;
        obj.RFM.Permute;

        % Sample

        obj.SampleStep (i);

        % Reverse the permutation

        obj.RFM.InversePermute;
        
        % Evaluate performance
        
        obj.RFM.State;
        obj.RFM.Prediction;
        obj.RFM.Performance (false, []); % Do not need to re-predict, use cache

        % Output

        if (mod(i, obj.plot_modulus) == 0) && (obj.plot_modulus < obj.iterations)
          obj.RFM.Plot;
        end
        if mod(i, obj.talk_modulus) == 0 
          fprintf('Initialising %05d / %05d : ', i, 50);
          obj.RFM.Talk;
          fprintf('\n');
        end

      end
      switch obj.init_method
        case InitialisationMethods.ResamplePseudo
          obj.RFM.Init_pp_T;
        case InitialisationMethods.MAPU
          obj.RFM.Init_U_MAP;
        case InitialisationMethods.Both
          if mod(repeat, 2) == 1
            obj.RFM.Init_U_MAP;
          else
            obj.RFM.Init_pp_T;
          end
      end
      obj.RFM.Init_Cache; % Lots has changed
    end
  end

  % Initialise MCMC traces if starting a new run

  if newrun
    obj.RFM_state   = cell(obj.burn + obj.iterations, 1);
    obj.predictions = cell(obj.burn + obj.iterations, 1);
    obj.performance = cell(obj.burn + obj.iterations, 1);
    
    start_index = 1;
    end_index = obj.burn + obj.iterations;
  else
    % We are extending a previous experiment
    start_index = length(obj.RFM_state) + 1;
    end_index = obj.burn + obj.iterations;
  end
  
  % Main MCMC iterations

  for i = start_index:end_index

    % Randomly permute the data to improve mixing

    obj.RFM.NewPermutation;
    obj.RFM.Permute;

    % Sample

    obj.SampleStep (i);

    % Reverse the permutation

    obj.RFM.InversePermute;

    % Record traces

    obj.RFM_state{i}   = obj.RFM.State;
    obj.predictions{i} = obj.RFM.Prediction;
    obj.performance{i} = obj.RFM.Performance (false, []); % Do not need to re-predict, use cache
    obj.RFM_state{i}   = obj.RFM.State;
    % Output
    
    if (mod(i, obj.plot_modulus) == 0) && (obj.plot_modulus < obj.iterations)
      obj.RFM.Plot;
    end
    if mod(i, obj.talk_modulus) == 0 
      fprintf('Iter %05d / %05d : ', i-obj.burn, obj.iterations);
      obj.RFM.Talk;
      fprintf('\n');
    end
  end
    

  AUC = [];
  KLS = [];
  CLS = [];
  ClassifierError = [];
  RMSE = [];
  U = [];
  W_UU = [];
  
  train_x_i = [];
  train_x_j = [];
  test_x_i = [];
  test_x_j = [];
  pp_UU = [];
  ip_UU = [];
  T_UU = [];
  DataPrecision_UU = [];
  llh = [];
  name = [];
  params = [];
  diagNoise = [];
  jitter = [];
  priorType = [];
  priorParams = [];
  noiseParams = [];
  for i = 1:length(obj.RFM_state)
    AUC = cat(1, AUC, [obj.performance{i}.UU{1}.AUC]);
    KLS = cat(1, KLS, [obj.performance{i}.UU{1}.KLS]);
    CLS = cat(1, CLS, [obj.performance{i}.UU{1}.CLS]);
    ClassifierError = cat(1, ClassifierError, [obj.performance{i}.UU{1}.ClassifierError]);
    RMSE = cat(1, RMSE, [obj.performance{i}.UU{1}.RMSE]);
    U = cat(1, U, obj.RFM_state{i}.U);
    W_UU = cat(1, W_UU, obj.RFM_state{i}.W_UU{1});
    W_UU = cat(1, W_UU, obj.RFM_state{i}.prediction_UU{1});
    pp_UU = cat(1,pp_UU,obj.RFM_state{i}.pp_UU{1});
    ip_UU = cat(1,ip_UU,obj.RFM_state{i}.ip_UU{1});
    T_UU = cat(1, T_UU, obj.RFM_state{i}.T_UU{1});
    DataPrecision_UU = cat(1, DataPrecision_UU, [obj.RFM_state{i}.DataPrecision_UU]);
    llh = cat(1,llh,[obj.RFM_state{i}.llh]);
    % Kernel Params
    name = cat(1, name, [string(obj.RFM_state{i}.arrayKern_UU.name)]);
    params = cat(1, params, obj.RFM_state{i}.arrayKern_UU.params');
    diagNoise = cat(1, diagNoise, obj.RFM_state{i}.arrayKern_UU.diagNoise);
    jitter = cat(1, jitter, obj.RFM_state{i}.arrayKern_UU.jitter);
    priorType = cat(1, priorType, [string(obj.RFM_state{i}.arrayKern_UU.priorType)]);
    priorParams = cat(1, priorParams, obj.RFM_state{i}.arrayKern_UU.priorParams(:));
    noiseParams = cat(1, noiseParams, obj.RFM_state{i}.arrayKern_UU.noiseParams);
  end

  train_x_i = cat(1, train_x_i, obj.RFM.data_UU.train_X_i{1});
  test_x_i = cat(1, test_x_i, obj.RFM.data_UU.test_X_i{1});
  train_x_j = cat(1, train_x_j, obj.RFM.data_UU.train_X_j{1});
  test_x_j = cat(1, test_x_j, obj.RFM.data_UU.test_X_j{1});

  fid = fopen('output/ID.txt','wt');
  fprintf(fid, '%s', obj.UU_Filename);
  fclose(fid);
 
  fid = fopen('output/iterations.txt','wt');
  fprintf(fid, '%s', string(length(obj.RFM_state)));
  fclose(fid);
    
  writematrix(AUC,"output/AUC.csv")
  writematrix(KLS,"output/KLS.csv")
  writematrix(CLS,"output/CLS.csv")
  writematrix(ClassifierError,"output/ClassifierError.csv")
  writematrix(RMSE,"output/RMSE.csv")
  writematrix(U,"output/U.csv")
  writematrix(W_UU,"output/W_UU.csv")
  writematrix(train_x_i,"output/train_x_i.csv")
  writematrix(test_x_i,"output/test_x_i.csv")
  writematrix(train_x_j,"output/train_x_j.csv")
  writematrix(test_x_j,"output/test_x_j.csv")
  writematrix(pp_UU,"output/pp_UU.csv")
  writematrix(ip_UU,"output/ip_UU.csv")
  writematrix(T_UU,"output/T_UU.csv")
  writematrix(DataPrecision_UU, "output/DataPrecision_UU.csv")
  writematrix(llh, "output/llh.csv")
  writematrix(name, "output/name.csv")
  writematrix(params, "output/params.csv")
  writematrix(diagNoise, "output/diagNoise.csv")
  writematrix(jitter, "output/jitter.csv")
  writematrix(priorType, "output/priorType.csv")
  writematrix(priorParams,"output/priorParams.csv")
  writematrix(noiseParams, "output/noiseParams.csv")
  
  % Compute average predictions, errors and AUC - this might not live here
  % ultimately
  
  obj.predictions_average = obj.predictions{obj.burn+1};
  for i = (obj.burn+2):(obj.burn+obj.iterations)
    obj.predictions_average = obj.RFM.SumPredictions (obj.predictions_average, ...
                                                      obj.predictions{i});
  end
  obj.predictions_average = obj.RFM.DividePredictions ...
                              (obj.predictions_average, obj.iterations);
end

