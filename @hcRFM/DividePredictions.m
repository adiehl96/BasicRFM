function P_Div = DividePredictions( obj, P, Divisor )
%DividePredictions Summary of this function goes here
%   Detailed explanation goes here

  P_Div.UU = cell(0);

  for i = 1:length(P.UU)
    P_Div.UU{i} = P.UU{i} / Divisor;
  end

end

