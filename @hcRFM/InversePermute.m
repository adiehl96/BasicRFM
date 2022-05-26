function InversePermute( obj )
%INVERSEPERMUTE Permute the data usign current inverse permutation
% Permutes the 2-array data

  for i = 1:length(obj.perm_UU)
    obj.data_UU.train_X_i{i} = obj.data_UU.train_X_i{i}(obj.iperm_UU{i});
    obj.data_UU.train_X_j{i} = obj.data_UU.train_X_j{i}(obj.iperm_UU{i});
    obj.data_UU.train_X_v{i} = obj.data_UU.train_X_v{i}(obj.iperm_UU{i});
    obj.ip_UU{i}        = obj.ip_UU{i}(obj.iperm_UU{i}, :);
    obj.K_ip_pp_UU{i}   = obj.K_ip_pp_UU{i}(obj.iperm_UU{i}, :);
  end

  for i = 1:length(obj.perm_VV)
    obj.data_VV.train_X_i{i} = obj.data_VV.train_X_i{i}(obj.iperm_VV{i});
    obj.data_VV.train_X_j{i} = obj.data_VV.train_X_j{i}(obj.iperm_VV{i});
    obj.data_VV.train_X_v{i} = obj.data_VV.train_X_v{i}(obj.iperm_VV{i});
    obj.ip_VV{i}        = obj.ip_VV{i}(obj.iperm_VV{i}, :);
    obj.K_ip_pp_VV{i}   = obj.K_ip_pp_VV{i}(obj.iperm_VV{i}, :);
  end

  for i = 1:length(obj.perm_UV)
    obj.data_UV.train_X_i{i} = obj.data_UV.train_X_i{i}(obj.iperm_UV{i});
    obj.data_UV.train_X_j{i} = obj.data_UV.train_X_j{i}(obj.iperm_UV{i});
    obj.data_UV.train_X_v{i} = obj.data_UV.train_X_v{i}(obj.iperm_UV{i});
    obj.ip_UV{i}        = obj.ip_UV{i}(obj.iperm_UV{i}, :);
    obj.K_ip_pp_UV{i}   = obj.K_ip_pp_UV{i}(obj.iperm_UV{i}, :);
  end
end

