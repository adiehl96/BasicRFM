classdef hc2ArrayData < handle
  %hc2ArrayData 2-array data containing object
  % Contains
  %  - 2-array data
  %  - All data partitioned into training / test
  %  - Methods to split training for validation purposes
  %
  % Written by James Lloyd, June 2012
  
  % For now, all properties are generic
  % If releasing code it may be advisable to make some protected etc.
  properties
    
    % 2-array data - sparse representation
    
    train_X_v = cell(0); % 2-array data (cell of sparse values)
    train_X_i = cell(0); % 2-array data row locations
    train_X_j = cell(0); % 2-array data column locations
    
    test_X_v = cell(0); % 2-array data (cell of sparse values)
    test_X_i = cell(0); % 2-array data row locations
    test_X_j = cell(0); % 2-array data column locations
    
    N = 0; % Columns
    M = 0; % Rows
    
    % Dimensions of data
    D_X = 0; % Dimensionality of 2-array data
    
    file_name = '';
    
  end
  
  methods
    
    LoadFromFile(obj, filename, square, undirected, load_as_vectors);
    data = Partition(obj, folds, fold, seed);
    new_array = Duplicate(obj);
    Flip(obj);
      
  end
  
end
