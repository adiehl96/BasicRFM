function llh = Cond_llh_ArrayParams_UU( obj, new_params )
%Cond_llh_ArrayParams_UU Conditional llh for updating array kernel parameters
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % Update cached quantities
  obj.arrayKern_UU.params = new_params(1:(end-1));
  obj.arrayKern_UU.diagNoise = new_params(end);
  obj.UpdateKernelMatrices_UU;
  % Calculate complete likelihood - relating to row data
  llh = obj.Array_llh_UU;
end

