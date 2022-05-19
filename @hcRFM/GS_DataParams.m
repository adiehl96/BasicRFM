function GS_DataParams( obj )
%SS_ARRAYKERNPARAMS Independently slice sample the array kernel parameters
% Detailed explanation goes here
%
% James Lloyd, June 2012
  
  %%%% TODO - think about this section when adding more likelihoods
  obj.UpdateW_UCov;
  for i = 1:length(obj.ObservationModel_UCov)
    switch obj.ObservationModel_UCov{i}
      case ObservationModels.Gaussian
        a = 0 + 0.5 * length(obj.data_UCov.train_X_v{i});
        b = 0 + 0.5 * sum(sum((obj.data_UCov.train_X_v{i} - obj.W_UCov{i}) .^ 2));
        obj.DataPrecision_UCov{i} = randg (a) / b;
    end
  end
  
end

