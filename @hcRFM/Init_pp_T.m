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

  % Relating to VV array
  obj.pp_VV = cell(length(obj.data_VV.train_X_v), 1);
  obj.T_VV  = cell(length(obj.data_VV.train_X_v), 1);
  for i = 1:length(obj.pp_VV)
    % Initialise T as random normals
    obj.T_VV{i} = randn(obj.n_pp_VV, 1);
    perm = randperm(length(obj.data_VV.train_X_v{i}));
    rand_subset = perm(1:obj.n_pp_VV);
    % Initialise pseudo points as random subset of observations
    obj.pp_VV{i} = CreateGPInputPoints (obj.data_VV.train_X_i{i}(rand_subset), ...
                                        obj.data_VV.train_X_j{i}(rand_subset), ...
                                        obj.V);
  end

  % Relating to UV array
  obj.pp_UV = cell(length(obj.data_UV.train_X_v), 1);
  obj.T_UV  = cell(length(obj.data_UV.train_X_v), 1);
  for i = 1:length(obj.pp_UV)
    % Initialise T as random normals
    obj.T_UV{i} = randn(obj.n_pp_UV, 1);
    perm = randperm(length(obj.data_UV.train_X_v{i}));
    rand_subset = perm(1:obj.n_pp_UV);
    % Initialise pseudo points as random subset of observations
    obj.pp_UV{i} = CreateGPInputPoints (obj.data_UV.train_X_i{i}(rand_subset), ...
                                        obj.data_UV.train_X_j{i}(rand_subset), ...
                                        obj.U, obj.V);
  end

  % Relating to UCov array
  obj.pp_UCov = cell(length(obj.data_UCov.train_X_v), 1);
  obj.T_UCov  = cell(length(obj.data_UCov.train_X_v), 1);
  for i = 1:length(obj.pp_UCov)
    n_pp_UCov_min = min(obj.n_pp_UCov, length(obj.data_UCov.train_X_v{i}));
    % Initialise T as random normals
    obj.T_UCov{i} = randn(n_pp_UCov_min, 1);
    perm = randperm(length(obj.data_UCov.train_X_v{i}));
    rand_subset = perm(1:n_pp_UCov_min);
    % Initialise pseudo points as random subset of observations
    obj.pp_UCov{i} = obj.U(rand_subset, :);
  end

  % Relating to VCov array
  obj.pp_VCov = cell(length(obj.data_VCov.train_X_v), 1);
  obj.T_VCov  = cell(length(obj.data_VCov.train_X_v), 1);
  for i = 1:length(obj.pp_VCov)
    n_pp_VCov_min = min(obj.n_pp_VCov, length(obj.data_VCov.train_X_v{i}));
    % Initialise T as random normals
    obj.T_VCov{i} = randn(n_pp_VCov_min, 1);
    perm = randperm(length(obj.data_VCov.train_X_v{i}));
    rand_subset = perm(1:n_pp_VCov_min);
    % Initialise pseudo points as random subset of observations
    obj.pp_VCov{i} = obj.V(rand_subset, :);
  end
end

