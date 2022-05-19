function prediction = Prediction( obj )
%Prediction Makes a prediction about test data
% Detailed explanation goes here
%
% James Lloyd, June 2012
  
  prediction.UU = cell(0);
  prediction.VV = cell(0);
  prediction.UV = cell(0);
  prediction.UCov = cell(0);
  prediction.VCov = cell(0);

  for i = 1:length(obj.data_UU.test_X_v)
    obj.pred_ip_UU{i} = CreateGPInputPoints (obj.data_UU.test_X_i{i}, ...
                                             obj.data_UU.test_X_j{i}, obj.U);
    obj.K_pred_pp_UU{i} = obj.arrayKern_UU.Matrix (obj.pred_ip_UU{i}, obj.pp_UU{i});
    switch obj.ObservationModel_UU
      case ObservationModels.Logit
        obj.prediction_UU{i} = logistic(obj.K_pred_pp_UU{i} * ...
                                       (obj.K_pp_pp_UU{i} \ obj.T_UU{i}), 1);
      case ObservationModels.Gaussian
        obj.prediction_UU{i} = obj.K_pred_pp_UU{i} * (obj.K_pp_pp_UU{i} \ obj.T_UU{i});
        % Add noise to express uncertainty
%         obj.prediction_UU{i} = obj.prediction_UU{i} + ...
%                                (1 / sqrt(obj.DataPrecision_UU)) * randn(size(obj.prediction_UU{i}));
      case ObservationModels.Poisson
        % Conditional mean
        obj.prediction_UU{i} = exp(obj.K_pred_pp_UU{i} * (obj.K_pp_pp_UU{i} \ obj.T_UU{i}));
        % Sample some Poissons
%         obj.prediction_UU{i} = poissrnd(exp(obj.K_pred_pp_UU{i} * (obj.K_pp_pp_UU{i} \ obj.T_UU{i})));
    end
  end
  prediction.UU = obj.prediction_UU;
  
    
  for i = 1:length(obj.data_UCov.test_X_v)
    obj.pred_ip_UCov{i} = obj.U(obj.data_UCov.test_X_i{i}, :);
    obj.K_pred_pp_UCov{i} = obj.arrayKern_UCov.Matrix (obj.pred_ip_UCov{i}, obj.pp_UCov{i});
    switch obj.ObservationModel_UCov{i}
      case ObservationModels.Logit
        obj.prediction_UCov{i} = logistic(obj.K_pred_pp_UCov{i} * ...
                                       (obj.K_pp_pp_UCov{i} \ obj.T_UCov{i}), 1);
      case ObservationModels.Gaussian
        obj.prediction_UCov{i} = obj.K_pred_pp_UCov{i} * (obj.K_pp_pp_UCov{i} \ obj.T_UCov{i});
        % Add noise to express uncertainty
%         obj.prediction_UCov{i} = obj.prediction_UCov{i} + ...
%          (1 / sqrt(obj.DataPrecision_UCov{i})) * randn(size(obj.prediction_UCov{i}));
      case ObservationModels.Poisson
        % Conditional mean
        obj.prediction_UCov{i} = exp(obj.K_pred_pp_UCov{i} * (obj.K_pp_pp_UCov{i} \ obj.T_UCov{i}));
        % Sample some Poissons
%         obj.prediction_UCov{i} = poissrnd(exp(obj.K_pred_pp_UCov{i} * (obj.K_pp_pp_UCov{i} \ obj.T_UCov{i})));
    end
  end
  prediction.UCov = obj.prediction_UCov;

end

