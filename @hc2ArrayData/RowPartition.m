function data = RowPartition( obj, folds, fold, seed )
%PARTITION Partitions training data into train and test
% Only performs operation once
%
% James Lloyd, June 2012

  % Create a new data object
  data = hc2ArrayData;
  data.N = obj.N;
  data.M = obj.M;
  data.D_X = obj.D_X;
  
  if ~isempty(obj.file_name) 
    % Set file name of particular fold - easiest to understand this code by
    % looking at its output - MATLAB is not good at string processing!
    [FileNameWithExt, DataFolder] = strtok(obj.file_name(end:-1:1), '/');
    [FileName, ~] = strtok(FileNameWithExt(end:-1:1), '.');
    [~, ContainingFolder] = strtok(DataFolder, '/');
    fold_file_name = [ContainingFolder(end:-1:1) 'DataFolds/' FileName '_' ...
                      num2str(fold, '%02d') 'of' num2str(folds, '%02d') '_r.mat'];
  else
    fold_file_name = '';
  end
  
  if (~isempty(fold_file_name)) && (exist(fold_file_name, 'file'))
    % Fold has already been created - read from .m file
    clear data; % Don't need the object we previously instantiated
    temp = load(fold_file_name, 'data');
    data = temp.data;
  elseif isempty(obj.train_X_v)
    data.train_X_i = obj.train_X_i;
    data.train_X_j = obj.train_X_j;
    data.train_X_v = obj.train_X_v;
    data.test_X_i  = obj.train_X_i;
    data.test_X_j  = obj.train_X_j;
    data.test_X_v  = obj.train_X_v;
  elseif folds == 1
    data.train_X_i = obj.train_X_i;
    data.train_X_j = obj.train_X_j;
    data.train_X_v = obj.train_X_v;
    data.test_X_i  = obj.test_X_i;
    data.test_X_j  = obj.test_X_j;
    data.test_X_v  = obj.test_X_v;
  else
    % Initialise randomness
    InitialiseRand (seed);
    for i = 1:length(obj.train_X_v)
      % Create row partition
      n_row = max(obj.train_X_i{i});
      perm = randperm(n_row)';
      boundaries = floor(linspace(1, n_row, folds+1));
      if fold == 1
        observed = perm((boundaries(2)):boundaries(folds+1));
        predict  = perm(boundaries(1):(boundaries(2)-1));
      elseif fold == folds
        observed = perm(boundaries(1):(boundaries(folds)-1));
        predict  = perm(boundaries(folds):(boundaries(folds+1)));
      else
        observed = [perm(boundaries(1):(boundaries(fold)-1));
                    perm((boundaries(fold+1)):boundaries(folds+1))];
        predict  = perm(boundaries(fold):(boundaries(fold+1)-1));
      end
      % Calculate data partition
      observed_r = observed;
      observed = [];
      predict = [];
      for j = 1:length(obj.train_X_v{i})
        if any(obj.train_X_i{i}(j) == observed_r)
          observed = [observed, j];
        else
          predict = [predict, j];
        end
      end
      % Partition data
      data.train_X_i{i} = obj.train_X_i{i}(observed);
      data.train_X_j{i} = obj.train_X_j{i}(observed);
      data.train_X_v{i} = obj.train_X_v{i}(observed);
      data.test_X_i{i}  = obj.train_X_i{i}(predict);
      data.test_X_j{i}  = obj.train_X_j{i}(predict);
      data.test_X_v{i}  = obj.train_X_v{i}(predict);
    end
    if ~isempty(fold_file_name)
      % Save the fold for later use
      save(fold_file_name, 'data');
    end
  end
end

