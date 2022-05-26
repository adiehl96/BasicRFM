function SampleStep( obj, i )
%SAMPLESTEP Perform one MCMC update at index i
% Detailed explanation goes here
%
% James Lloyd, July 2012

  if mod(i, obj.T_modulus) == 0 
    obj.RFM.ESS_T (round(obj.T_iterations / 2));
  end
  if mod(i, obj.LV_modulus) == 0 
    obj.RFM.SS_U (obj.U_width, obj.U_step_out, obj.U_max_attempts);
    obj.RFM.SS_V (obj.V_width, obj.V_step_out, obj.V_max_attempts);
  end
  if mod(i, obj.pp_modulus) == 0 
    obj.RFM.SS_pp (obj.pp_iterations, obj.pp_width, obj.pp_step_out, obj.pp_max_attempts, ...
                   obj.surf_sample);
  end
  if mod(i, obj.kern_par_modulus) == 0 
    obj.RFM.SS_ArrayKernParams (obj.kern_par_widths, obj.kern_par_step_out, ...
                                obj.kern_par_max_attempts);
  end
  if mod(i, obj.data_par_modulus) == 0 
    obj.RFM.GS_DataParams;
  end
  if mod(i, obj.T_modulus) == 0 
    obj.RFM.ESS_T (round(obj.T_iterations / 2));
  end

end

