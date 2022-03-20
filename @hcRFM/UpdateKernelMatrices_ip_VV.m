function UpdateKernelMatrices_ip_VV( obj, ip_indices, array_index )
%UpdateKernelMatrices_ip_VV Update K_ip_pp when input points change
% Detailed explanation goes here
%
% James Lloyd, June 2012
  i = array_index;
  % Update input points
  obj.ip_VV{i}(ip_indices, :) = CreateGPInputPoints (...
                                obj.data_VV.train_X_i{i}(ip_indices), ...
                                obj.data_VV.train_X_j{i}(ip_indices), obj.V);
  % Update kernel matrix
  obj.K_ip_pp_VV{i}(ip_indices, :) = obj.arrayKern_VV.Matrix(...
                                     obj.ip_VV{i}(ip_indices, :), obj.pp_VV{i});
end