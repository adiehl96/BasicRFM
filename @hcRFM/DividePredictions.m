function P_Div = DividePredictions( obj, P, Divisor )
%DividePredictions Summary of this function goes here
%   Detailed explanation goes here

  P_Div.UU = cell(0);
  P_Div.VV = cell(0);
  P_Div.UV = cell(0);
  P_Div.UCov = cell(0);
  P_Div.VCov = cell(0);

  for i = 1:length(P.UU)
    P_Div.UU{i} = P.UU{i} / Divisor;
  end
  for i = 1:length(P.VV)
    P_Div.VV{i} = P.VV{i} / Divisor;
  end
  for i = 1:length(P.UV)
    P_Div.UV{i} = P.UV{i} / Divisor;
  end
  for i = 1:length(P.UCov)
    P_Div.UCov{i} = P.UCov{i} / Divisor;
  end
  for i = 1:length(P.VCov)
    P_Div.VCov{i} = P.VCov{i} / Divisor;
  end

end

