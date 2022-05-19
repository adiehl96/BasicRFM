function state = State( obj )
%STATE Bundles up the current state of the model
% Detailed explanation goes here
%
% James Lloyd, June 2012
  
  state.U = obj.U;
  
  state.pp_UU = obj.pp_UU;
  state.T_UU = obj.T_UU;
  state.arrayKern_UU = obj.arrayKern_UU;
  state.DataPrecision_UU = obj.DataPrecision_UU;
    
  state.pp_UCov = obj.pp_UCov;
  state.T_UCov = obj.T_UCov;
  state.arrayKern_UCov = obj.arrayKern_UCov;
  state.DataPrecision_UCov = obj.DataPrecision_UCov;
    
  state.llh = obj.llh;
  
  %%%% TODO - add other things?
  
end

