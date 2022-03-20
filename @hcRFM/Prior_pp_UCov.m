function llh = Prior_pp_UCov( obj, index )
%PRIOR_pp Calculates prior llh of variable pseudo points
% Normal distribution
%
% Written by James Lloyd, June 2012
  llh = - 0.5 * (obj.pp_UCov{index}(:)' * obj.pp_UCov{index}(:)) / (obj.pp_UCov_sd ^ 2);
end

