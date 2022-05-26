function llh = Cond_llh_ArrayParams_UV( obj, new_params )
%Cond_llh_ArrayParams_UV Conditional llh for updating array kernel parameters
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % Update cached quantities
  obj.arrayKern_UV.params = new_params(1:(end-1));
  obj.arrayKern_UV.diagNoise = new_params(end);
  obj.UpdateKernelMatrices_UV;
  % Calculate complete likelihood - relating to row data
  llh = obj.Array_llh_UV;
end

