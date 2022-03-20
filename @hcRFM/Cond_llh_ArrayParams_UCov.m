function llh = Cond_llh_ArrayParams_UCov( obj, new_params )
%Cond_llh_ArrayParams_UCov Conditional llh for updating array kernel parameters
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % Update cached quantities
  obj.arrayKern_UCov.params = new_params(1:(end-1));
  obj.arrayKern_UCov.diagNoise = new_params(end);
  obj.UpdateKernelMatrices_UCov;
  % Calculate complete likelihood - relating to row data
  llh = obj.Array_llh_UCov;
end

