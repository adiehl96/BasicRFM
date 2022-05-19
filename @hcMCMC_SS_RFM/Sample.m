function Sample( obj, newrun )
%SAMPLE Main MCMC coordination code
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % If no arguments, then assume that this is a new run i.e. delete traces
  if nargin < 2
    newrun = true;
  end

  % Start the timer
  tic;

  % Initialise the model
  
  if newrun
    % Initialise everything
    switch obj.init_method
      case InitialisationMethods.None
        obj.RFM.Initialise_Rand;
      case InitialisationMethods.PCA
        obj.RFM.Initialise_PCA;
    end
    obj.elapsed = 0;
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
          %obj.RFM.Init_V_MAP;
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

  if newrun && (~obj.split_experiment)
    obj.RFM_state   = cell(obj.burn + obj.iterations, 1);
    obj.predictions = cell(obj.burn + obj.iterations, 1);
    obj.performance = cell(obj.burn + obj.iterations, 1);
    
    start_index = 1;
    end_index = obj.burn + obj.iterations;
  else
    if ~obj.split_experiment
      % We are extending a previous experiment
      start_index = length(obj.RFM_state) + 1;
      end_index = obj.burn + obj.iterations;
    else
      % Start at the appropriate batch number
      if obj.batch == 0
        start_index = 1;
        end_index = obj.burn;
      else
        start_index = obj.burn + floor(((obj.batch - 1) * obj.iterations / obj.batches)) + 1;
        end_index = obj.burn + min(floor((obj.batch * obj.iterations / obj.batches)), ...
                                   obj.iterations);
      end
    end
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

  % Identify MAP - this might not live here ultimately
  
%   max_llh = -inf;
%   for i = (obj.burn+1):(obj.burn+obj.iterations)
%     if obj.RFM_state{i}.llh > max_llh
%       max_llh = obj.RFM_state{i}.llh;
%       obj.MAP = obj.RFM_state{i};
%     end
%   end

  % Compute average predictions, errors and AUC - this might not live here
  % ultimately
  
  if ~obj.split_experiment
    obj.predictions_average = obj.predictions{obj.burn+1};
    for i = (obj.burn+2):(obj.burn+obj.iterations)
      obj.predictions_average = obj.RFM.SumPredictions (obj.predictions_average, ...
                                                        obj.predictions{i});
    end
    obj.predictions_average = obj.RFM.DividePredictions ...
                               (obj.predictions_average, obj.iterations);
  else
    if obj.batch == 1
      % Create sum of predictions struct
      obj.predictions_sum = obj.predictions{obj.burn+1};
      range = (obj.burn+2):end_index;
    else
      range = start_index:end_index;
    end
    if obj.batch > 0
      % Add to sum, and produce most up to date predictions
      for i = range
        obj.predictions_sum = obj.RFM.SumPredictions (obj.predictions_sum, ...
                                                      obj.predictions{i});
      end
      obj.predictions_average = obj.RFM.DividePredictions ...
                                (obj.predictions_sum, max(range) - obj.burn);
    else
      % Return some garbage just in case something relies upon the
      % structure existing
      obj.predictions_average = obj.predictions{start_index};
    end
  end

  % Stop the timer                         
                           
  obj.elapsed = toc + obj.elapsed; %Includes any previous time
  
end

