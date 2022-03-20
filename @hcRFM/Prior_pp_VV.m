function llh = Prior_pp_VV( obj, index )
%PRIOR_pp Calculates prior llh of variable pseudo points
% Normal distribution
%
% Written by James Lloyd, June 2012
  llh = - 0.5 * (obj.pp_VV{index}(:)' * obj.pp_VV{index}(:)) / (obj.pp_VV_sd ^ 2);
end

