function UpdateW_VV( obj )
%UpdateW_VV Caches the current predictions
% Detailed explanation goes here
%
% James Lloyd, July 2012

  for i = 1:length(obj.T_VV)
    % Precompute SoR mapping
    obj.W_VV{i} = obj.K_ip_pp_VV{i} * (obj.K_pp_pp_VV{i} \ obj.T_VV{i});
  end

end

