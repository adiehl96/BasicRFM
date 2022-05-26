function llh = Array_llh_VCov( obj )
%Array_llh_VCov llh for V covariate data
% Called when hyperparameters change
%
% James Lloyd, June 2012

  llh = 0;
  % For each array of data
  for i = 1:length(obj.data_VCov.train_X_v)
    % Normal distribution of GP - using cholesky for numerical stability
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_VCov{i}))) - ...
                0.5*(obj.T_VCov{i}'*solve_chol(obj.chol_K_pp_pp_VCov{i}, obj.T_VCov{i}));
    % Data llh
    obj.W_VCov{i} = obj.K_ip_pp_VCov{i} * (obj.K_pp_pp_VCov{i} \ obj.T_VCov{i});
    params.precision = obj.DataPrecision_VCov{i};
    llh = llh + Cond_llh_2array (obj.W_VCov{i}, obj.data_VCov.train_X_v{i}, ...
                                 obj.ObservationModel_VCov{i}, params);
  end
  if ~isempty(obj.data_VCov.train_X_v)
    llh = llh + obj.arrayKern_VCov.Prior;
  end

end

