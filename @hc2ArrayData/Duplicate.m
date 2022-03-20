function new_array = Duplicate( obj )
%DUPLICATE Create a new object with identical values
% Summary
%
% James Lloyd, July 2012
  
  % Create new object
  new_array = hc2ArrayData;

  % Copy values
  new_array.train_X_v = obj.train_X_v;
  new_array.train_X_i = obj.train_X_i;
  new_array.train_X_j = obj.train_X_j;
  new_array.test_X_v = obj.test_X_v;
  new_array.test_X_i = obj.test_X_i;
  new_array.test_X_j = obj.test_X_j;
  new_array.N = obj.N;
  new_array.M = obj.M;
  new_array.D_X = obj.D_X;

end

