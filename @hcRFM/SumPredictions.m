function P_Sum = SumPredictions( obj, P1, P2 )
%SUMPREDICTIONS Summary of this function goes here
%   Detailed explanation goes here

  P_Sum.UU = cell(0);
  P_Sum.VV = cell(0);
  P_Sum.UV = cell(0);
  P_Sum.UCov = cell(0);
  P_Sum.VCov = cell(0);

  for i = 1:length(P1.UU)
    P_Sum.UU{i} = P1.UU{i} + P2.UU{i};
  end
  for i = 1:length(P1.VV)
    P_Sum.VV{i} = P1.VV{i} + P2.VV{i};
  end
  for i = 1:length(P1.UV)
    P_Sum.UV{i} = P1.UV{i} + P2.UV{i};
  end
  for i = 1:length(P1.UCov)
    P_Sum.UCov{i} = P1.UCov{i} + P2.UCov{i};
  end
  for i = 1:length(P1.VCov)
    P_Sum.VCov{i} = P1.VCov{i} + P2.VCov{i};
  end

end

