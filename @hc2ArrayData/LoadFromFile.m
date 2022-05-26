function LoadFromFile( obj, filename, square, undirected )
%LOADFROMFILE Loads data
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % Save filename for future use
  obj.file_name = filename;
     
  % Open file
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
    %disp(obj.train_X_v)
    % Populate everything as training data
    i = 1;
    disp(i)
    % Dimensions
    [obj.M{i}, obj.N{i}] = size(R{i});
    % Training data
    O = ones(size(R{i}));
    disp(size(O))
    if undirected && (size(R{i}, 1) == size(R{i}, 2)) && (all(all(R{i} == R{i}')))
      disp("condition held")
      % Undirected
      O = triu(O);
    end
    disp(sum(sum(O)))
    if square && (size(R{i}, 1) == size(R{i}, 2))
      O = O - diag(diag(O));
    end
    disp(sum(sum(O)))
    [obj.train_X_i{i}, obj.train_X_j{i}] = find(O);
    
    obj.train_X_v{i} = R{i}(O>0);
    % Setup dummy test data
    obj.test_X_i{i} = [];
    obj.test_X_j{i} = [];
    obj.test_X_v{i} = [];
end
