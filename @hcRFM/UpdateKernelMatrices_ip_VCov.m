function UpdateKernelMatrices_ip_VCov( obj, ip_indices, array_index )
%UpdateKernelMatrices_ip_VCov Update K_ip_pp when input points change
% Detailed explanation goes here
%
% James Lloyd, June 2012

  %%%% TODO - make use of rank 1 updates - only ever called with single
  %%%% index (probably)

  i = array_index;
  % Update input points
  obj.ip_VCov{i}(ip_indices, :) = obj.V(obj.data_VCov.train_X_i{i}(ip_indices), :);
  % Update kernel matrix
  obj.K_ip_pp_VCov{i}(ip_indices, :) = obj.arrayKern_VCov.Matrix(...
                                     obj.ip_VCov{i}(ip_indices, :), obj.pp_VCov{i});
end