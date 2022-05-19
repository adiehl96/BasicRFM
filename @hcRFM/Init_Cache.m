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
end

