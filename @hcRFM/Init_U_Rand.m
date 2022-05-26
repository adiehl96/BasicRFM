function Init_U_Rand( obj )
%INIT_U_Rand Randomly initialise U - temporary function
% Write a description of all variables here
%
% James Lloyd, June 2012

  if ~isempty(obj.data_UU.M)
    rows = obj.data_UU.M{1};
  elseif ~isempty(obj.data_UV.M)
    rows = obj.data_UV.M{1};
  elseif ~isempty(obj.data_UCov.M)
    rows = obj.data_UCov.M{1};
  else
    rows = 0;
  end

  obj.U = randn(rows, obj.D_L_U);
end

