function llh = Cond_llh_pp_UU( obj, pp_index, array_index )
%Cond_llh_pp_UU Calculate llh when pseudo points change
% Detailed explanation goes here
%
% James Lloyd, June 2012

  %i = array_index;
  obj.UpdateKernelMatrices_pp_UU (pp_index, array_index);
  llh = obj.Cond_llh_pp_UU_No_Update (pp_index, array_index);

end

