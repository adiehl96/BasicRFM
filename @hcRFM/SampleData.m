function SampleData( obj )
%SAMPLEDATA Sample data conditional on parameters
% See... 
% ﻿Geweke, J. (2004). Getting It Right. Journal of the American Statistical Association,
% 99(467), 799-804. doi:10.1198/016214504000001132
% ...to learn why this is a good idea
%
% James Lloyd, July 2012

  % Update mean vectors
  for i = 1:length(obj.W_UU)
    obj.W_UU{i} = obj.K_ip_pp_UU{i} * (obj.K_pp_pp_UU{i} \ obj.T_UU{i});
  end
  
  % Sample data
  for i = 1:length(obj.W_UU)
    switch obj.ObservationModel_UU
      case ObservationModels.Logit
        obj.data_UU.train_X_v{i} = binornd(1, logistic(obj.W_UU{i}, 1));
      case ObservationModels.Gaussian
        obj.data_UU.train_X_v{i} = obj.W_UU{i} + ...
                                   (1 / sqrt(obj.DataPrecision_UU)) * randn(size(obj.W_UU{i}));
    end
  end

end

