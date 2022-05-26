function llh = llh( obj )
%LLH ~Returns complete llh of current state - uses cache
% Detailed explanation goes here
%
% James Lloyd, July 2012
  
  llh = 0;
  
  llh = llh + obj.arrayKern_UU.Prior;
  llh = llh + obj.arrayKern_UV.Prior;
  llh = llh + obj.arrayKern_VV.Prior;
  llh = llh + obj.arrayKern_UCov.Prior;
  llh = llh + obj.arrayKern_VCov.Prior;
  
  llh = llh + obj.Prior_U;
  llh = llh + obj.Prior_V;
  
  for i = 1:length(obj.data_UU.train_X_v)
    llh = llh + obj.Prior_pp_UU (i);
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_UU{i}))) - ...
                0.5*(obj.T_UU{i}'*solve_chol(obj.chol_K_pp_pp_UU{i}, obj.T_UU{i}));
    params.precision = obj.DataPrecision_UU;
    obj.UpdateW_UU;
    llh = llh + Cond_llh_2array (obj.W_UU{i}, obj.data_UU.train_X_v{i}, ...
                                 obj.ObservationModel_UU, params);
  end
  
  for i = 1:length(obj.data_UV.train_X_v)
    llh = llh + obj.Prior_pp_UV (i);
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_UV{i}))) - ...
                0.5*(obj.T_UV{i}'*solve_chol(obj.chol_K_pp_pp_UV{i}, obj.T_UV{i}));
    params.precision = obj.DataPrecision_UV;
    obj.UpdateW_UV;
    llh = llh + Cond_llh_2array (obj.W_UV{i}, obj.data_UV.train_X_v{i}, ...
                                 obj.ObservationModel_UV, params);
  end
  
  for i = 1:length(obj.data_VV.train_X_v)
    llh = llh + obj.Prior_pp_VV (i);
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_VV{i}))) - ...
                0.5*(obj.T_VV{i}'*solve_chol(obj.chol_K_pp_pp_VV{i}, obj.T_VV{i}));
    params.precision = obj.DataPrecision_VV;
    obj.UpdateW_VV;
    llh = llh + Cond_llh_2array (obj.W_VV{i}, obj.data_VV.train_X_v{i}, ...
                                 obj.ObservationModel_VV, params);
  end
  
  for i = 1:length(obj.data_UCov.train_X_v)
    llh = llh + obj.Prior_pp_UCov (i);
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_UCov{i}))) - ...
                0.5*(obj.T_UCov{i}'*solve_chol(obj.chol_K_pp_pp_UCov{i}, obj.T_UCov{i}));
    params.precision = obj.DataPrecision_UCov{i};
    obj.UpdateW_UCov;
    llh = llh + Cond_llh_2array (obj.W_UCov{i}, obj.data_UCov.train_X_v{i}, ...
                                 obj.ObservationModel_UCov{i}, params);
  end
  
  for i = 1:length(obj.data_VCov.train_X_v)
    llh = llh + obj.Prior_pp_VCov (i);
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_VCov{i}))) - ...
                0.5*(obj.T_VCov{i}'*solve_chol(obj.chol_K_pp_pp_VCov{i}, obj.T_VCov{i}));
    params.precision = obj.DataPrecision_VCov{i};
    obj.UpdateW_VCov;
    llh = llh + Cond_llh_2array (obj.W_VCov{i}, obj.data_VCov.train_X_v{i}, ...
                                 obj.ObservationModel_VCov{i}, params);
  end

end

