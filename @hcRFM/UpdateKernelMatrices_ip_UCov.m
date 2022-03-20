function UpdateKernelMatrices_ip_UCov( obj, ip_indices, array_index )
%UpdateKernelMatrices_ip_UCov Update K_ip_pp when input points change
% Detailed explanation goes here
%
% James Lloyd, June 2012

  i = array_index;
  % Update input points
  obj.ip_UCov{i}(ip_indices, :) = obj.U(obj.data_UCov.train_X_i{i}(ip_indices), :);
  % Update kernel matrix
  obj.K_ip_pp_UCov{i}(ip_indices, :) = obj.arrayKern_UCov.Matrix(...
                                     obj.ip_UCov{i}(ip_indices, :), obj.pp_UCov{i});
end