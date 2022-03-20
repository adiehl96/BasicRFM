function Flip( obj )
%FLIP Swaps training and testing splits
% Summary
%
% James Lloyd, Aug 2012
  
  temp = obj.train_X_v;
  obj.train_X_v = obj.test_X_v;
  obj.test_X_v = temp;
  
  temp = obj.train_X_i;
  obj.train_X_i = obj.test_X_i;
  obj.test_X_i = temp;
  
  temp = obj.train_X_j;
  obj.train_X_j = obj.test_X_j;
  obj.test_X_j = temp;

end

