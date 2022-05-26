function llh = Cond_llh_ArrayParams_VV( obj, new_params )
%Cond_llh_ArrayParams_VV Conditional llh for updating array kernel parameters
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % Update cached quantities
  obj.arrayKern_VV.params = new_params(1:(end-1));
  obj.arrayKern_VV.diagNoise = new_params(end);
  obj.UpdateKernelMatrices_VV;
  % Calculate complete likelihood - relating to row data
  llh = obj.Array_llh_VV;
end

