function llh = Array_llh_UV( obj )
%Array_llh_UV llh for U x V relational data
% Called when hyperparameters change
%
% James Lloyd, June 2012

  llh = 0;
  % For each array of data
  for i = 1:length(obj.data_UV.train_X_v)
    % Normal distribution of GP - using cholesky for numerical stability
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_UV{i}))) - ...
                0.5*(obj.T_UV{i}'*solve_chol(obj.chol_K_pp_pp_UV{i}, obj.T_UV{i}));
    % Data llh
    obj.W_UV{i} = obj.K_ip_pp_UV{i} * (obj.K_pp_pp_UV{i} \ obj.T_UV{i});
    params.precision = obj.DataPrecision_UV;
    llh = llh + Cond_llh_2array (obj.W_UV{i}, obj.data_UV.train_X_v{i}, ...
                                 obj.ObservationModel_UV, params);
    
    llh = llh + obj.Prior_pp_UV (i);
  end
  if ~isempty(obj.data_UV.train_X_v)
    llh = llh + obj.arrayKern_UV.Prior;
  end

end

