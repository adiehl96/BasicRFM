function llh = Cond_llh_pp_UCov( obj, pp_index, array_index )
%Cond_llh_pp_UCov Calculate llh when pseudo points change
% Detailed explanation goes here
%
% James Lloyd, June 2012

%   i = array_index;
  obj.UpdateKernelMatrices_pp_UCov (pp_index, array_index);
%   % Normal distribution of GP - using cholesky for numerical stability
%   % In future, make use of rank 1 updates
%   llh = - sum(log(diag(obj.chol_K_pp_pp_UCov{i}))) - ...
%           0.5*(obj.T_UCov{i}'*solve_chol(obj.chol_K_pp_pp_UCov{i}, obj.T_UCov{i}));
%   % Data llh
%   obj.W_UCov{i} = obj.K_ip_pp_UCov{i} * (obj.K_pp_pp_UCov{i} \ obj.T_UCov{i});
%   params.precision = obj.DataPrecision_UCov{i};
%   llh = llh + Cond_llh_2array (obj.W_UCov{i}, obj.data_UCov.train_X_v{i}, ...
%                                obj.ObservationModel_UCov{i}, params);
%   % Prior for pseudo points
%   llh = llh + obj.Prior_pp_UCov (i); % TODO - This could be slightly more efficient

  llh = obj.Cond_llh_pp_UCov_No_Update (pp_index, array_index);

end

