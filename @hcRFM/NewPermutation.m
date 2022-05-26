function NewPermutation( obj )
%NEWPERMUTATION Create a new random permutation
% Sets the value of perm

  %%%% TODO - permute other things e.g. pseudo points
  obj.perm_UU = cell(length(obj.data_UU.train_X_v), 1);
  for i = 1:length(obj.perm_UU)
    obj.perm_UU{i}                  = randperm(length(obj.data_UU.train_X_v{i}));
    obj.iperm_UU{i}                 = zeros(size(obj.perm_UU{i}));
    obj.iperm_UU{i}(obj.perm_UU{i}) = 1:length(obj.perm_UU{i});
  end
  
  obj.perm_VV = cell(length(obj.data_VV.train_X_v), 1);
  for i = 1:length(obj.perm_VV)
    obj.perm_VV{i}                  = randperm(length(obj.data_VV.train_X_v{i}));
    obj.iperm_VV{i}                 = zeros(size(obj.perm_VV{i}));
    obj.iperm_VV{i}(obj.perm_VV{i}) = 1:length(obj.perm_VV{i});
  end
  
  obj.perm_UV = cell(length(obj.data_UV.train_X_v), 1);
  for i = 1:length(obj.perm_UV)
    obj.perm_UV{i}                  = randperm(length(obj.data_UV.train_X_v{i}));
    obj.iperm_UV{i}                 = zeros(size(obj.perm_UV{i}));
    obj.iperm_UV{i}(obj.perm_UV{i}) = 1:length(obj.perm_UV{i});
  end
end

