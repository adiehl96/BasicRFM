function llh = Prior_V( obj )
%Prior_V Calculates prior llh of variable V
% Normal distribution
%
% Written by James Lloyd, June 2012
  llh = - 0.5 * (obj.V(:)' * obj.V(:)) / (obj.V_sd ^ 2);
end

