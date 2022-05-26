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
  
  for i = 1:length(obj.data_VV.test_X_v)
    obj.pred_ip_VV{i} = CreateGPInputPoints (obj.data_VV.test_X_i{i}, ...
                                             obj.data_VV.test_X_j{i}, obj.V);
    obj.K_pred_pp_VV{i} = obj.arrayKern_VV.Matrix (obj.pred_ip_VV{i}, obj.pp_VV{i});
    switch obj.ObservationModel_VV
      case ObservationModels.Logit
        obj.prediction_VV{i} = logistic(obj.K_pred_pp_VV{i} * ...
                                       (obj.K_pp_pp_VV{i} \ obj.T_VV{i}), 1);
      case ObservationModels.Gaussian
        obj.prediction_VV{i} = obj.K_pred_pp_VV{i} * (obj.K_pp_pp_VV{i} \ obj.T_VV{i});
        % Add noise to express uncertainty
%         obj.prediction_VV{i} = obj.prediction_VV{i} + ...
%                                (1 / sqrt(obj.DataPrecision_VV)) * randn(size(obj.prediction_VV{i}));
      case ObservationModels.Poisson
        % Conditional mean
        obj.prediction_VV{i} = exp(obj.K_pred_pp_VV{i} * (obj.K_pp_pp_VV{i} \ obj.T_VV{i}));
        % Sample some Poissons
%         obj.prediction_VV{i} = poissrnd(exp(obj.K_pred_pp_VV{i} * (obj.K_pp_pp_VV{i} \ obj.T_VV{i})));
    end
  end
  prediction.VV = obj.prediction_VV;
  
  for i = 1:length(obj.data_UV.test_X_v)
    obj.pred_ip_UV{i} = CreateGPInputPoints (obj.data_UV.test_X_i{i}, ...
                                             obj.data_UV.test_X_j{i}, obj.U, obj.V);
    obj.K_pred_pp_UV{i} = obj.arrayKern_UV.Matrix (obj.pred_ip_UV{i}, obj.pp_UV{i});
    switch obj.ObservationModel_UV
      case ObservationModels.Logit
        obj.prediction_UV{i} = logistic(obj.K_pred_pp_UV{i} * ...
                                       (obj.K_pp_pp_UV{i} \ obj.T_UV{i}), 1);
      case ObservationModels.Gaussian
        obj.prediction_UV{i} = obj.K_pred_pp_UV{i} * (obj.K_pp_pp_UV{i} \ obj.T_UV{i});
        % Add noise to express uncertainty
%         obj.prediction_UV{i} = obj.prediction_UV{i} + ...
%                                (1 / sqrt(obj.DataPrecision_UV)) * randn(size(obj.prediction_UV{i}));
      case ObservationModels.Poisson
        % Conditional mean
        obj.prediction_UV{i} = exp(obj.K_pred_pp_UV{i} * (obj.K_pp_pp_UV{i} \ obj.T_UV{i}));
        % Sample some Poissons
%         obj.prediction_UV{i} = poissrnd(exp(obj.K_pred_pp_UV{i} * (obj.K_pp_pp_UV{i} \ obj.T_UV{i})));
    end
  end
  prediction.UV = obj.prediction_UV;
  
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
  
  for i = 1:length(obj.data_VCov.test_X_v)
    obj.pred_ip_VCov{i} = obj.V(obj.data_VCov.test_X_i{i}, :);
    obj.K_pred_pp_VCov{i} = obj.arrayKern_VCov.Matrix (obj.pred_ip_VCov{i}, obj.pp_VCov{i});
    switch obj.ObservationModel_VCov{i}
      case ObservationModels.Logit
        obj.prediction_VCov{i} = logistic(obj.K_pred_pp_VCov{i} * ...
                                       (obj.K_pp_pp_VCov{i} \ obj.T_VCov{i}), 1);
      case ObservationModels.Gaussian
        obj.prediction_VCov{i} = obj.K_pred_pp_VCov{i} * (obj.K_pp_pp_VCov{i} \ obj.T_VCov{i});
%         obj.prediction_VCov{i} = obj.prediction_VCov{i} + ...
%          (1 / sqrt(obj.DataPrecision_VCov{i})) * randn(size(obj.prediction_VCov{i}));
      case ObservationModels.Poisson
        % Conditional mean
        obj.prediction_VCov{i} = exp(obj.K_pred_pp_VCov{i} * (obj.K_pp_pp_VCov{i} \ obj.T_VCov{i}));
        % Sample some Poissons
%         obj.prediction_VCov{i} = poissrnd(exp(obj.K_pred_pp_VCov{i} * (obj.K_pp_pp_VCov{i} \ obj.T_VCov{i})));
    end
  end
  prediction.VCov = obj.prediction_VCov;
end

