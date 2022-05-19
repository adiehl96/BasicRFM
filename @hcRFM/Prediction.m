function prediction = Prediction( obj )
%Prediction Makes a prediction about test data
% Detailed explanation goes here
%
% James Lloyd, June 2012
  
  prediction.UU = cell(0);

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
end

