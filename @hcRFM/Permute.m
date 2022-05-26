function Permute( obj )
%PERMUTE Permute the data usign current permutation
% Permutes the 2-array data
%
% James Lloyd, June 2012

%%%% TODO - could permute other aspects of the data
  for i = 1:length(obj.perm_UU)
    obj.data_UU.train_X_i{i} = obj.data_UU.train_X_i{i}(obj.perm_UU{i});
    obj.data_UU.train_X_j{i} = obj.data_UU.train_X_j{i}(obj.perm_UU{i});
    obj.data_UU.train_X_v{i} = obj.data_UU.train_X_v{i}(obj.perm_UU{i});
    obj.ip_UU{i}             = obj.ip_UU{i}(obj.perm_UU{i}, :);
    obj.K_ip_pp_UU{i}        = obj.K_ip_pp_UU{i}(obj.perm_UU{i}, :);
  end
  for i = 1:length(obj.perm_VV)
    obj.data_VV.train_X_i{i} = obj.data_VV.train_X_i{i}(obj.perm_VV{i});
    obj.data_VV.train_X_j{i} = obj.data_VV.train_X_j{i}(obj.perm_VV{i});
    obj.data_VV.train_X_v{i} = obj.data_VV.train_X_v{i}(obj.perm_VV{i});
    obj.ip_VV{i}             = obj.ip_VV{i}(obj.perm_VV{i}, :);
    obj.K_ip_pp_VV{i}        = obj.K_ip_pp_VV{i}(obj.perm_VV{i}, :);
  end
  for i = 1:length(obj.perm_UV)
    obj.data_UV.train_X_i{i} = obj.data_UV.train_X_i{i}(obj.perm_UV{i});
    obj.data_UV.train_X_j{i} = obj.data_UV.train_X_j{i}(obj.perm_UV{i});
    obj.data_UV.train_X_v{i} = obj.data_UV.train_X_v{i}(obj.perm_UV{i});
    obj.ip_UV{i}             = obj.ip_UV{i}(obj.perm_UV{i}, :);
    obj.K_ip_pp_UV{i}        = obj.K_ip_pp_UV{i}(obj.perm_UV{i}, :);
  end
end

