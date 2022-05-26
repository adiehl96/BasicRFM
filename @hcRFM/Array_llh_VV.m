function llh = Array_llh_VV( obj )
%Array_llh_VV llh for V relational data
% Called when hyperparameters change
%
% James Lloyd, June 2012

  llh = 0;
  % For each array of data
  for i = 1:length(obj.data_VV.train_X_v)
    % Normal distribution of GP - using cholesky for numerical stability
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_VV{i}))) - ...
                0.5*(obj.T_VV{i}'*solve_chol(obj.chol_K_pp_pp_VV{i}, obj.T_VV{i}));
    % Data llh
    obj.W_VV{i} = obj.K_ip_pp_VV{i} * (obj.K_pp_pp_VV{i} \ obj.T_VV{i});
    params.precision = obj.DataPrecision_VV;
    llh = llh + Cond_llh_2array (obj.W_VV{i}, obj.data_VV.train_X_v{i}, ...
                                 obj.ObservationModel_VV, params);
    
    llh = llh + obj.Prior_pp_VV (i);
  end
  if ~isempty(obj.data_VV.train_X_v)
    llh = llh + obj.arrayKern_VV.Prior;
  end

end

