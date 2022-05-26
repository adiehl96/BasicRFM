function llh = Prior_pp_UV( obj, index )
%PRIOR_pp Calculates prior llh of variable pseudo points
% Normal distribution
%
% Written by James Lloyd, June 2012
  llh = - 0.5 * (obj.pp_UV{index}(:)' * obj.pp_UV{index}(:)) / (obj.pp_UV_sd ^ 2);
end

