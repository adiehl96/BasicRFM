function UpdateW_UV( obj )
%UpdateW_UV Caches the current predictions
% Detailed explanation goes here
%
% James Lloyd, July 2012

  for i = 1:length(obj.T_UV)
    % Precompute SoR mapping
    obj.W_UV{i} = obj.K_ip_pp_UV{i} * (obj.K_pp_pp_UV{i} \ obj.T_UV{i});
  end

end

