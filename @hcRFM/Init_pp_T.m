function Init_pp_T( obj )
%Init_pp_T Initialise pp and T
% Write a description of all variables here
%
% James Lloyd, June 2012

  % Relating to UU array
  obj.pp_UU = cell(length(obj.data_UU.train_X_v), 1);
  obj.T_UU  = cell(length(obj.data_UU.train_X_v), 1);
  for i = 1:length(obj.pp_UU)
    % Initialise T as random normals
    obj.T_UU{i} = randn(obj.n_pp_UU, 1);
    if obj.n_pp_UU <= length(obj.data_UU.train_X_v{i})
      % Can initialise as a subset
      perm = randperm(length(obj.data_UU.train_X_v{i}));
      rand_subset = perm(1:obj.n_pp_UU);
      % Initialise pseudo points as random subset of observations
      obj.pp_UU{i} = CreateGPInputPoints (obj.data_UU.train_X_i{i}(rand_subset), ...
                                          obj.data_UU.train_X_j{i}(rand_subset), ...
                                          obj.U);
    else
      % Must be in a very low data regime - probably Geweke testing
      % Sample from uniform instead
      obj.pp_UU{i} = randn(obj.n_pp_UU, obj.D_L_U + obj.D_L_U);
    end
  end

end

