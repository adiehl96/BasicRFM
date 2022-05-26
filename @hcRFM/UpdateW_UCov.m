function UpdateW_UCov( obj )
%UpdateW_UCov Caches the current predictions
% Detailed explanation goes here
%
% James Lloyd, July 2012

  for i = 1:length(obj.T_UCov)
    % Precompute SoR mapping
    obj.W_UCov{i} = obj.K_ip_pp_UCov{i} * (obj.K_pp_pp_UCov{i} \ obj.T_UCov{i});
  end

end

