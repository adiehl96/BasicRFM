function UpdateKernelMatrices_ip_UV( obj, ip_indices, array_index )
%UpdateKernelMatrices_ip_UU Update K_ip_pp when input points change
% Detailed explanation goes here
%
% James Lloyd, June 2012
  i = array_index;
  % Update input points
  obj.ip_UV{i}(ip_indices, :) = CreateGPInputPoints (...
                                obj.data_UV.train_X_i{i}(ip_indices), ...
                                obj.data_UV.train_X_j{i}(ip_indices), obj.U, obj.V);
  % Update kernel matrix
  obj.K_ip_pp_UV{i}(ip_indices, :) = obj.arrayKern_UV.Matrix(...
                                     obj.ip_UV{i}(ip_indices, :), obj.pp_UV{i});
end