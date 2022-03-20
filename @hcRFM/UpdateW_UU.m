function UpdateW_UU( obj )
%UpdateW_UU Caches the current predictions
% Detailed explanation goes here
%
% James Lloyd, July 2012

  for i = 1:length(obj.T_UU)
    % Precompute SoR mapping
    obj.W_UU{i} = obj.K_ip_pp_UU{i} * (obj.K_pp_pp_UU{i} \ obj.T_UU{i});
  end

end

