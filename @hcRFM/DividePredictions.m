function P_Div = DividePredictions( obj, P, Divisor )
%DividePredictions Summary of this function goes here
%   Detailed explanation goes here

  P_Div.UU = cell(0);
  P_Div.UCov = cell(0);

  for i = 1:length(P.UU)
    P_Div.UU{i} = P.UU{i} / Divisor;
  end
  for i = 1:length(P.UCov)
    P_Div.UCov{i} = P.UCov{i} / Divisor;
  end

end

