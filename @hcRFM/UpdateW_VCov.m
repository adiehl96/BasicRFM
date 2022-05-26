function UpdateW_VCov( obj )
%UpdateW_VCov Caches the current predictions
% Detailed explanation goes here
%
% James Lloyd, July 2012

  for i = 1:length(obj.T_VCov)
    % Precompute SoR mapping
    obj.W_VCov{i} = obj.K_ip_pp_VCov{i} * (obj.K_pp_pp_VCov{i} \ obj.T_VCov{i});
  end

end

