function Plot (obj)
%PLOT Currently assumes 1d embedding and 1 2-array
% Detailed explanation goes here
%
% James Lloyd, June 2012


  %%%% TODO - sort me out at some stage
  %%%% Useful to have some form of plotting - but what should we plot in
  %%%% high dimensions?
  
  if ~isempty(obj.data_UU.M)
  
    n_1d = 100;
    min_x = min(min(obj.ip_UU{1}));
    max_x = max(max(obj.ip_UU{1}));
    xrange = linspace( min_x, max_x, n_1d);

    [X1, X2] = meshgrid( xrange );
    TestPoints = [X1(:), X2(:)];

    K_tp_pp_UU = obj.arrayKern_UU.Matrix (TestPoints, obj.pp_UU{1});

    m = K_tp_pp_UU * (obj.K_pp_pp_UU{1} \ obj.T_UU{1});
    if obj.ObservationModel_UU == ObservationModels.Logit
      m = logistic(m);
    end

    X = reshape(TestPoints(:,1),n_1d,n_1d);
    Y = reshape(TestPoints(:,2),n_1d,n_1d);
    Z = reshape(m,n_1d,n_1d);

    surf(X, Y, Z, 'edgecolor', 'none');
    xlim([min_x max_x]);
    ylim([min_x max_x]);
    if obj.ObservationModel_UU == ObservationModels.Logit
      caxis([0, 1]);
      zlim([0, 1]);
    end
    colorbar;

    hold on;

    plot3(obj.ip_UU{1}(obj.data_UU.train_X_v{1}<=0,1), ...
          obj.ip_UU{1}(obj.data_UU.train_X_v{1}<=0,2), ...
          ones(sum(obj.data_UU.train_X_v{1}<=0),1) * (max(m) + 0.01), 'ko');
    plot3(obj.ip_UU{1}(obj.data_UU.train_X_v{1}>0,1), ...
          obj.ip_UU{1}(obj.data_UU.train_X_v{1}>0,2), ... 
          ones(sum(obj.data_UU.train_X_v{1}>0),1) * (max(m) + 0.01), 'wo');
    plot3(obj.pp_UU{1}(:,1), obj.pp_UU{1}(:,2), ...
          ones(length(obj.pp_UU{1}(:,1)), 1) * (max(m) + 0.01), 'gx');

    rotate3d ('on');

    hold off;
    view([90 90]);
    getframe;
end

