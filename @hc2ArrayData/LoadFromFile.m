function LoadFromFile( obj, filename, square, undirected, load_as_vectors )
%LOADFROMFILE Loads data
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % Save filename for future use
  obj.file_name = filename;  

  if nargin < 5
    load_as_vectors = false;
  end
  
  % Check to see if filename exists
  if isempty(filename) || (~exist(filename, 'file'))
    obj.D_X = 0;
    obj.M = cell(0);
    obj.N = cell(0);
    obj.train_X_v = cell(0);
    obj.train_X_i = cell(0);
    obj.train_X_j = cell(0);
    obj.test_X_v = cell(0);
    obj.test_X_i = cell(0);
    obj.test_X_j = cell(0);
    return;
  end
    
  % Extract extension
  [~, Ext] = strtok(filename, '.');
  % Open file
  if strcmp (Ext, '.csv')
    obj.D_X = 1;
    R = load(filename);
    R = MakeCell(R);
    % Create blank variables
    obj.M         = cell(obj.D_X, 1);
    obj.N         = cell(obj.D_X, 1);
    obj.train_X_v = cell(obj.D_X, 1);
    obj.train_X_i = cell(obj.D_X, 1);
    obj.train_X_j = cell(obj.D_X, 1);
    obj.test_X_v  = cell(obj.D_X, 1);
    obj.test_X_i  = cell(obj.D_X, 1);
    obj.test_X_j  = cell(obj.D_X, 1);
    % Populate everything as training data
    j = 0; % This counts the number of cells, if not equal to i
    for i = 1:obj.D_X
      if ~load_as_vectors
        % Dimensions
        [obj.M{i} obj.N{i}] = size(R{i});
        % Training data
        O = ones(size(R{i}));
        if undirected && (size(R{i}, 1) == size(R{i}, 2)) && (all(all(R{i} == R{i}')))
          % Undirected
          O = triu(O);
        end
        if square && (size(R{i}, 1) == size(R{i}, 2))
          O = O - diag(diag(O));
        end
        [obj.train_X_i{i} obj.train_X_j{i}] = find(O);
        obj.train_X_v{i} = R{i}(O>0);
        % Setup dummy test data
        obj.test_X_i{i} = [];
        obj.test_X_j{i} = [];
        obj.test_X_v{i} = [];
      else
        % Split any matrices into vectors
        % Dimensions
        for k = 1:size(R{i}, 2)
          j = j + 1; % Count which cell we are on. j > i when data presented as matrix
          obj.M{j} = size(R{i}, 1);
          obj.N{j} = 1;
          % Training data
          obj.train_X_i{j} = 1:size(R{i}, 1);
          obj.train_X_j{j} = ones(size(R{i}, 1), 1);
          obj.train_X_v{j} = R{i}(:, k);
          % Setup dummy test data
          obj.test_X_i{j} = [];
          obj.test_X_j{j} = [];
          obj.test_X_v{j} = [];
        end
      end
    end
    if load_as_vectors
      % Were there any hiding dimensions?
      obj.D_X = j; % What count did we get to?
    end
  elseif strcmp (Ext, '.mat')
    temp = load(filename, 'data');
    obj.M         = temp.data.M;
    obj.N         = temp.data.N;
    obj.train_X_v = temp.data.train_X_v;
    obj.train_X_i = temp.data.train_X_i;
    obj.train_X_j = temp.data.train_X_j;
    obj.test_X_v  = temp.data.test_X_v;
    obj.test_X_i  = temp.data.test_X_i;
    obj.test_X_j  = temp.data.test_X_j;
    clear temp;
  end 
end

