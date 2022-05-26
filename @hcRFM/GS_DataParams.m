function GS_DataParams( obj )
%SS_ARRAYKERNPARAMS Independently slice sample the array kernel parameters
% Detailed explanation goes here
%
% James Lloyd, June 2012

  switch obj.ObservationModel_UU
    case ObservationModels.Gaussian
      % Update predictions
      obj.UpdateW_UU;
      % Calculate conditional posterior
      
      a = 0; % TODO - place a proper prior here
      b = 0; % TODO - place a proper prior here
      
      for i = 1:length(obj.W_UU)
        a = a + 0.5 * length(obj.data_UU.train_X_v{i});
        b = b + 0.5 * sum(sum((obj.data_UU.train_X_v{i} - obj.W_UU{i}) .^ 2));
      end
      % Sample
      obj.DataPrecision_UU = randg (a) / b;
  end

  switch obj.ObservationModel_VV
    case ObservationModels.Gaussian
      % Update predictions
      obj.UpdateW_VV;
      % Calculate conditional posterior
      
      a = 0; % TODO - place a proper prior here
      b = 0; % TODO - place a proper prior here
      
      for i = 1:length(obj.W_VV)
        a = a + 0.5 * length(obj.data_VV.train_X_v{i});
        b = b + 0.5 * sum(sum((obj.data_VV.train_X_v{i} - obj.W_VV{i}) .^ 2));
      end
      % Sample
      obj.DataPrecision_VV = randg (a) / b;
  end

  switch obj.ObservationModel_UV
    case ObservationModels.Gaussian
      % Update predictions
      obj.UpdateW_UV;
      % Calculate conditional posterior
      
      a = 0; % TODO - place a proper prior here
      b = 0; % TODO - place a proper prior here
      
      for i = 1:length(obj.W_UV)
        a = a + 0.5 * length(obj.data_UV.train_X_v{i});
        b = b + 0.5 * sum(sum((obj.data_UV.train_X_v{i} - obj.W_UV{i}) .^ 2));
      end
      % Sample
      obj.DataPrecision_UV = randg (a) / b;
  end
  
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

  %%%% TODO - think about this section when adding more likelihoods
  obj.UpdateW_VCov;
  for i = 1:length(obj.ObservationModel_VCov)
    switch obj.ObservationModel_VCov{i}
      case ObservationModels.Gaussian
        a = 0 + 0.5 * length(obj.data_VCov.train_X_v{i});
        b = 0 + 0.5 * sum(sum((obj.data_VCov.train_X_v{i} - obj.W_VCov{i}) .^ 2));
        obj.DataPrecision_VCov{i} = randg (a) / b;
    end
  end
  
end

