function llh = Cond_llh_pp_VV( obj, pp_index, array_index )
%Cond_llh_pp_VV Calculate llh when pseudo points change
% Detailed explanation goes here
%
% James Lloyd, June 2012

%   i = array_index;
  obj.UpdateKernelMatrices_pp_VV (pp_index, array_index);
%   % Normal distribution of GP - using cholesky for numerical stability
%   % In future, make use of rank 1 updates
%   llh = - sum(log(diag(obj.chol_K_pp_pp_VV{i}))) - ...
%           0.5*(obj.T_VV{i}'*solve_chol(obj.chol_K_pp_pp_VV{i}, obj.T_VV{i}));
%   % Data llh
%   obj.W_VV{i} = obj.K_ip_pp_VV{i} * (obj.K_pp_pp_VV{i} \ obj.T_VV{i});
%   params.precision = obj.DataPrecision_VV;
%   llh = llh + Cond_llh_2array (obj.W_VV{i}, obj.data_VV.train_X_v{i}, ...
%                                obj.ObservationModel_VV, params);
%   % Prior for pseudo points
%   llh = llh + obj.Prior_pp_VV (i); % TODO - This could be slightly more efficient
  llh = obj.Cond_llh_pp_VV_No_Update (pp_index, array_index);

end

