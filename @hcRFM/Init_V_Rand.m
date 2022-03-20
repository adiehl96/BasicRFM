function Init_V_Rand( obj )
%Init_V_Rand Randomly initialise V - temporary function
% Write a description of all variables here
%
% James Lloyd, June 2012

  if ~isempty(obj.data_VV.N)
    cols = obj.data_VV.N{1};
  elseif ~isempty(obj.data_UV.N)
    cols = obj.data_UV.N{1};
  elseif ~isempty(obj.data_VCov.M)
    cols = obj.data_VCov.M{1};
  else
    cols = 0;
  end

  obj.V = randn(cols, obj.D_L_V);
end

