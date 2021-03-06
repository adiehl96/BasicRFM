function llh = llh( obj )
%LLH ~Returns complete llh of current state - uses cache
% Detailed explanation goes here
%
% James Lloyd, July 2012
  
  llh = 0;
  
  llh = llh + obj.arrayKern_UU.Prior;
  
  llh = llh + obj.Prior_U;
  
  for i = 1:length(obj.data_UU.train_X_v)
    llh = llh + obj.Prior_pp_UU (i);
    llh = llh - sum(log(diag(obj.chol_K_pp_pp_UU{i}))) - ...
                0.5*(obj.T_UU{i}'*solve_chol(obj.chol_K_pp_pp_UU{i}, obj.T_UU{i}));
    params.precision = obj.DataPrecision_UU;
    obj.UpdateW_UU;
    llh = llh + Cond_llh_2array (obj.W_UU{i}, obj.data_UU.train_X_v{i}, ...
                                 obj.ObservationModel_UU, params);
  end
end

