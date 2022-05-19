function SS_pp( obj, iterations, width, step_out, max_attempts, surf )
%SS_pp Independently slice sample the GP pseudo points
% Detailed explanation goes here
%
% James Lloyd, June 2012

  if nargin < 6
    surf = true;
  end
  for dummy = 1:iterations
    for i = 1:length(obj.pp_UU)
      if surf
        obj.surf_slice_pp_UU( i, width, step_out, max_attempts);
      else
        obj.slice_pp_UU( i, width, step_out, max_attempts)
      end
    end
  end
end

