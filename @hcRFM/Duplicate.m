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
  new_RFM.D_L_V = obj.D_L_V;
  new_RFM.n_pp_UU = obj.n_pp_UU;
  new_RFM.n_pp_VV = obj.n_pp_VV;
  new_RFM.n_pp_UV = obj.n_pp_UV;
  new_RFM.n_pp_UCov = obj.n_pp_UCov;
  new_RFM.n_pp_VCov = obj.n_pp_VCov;
  new_RFM.ObservationModel_UU = obj.ObservationModel_UU;
  new_RFM.ObservationModel_VV = obj.ObservationModel_VV;
  new_RFM.ObservationModel_UV = obj.ObservationModel_UV;
  new_RFM.ObservationModel_UCov = obj.ObservationModel_UCov;
  new_RFM.ObservationModel_VCov = obj.ObservationModel_VCov;
  new_RFM.DataPrecision_UU = obj.DataPrecision_UU;
  new_RFM.DataPrecision_VV = obj.DataPrecision_VV;
  new_RFM.DataPrecision_UV = obj.DataPrecision_UV;
  new_RFM.DataPrecision_UCov = obj.DataPrecision_UCov;
  new_RFM.DataPrecision_VCov = obj.DataPrecision_VCov;
  new_RFM.arrayKern_UU = obj.arrayKern_UU;
  new_RFM.arrayKern_VV = obj.arrayKern_VV;
  new_RFM.arrayKern_UV = obj.arrayKern_UV;
  new_RFM.arrayKern_UCov = obj.arrayKern_UCov;
  new_RFM.arrayKern_VCov = obj.arrayKern_VCov;
  new_RFM.U_sd = obj.U_sd;
  new_RFM.V_sd = obj.V_sd;
  new_RFM.pp_UU_sd = obj.pp_UU_sd;
  new_RFM.pp_VV_sd = obj.pp_VV_sd;
  new_RFM.pp_UV_sd = obj.pp_UV_sd;
  new_RFM.pp_UCov_sd = obj.pp_UCov_sd;
  new_RFM.pp_VCov_sd = obj.pp_VCov_sd;
  new_RFM.U = obj.U;
  new_RFM.V = obj.V;
  new_RFM.pp_UU = obj.pp_UU;
  new_RFM.pp_VV = obj.pp_VV;
  new_RFM.pp_UV = obj.pp_UV;
  new_RFM.pp_UCov = obj.pp_UCov;
  new_RFM.pp_VCov = obj.pp_VCov;
  new_RFM.T_UU = obj.T_UU;
  new_RFM.T_VV = obj.T_VV;
  new_RFM.T_UV = obj.T_UV;
  new_RFM.T_UCov = obj.T_UCov;
  new_RFM.T_VCov = obj.T_VCov;

  % Duplicate data objects

  new_RFM.data_UU = obj.data_UU.Duplicate;
  new_RFM.data_VV = obj.data_VV.Duplicate;
  new_RFM.data_UV = obj.data_UV.Duplicate;
  new_RFM.data_UCov = obj.data_UCov.Duplicate;
  new_RFM.data_VCov = obj.data_VCov.Duplicate;

end

