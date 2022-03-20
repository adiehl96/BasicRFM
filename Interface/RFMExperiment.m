function RFMExperiment( params )
%RFMEXPERIMENT Calls RFM with various parameters
% This will deal with all the fiddly code of loading data etc
%
% James Lloyd, June 2012

  %%%% Use params to setup

  if nargin < 1
    params = [];
  end
  SaveFilename = value_or_default(params, 'SaveFilename', 'DefaultSaveFile.mat');
  SaveTraces = value_or_default(params, 'SaveTraces', false);
  SavePrediction = value_or_default(params, 'SavePrediction', false);
  SplitExperiments = value_or_default(params, 'SplitExperiments', false);
  if ~SplitExperiments
    % Load objects using params
    [RFM, MCMC] = SetupObjects (params);
  else
    % Experiments are to be split across several files
    % All of the following must be specified - else throw an exception
    Batches = params.Batches;
    Batch = params.Batch;
    [SaveFilenameWithoutPath, ~] = strtok(SaveFilename(end:-1:1), '/');
    BatchFileName = ['PartialResults/B_' num2str(Batch, '%02d') ...
                     '_' SaveFilenameWithoutPath(end:-1:1)];
    % Check to see if any future batches have completed
    future_batch_complete = false;
    for future_batch = Batch:Batches
      future_file = ['PartialResults/B_' num2str(future_batch, '%02d') ...
                     '_' SaveFilenameWithoutPath(end:-1:1)];
      if exist(future_file, 'file')
        future_batch_complete = true;
      end
    end
    if future_batch_complete
      fprintf('\nFuture result found - exiting script\n');
      return;
    else
      if Batch > 0
        PreviousBatchFileName = ['PartialResults/B_' num2str(Batch-1, '%02d') ...
                                 '_' SaveFilenameWithoutPath(end:-1:1)];
        % Try to load previous experiment - recall scripts if not
        if (exist(PreviousBatchFileName, 'file'))
          PartialResults = load(PreviousBatchFileName);
          RFM = PartialResults.RFM;
          MCMC = PartialResults.MCMC;
          %%%% - Need to work out what will be saved and what needs to be set
          MCMC.batch = Batch;

          % Re-initialise the traces if they have been deleted to save disk
          % space
          if ~SaveTraces
            MCMC.RFM_state   = cell(MCMC.burn + MCMC.iterations, 1);
            MCMC.predictions = cell(MCMC.burn + MCMC.iterations, 1);
            MCMC.performance = cell(MCMC.burn + MCMC.iterations, 1);
          end
        else
          % Previous batch has not yet complete - try earlier batches by
          % recursion
          params.Batch = params.Batch - 1;
          RFMExperiment(params);
          return
        end
      else
        % Load objects using params
        [RFM, MCMC] = SetupObjects (params);
        %%%% ...
        MCMC.split_experiment = true;
        MCMC.batches = Batches;
        MCMC.batch = 0; % i.e. the burn in batch
      end
    end
  end
  
  %%%% Run the sampler
  
  if (~SplitExperiments) || (Batch == 0)
    MCMC.Sample;
  else
    % This is not a new run - act accordingly
    MCMC.Sample(false);
  end
  
  %%%% Evaluate summary stats

  Performance = RFM.Performance (false, MCMC.predictions_average);
  fprintf('\n **** Average performance **** \n\n');
  RFM.Talk (Performance);
  fprintf('\n');
  
  %%%% Save and free memory
  
  % TODO - are the object references correct when saving, or does RFM get
  % saved twice separately?
  % Also, should I save MAP when not saving the trace?
  
  if ~SplitExperiments
    if SaveTraces
      save (SaveFilename, 'Performance', 'RFM', 'MCMC');
    else
      if SavePrediction
        Prediction = MCMC.predictions_average; %#ok<NASGU>
        save (SaveFilename, 'Performance', 'Prediction');
      else
        save (SaveFilename, 'Performance');
      end
    end
  else
    if SaveTraces
      % Saving everything - no housekeeping required
      if Batch < Batches
        save (BatchFileName, 'Performance', 'RFM', 'MCMC');
      else
        % Finished - save regular file
        save (SaveFilename, 'Performance', 'RFM', 'MCMC');
      end
    else
      % Kill traces to reduce file size
      MCMC.RFM_state   = cell(0);
      MCMC.predictions = cell(0);
      MCMC.performance = cell(0);
      if Batch < Batches
        % Save partial results and kill previous results
        save (BatchFileName, 'Performance', 'RFM', 'MCMC');
      else
        % We can just save the file as normal
        if SavePrediction
          Prediction = MCMC.predictions_average; %#ok<NASGU>
          save (SaveFilename, 'Performance', 'Prediction');
        else
          save (SaveFilename, 'Performance');
        end
      end
    end
    %%%% Delete old partial results to keep disc usage down
    if Batch > 0
      delete(PreviousBatchFileName);
    end
  end
  delete (RFM);
  delete (MCMC);

end

