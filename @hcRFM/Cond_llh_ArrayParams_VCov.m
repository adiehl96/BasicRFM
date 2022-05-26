function llh = Cond_llh_ArrayParams_VCov( obj, new_params )
%Cond_llh_ArrayParams_VCov Conditional llh for updating array kernel parameters
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % Update cached quantities
  obj.arrayKern_VCov.params = new_params(1:(end-1));
  obj.arrayKern_VCov.diagNoise = new_params(end);
  obj.UpdateKernelMatrices_VCov;
  % Calculate complete likelihood - relating to row data
  llh = obj.Array_llh_VCov;
end

