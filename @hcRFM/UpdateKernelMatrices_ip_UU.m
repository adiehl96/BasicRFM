function UpdateKernelMatrices_ip_UU( obj, ip_indices, array_index )
%UpdateKernelMatrices_ip_UU Update K_ip_pp when input points change
% Detailed explanation goes here
%
% James Lloyd, June 2012
  i = array_index;
  % Update input points
  obj.ip_UU{i}(ip_indices, :) = CreateGPInputPoints (...
                                obj.data_UU.train_X_i{i}(ip_indices), ...
                                obj.data_UU.train_X_j{i}(ip_indices), obj.U);
  % Update kernel matrix
  obj.K_ip_pp_UU{i}(ip_indices, :) = obj.arrayKern_UU.Matrix(...
                                     obj.ip_UU{i}(ip_indices, :), obj.pp_UU{i});
end