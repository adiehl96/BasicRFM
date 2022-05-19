function SS_ArrayKernParams( obj, widths, step_out, max_attempts )
%SS_ARRAYKERNPARAMS Independently slice sample the array kernel parameters
% Detailed explanation goes here
%
% James Lloyd, June 2012

  % Create likelihood function
  slice_fn = @(x) obj.Cond_llh_ArrayParams_UU(x);
  % Slice sample - 1 sample, zero burn in
  x = slice_sample_max (1, 0, slice_fn, ...
                        [obj.arrayKern_UU.params; obj.arrayKern_UU.diagNoise], ...
                        widths.UU, step_out, max_attempts);
  % Extract output
  obj.arrayKern_UU.params = x(1:(end-1));
  obj.arrayKern_UU.diagNoise = x(end);
  % Update cached quantities
  obj.UpdateKernelMatrices_UU;



  % Create likelihood function
  slice_fn = @(x) obj.Cond_llh_ArrayParams_UCov(x);
  % Slice sample - 1 sample, zero burn in
  x = slice_sample_max (1, 0, slice_fn, ...
                        [obj.arrayKern_UCov.params; obj.arrayKern_UCov.diagNoise], ...
                        widths.UCov, step_out, max_attempts);
  % Extract output
  obj.arrayKern_UCov.params = x(1:(end-1));
  obj.arrayKern_UCov.diagNoise = x(end);
  % Update cached quantities
  obj.UpdateKernelMatrices_UCov;  
  
end

