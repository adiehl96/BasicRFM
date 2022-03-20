function Init_Cache( obj )
%Init_Cache Initialise cached matrices etc.
% Deatiled description goes here
%
% James Lloyd, June 2012

  % UU array cached quantities
  obj.ip_UU = cell(length(obj.data_UU.train_X_v), 1);
  obj.pred_ip_UU = cell(length(obj.data_UU.train_X_v), 1);
  obj.W_UU  = cell(length(obj.data_UU.train_X_v), 1);
  obj.prediction_UU  = cell(length(obj.data_UU.train_X_v), 1);
  for i = 1:length(obj.ip_UU)
    obj.ip_UU{i} = CreateGPInputPoints (obj.data_UU.train_X_i{i}, ...
                                        obj.data_UU.train_X_j{i}, ...
                                        obj.U);
    obj.pred_ip_UU{i} = CreateGPInputPoints (obj.data_UU.test_X_i{i}, ...
                                             obj.data_UU.test_X_j{i}, ...
                                             obj.U);
    obj.W_UU{i} = zeros(length(obj.data_UU.train_X_i{i}), 1);
    obj.prediction_UU{i} = zeros(length(obj.data_UU.test_X_i{i}), 1);
    obj.K_ip_pp_UU{i} = obj.arrayKern_UU.Matrix (obj.ip_UU{i}, obj.pp_UU{i});
    obj.K_pp_pp_UU{i} = obj.arrayKern_UU.Matrix (obj.pp_UU{i});
    obj.chol_K_pp_pp_UU{i} = chol(obj.K_pp_pp_UU{i});
    obj.K_pred_pp_UU{i} = obj.arrayKern_UU.Matrix (obj.pred_ip_UU{i}, obj.pp_UU{i});
  end

  % VV array cached quantities
  obj.ip_VV = cell(length(obj.data_VV.train_X_v), 1);
  obj.pred_ip_VV = cell(length(obj.data_VV.train_X_v), 1);
  obj.W_VV  = cell(length(obj.data_VV.train_X_v), 1);
  obj.prediction_VV  = cell(length(obj.data_VV.train_X_v), 1);
  for i = 1:length(obj.ip_VV)
    obj.ip_VV{i} = CreateGPInputPoints (obj.data_VV.train_X_i{i}, ...
                                        obj.data_VV.train_X_j{i}, ...
                                        obj.V);
    obj.pred_ip_VV{i} = CreateGPInputPoints (obj.data_VV.test_X_i{i}, ...
                                             obj.data_VV.test_X_j{i}, ...
                                             obj.V);
    obj.W_VV{i} = zeros(length(obj.data_VV.train_X_i{i}), 1);
    obj.prediction_VV{i} = zeros(length(obj.data_VV.test_X_i{i}), 1);
    obj.K_ip_pp_VV{i} = obj.arrayKern_VV.Matrix (obj.ip_VV{i}, obj.pp_VV{i});
    obj.K_pp_pp_VV{i} = obj.arrayKern_VV.Matrix (obj.pp_VV{i});
    obj.chol_K_pp_pp_VV{i} = chol(obj.K_pp_pp_VV{i});
    obj.K_pred_pp_VV{i} = obj.arrayKern_VV.Matrix (obj.pred_ip_VV{i}, obj.pp_VV{i});
  end

  % UV array cached quantities
  obj.ip_UV = cell(length(obj.data_UV.train_X_v), 1);
  obj.pred_ip_UV = cell(length(obj.data_UV.train_X_v), 1);
  obj.W_UV  = cell(length(obj.data_UV.train_X_v), 1);
  obj.prediction_UV  = cell(length(obj.data_UV.train_X_v), 1);
  for i = 1:length(obj.ip_UV)
    obj.ip_UV{i} = CreateGPInputPoints (obj.data_UV.train_X_i{i}, ...
                                        obj.data_UV.train_X_j{i}, ...
                                        obj.U, obj.V);
    obj.pred_ip_UV{i} = CreateGPInputPoints (obj.data_UV.test_X_i{i}, ...
                                             obj.data_UV.test_X_j{i}, ...
                                             obj.U, obj.V);
    obj.W_UV{i} = zeros(length(obj.data_UV.train_X_i{i}), 1);
    obj.prediction_UV{i} = zeros(length(obj.data_UV.test_X_i{i}), 1);
    obj.K_ip_pp_UV{i} = obj.arrayKern_UV.Matrix (obj.ip_UV{i}, obj.pp_UV{i});
    obj.K_pp_pp_UV{i} = obj.arrayKern_UV.Matrix (obj.pp_UV{i});
    obj.chol_K_pp_pp_UV{i} = chol(obj.K_pp_pp_UV{i});
    obj.K_pred_pp_UV{i} = obj.arrayKern_UV.Matrix (obj.pred_ip_UV{i}, obj.pp_UV{i});
  end

  % UCov array cached quantities
  obj.ip_UCov = cell(length(obj.data_UCov.train_X_v), 1);
  obj.pred_ip_UCov = cell(length(obj.data_UCov.train_X_v), 1);
  obj.W_UCov  = cell(length(obj.data_UCov.train_X_v), 1);
  obj.prediction_UCov  = cell(length(obj.data_UCov.train_X_v), 1);
  for i = 1:length(obj.ip_UCov)
    obj.ip_UCov{i} = obj.U(obj.data_UCov.train_X_i{i}, :);
    obj.pred_ip_UCov{i} = obj.U(obj.data_UCov.test_X_i{i}, :);
    obj.W_UCov{i} = zeros(length(obj.data_UCov.train_X_i{i}), 1);
    obj.prediction_UCov{i} = zeros(length(obj.data_UCov.test_X_i{i}), 1);
    obj.K_ip_pp_UCov{i} = obj.arrayKern_UCov.Matrix (obj.ip_UCov{i}, obj.pp_UCov{i});
    obj.K_pp_pp_UCov{i} = obj.arrayKern_UCov.Matrix (obj.pp_UCov{i});
    obj.chol_K_pp_pp_UCov{i} = chol(obj.K_pp_pp_UCov{i});
    obj.K_pred_pp_UCov{i} = obj.arrayKern_UCov.Matrix (obj.pred_ip_UCov{i}, obj.pp_UCov{i});
  end

  % VCov array cached quantities
  obj.ip_VCov = cell(length(obj.data_VCov.train_X_v), 1);
  obj.pred_ip_VCov = cell(length(obj.data_VCov.train_X_v), 1);
  obj.W_VCov  = cell(length(obj.data_VCov.train_X_v), 1);
  obj.prediction_VCov  = cell(length(obj.data_VCov.train_X_v), 1);
  for i = 1:length(obj.ip_VCov)
    obj.ip_VCov{i} = obj.V(obj.data_VCov.train_X_i{i}, :);
    obj.pred_ip_VCov{i} = obj.V(obj.data_VCov.test_X_i{i}, :);
    obj.W_VCov{i} = zeros(length(obj.data_VCov.train_X_i{i}), 1);
    obj.prediction_VCov{i} = zeros(length(obj.data_VCov.test_X_i{i}), 1);
    obj.K_ip_pp_VCov{i} = obj.arrayKern_VCov.Matrix (obj.ip_VCov{i}, obj.pp_VCov{i});
    obj.K_pp_pp_VCov{i} = obj.arrayKern_VCov.Matrix (obj.pp_VCov{i});
    obj.chol_K_pp_pp_VCov{i} = chol(obj.K_pp_pp_VCov{i});
    obj.K_pred_pp_VCov{i} = obj.arrayKern_VCov.Matrix (obj.pred_ip_VCov{i}, obj.pp_VCov{i});
  end
end

