function llh = Prior_pp_UU( obj, index )
%PRIOR_pp Calculates prior llh of variable pseudo points
% Normal distribution
%
% Written by James Lloyd, June 2012
  llh = - 0.5 * (obj.pp_UU{index}(:)' * obj.pp_UU{index}(:)) / (obj.pp_UU_sd ^ 2);
end

