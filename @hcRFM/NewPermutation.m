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
    
end

