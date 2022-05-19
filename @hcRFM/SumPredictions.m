function P_Sum = SumPredictions( obj, P1, P2 )
%SUMPREDICTIONS Summary of this function goes here
%   Detailed explanation goes here

  P_Sum.UU = cell(0);

  for i = 1:length(P1.UU)
    P_Sum.UU{i} = P1.UU{i} + P2.UU{i};
  end

end

