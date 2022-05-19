function new_RFM = Duplicate( obj )
%DUPLICATE Create a new object with identical values
% Note, does not copy cache - this must be instantiated separately
%
% James Lloyd

  %%%% TODO - Probably should copy the cache as well
  %%%% This function should always be tested for updates

  % Create new object
  new_RFM = hcRFM;

  % Set simple values (excluding cache)

  new_RFM.D_L_U = obj.D_L_U;
  new_RFM.n_pp_UU = obj.n_pp_UU;
  new_RFM.ObservationModel_UU = obj.ObservationModel_UU;
  new_RFM.DataPrecision_UU = obj.DataPrecision_UU;
  new_RFM.arrayKern_UU = obj.arrayKern_UU;
  new_RFM.U_sd = obj.U_sd;
  new_RFM.pp_UU_sd = obj.pp_UU_sd;
  new_RFM.U = obj.U;
  new_RFM.pp_UU = obj.pp_UU;
  new_RFM.T_UU = obj.T_UU;

  % Duplicate data objects

  new_RFM.data_UU = obj.data_UU.Duplicate;

end

