function state = State( obj )
%STATE Bundles up the current state of the model
% Detailed explanation goes here
%
% James Lloyd, June 2012
  
  state.U = obj.U;
  state.V = obj.V;
  
  state.pp_UU = obj.pp_UU;
  state.T_UU = obj.T_UU;
  state.arrayKern_UU = obj.arrayKern_UU;
  state.DataPrecision_UU = obj.DataPrecision_UU;
  
  state.pp_VV = obj.pp_VV;
  state.T_VV = obj.T_VV;
  state.arrayKern_VV = obj.arrayKern_VV;
  state.DataPrecision_VV = obj.DataPrecision_VV;
  
  state.pp_UV = obj.pp_UV;
  state.T_UV = obj.T_UV;
  state.arrayKern_UV = obj.arrayKern_UV;
  state.DataPrecision_UV = obj.DataPrecision_UV;
  
  state.pp_UCov = obj.pp_UCov;
  state.T_UCov = obj.T_UCov;
  state.arrayKern_UCov = obj.arrayKern_UCov;
  state.DataPrecision_UCov = obj.DataPrecision_UCov;
  
  state.pp_VCov = obj.pp_VCov;
  state.T_VCov = obj.T_VCov;
  state.arrayKern_VCov = obj.arrayKern_VCov;
  state.DataPrecision_VCov = obj.DataPrecision_VCov;
  
  state.llh = obj.llh;
  
  %%%% TODO - add other things?
  
end

