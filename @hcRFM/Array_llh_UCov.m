function llh = Array_llh_UCov( obj )
%Array_llh_UCov llh for U covariate data
% Called when hyperparameters change
%
% James Lloyd, June 2012

  llh = 0;
  % For each array of data
  for i = 1:length(obj.data_UCov.train_X_v)
    % Normal distribution of GP - using cholesky for numerical stability
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_UCov{i}))) - ...
                0.5*(obj.T_UCov{i}'*solve_chol(obj.chol_K_pp_pp_UCov{i}, obj.T_UCov{i}));
    % Data llh
    obj.W_UCov{i} = obj.K_ip_pp_UCov{i} * (obj.K_pp_pp_UCov{i} \ obj.T_UCov{i});
    params.precision = obj.DataPrecision_UCov{i};
    llh = llh + Cond_llh_2array (obj.W_UCov{i}, obj.data_UCov.train_X_v{i}, ...
                                 obj.ObservationModel_UCov{i}, params);
  end
  if ~isempty(obj.data_UCov.train_X_v)
    llh = llh + obj.arrayKern_UCov.Prior;
  end

end

