function slice_pp_UU( obj, array_index, slice_width, step_out, max_attempts)
%SLICE_pp Slice sampling of pseudo points
% Detailed explanation goes here
%
% James Lloyd, June 2012

% Set up local variables
i = array_index;
[M d] = size(obj.pp_UU{i});

%For a random permutation of the latent positions
for mm = randperm(M)
  %Set the slice level
  log_Pstar = obj.Cond_llh_pp_UU(mm, i);
  log_Pstar = log_Pstar + log(rand);

  direction = rand(1, d);
  direction = direction / sqrt(sum(direction.^2));

  rr = rand;
  pp_l = obj.pp_UU{i}(mm,:) - rr * slice_width * direction;
  pp_r = obj.pp_UU{i}(mm,:) + (1 - rr) * slice_width * direction;

  pp_saved = obj.pp_UU{i};
  
  attempts = 0;

  if step_out
    while attempts < max_attempts
      obj.pp_UU{i}(mm, :) = pp_l;
      test_p = obj.Cond_llh_pp_UU(mm, i);
      if test_p > log_Pstar
        pp_l = obj.pp_UU{i}(mm, :) - slice_width * direction;
      else
        break;
      end
      attempts = attempts + 1;
    end
    obj.pp_UU{i}(mm,:) = pp_saved(mm,:);
    while attempts < max_attempts
      obj.pp_UU{i}(mm, :) = pp_r;
      test_p = obj.Cond_llh_pp_UU(mm, i);
      if test_p > log_Pstar
        pp_r = obj.pp_UU{i}(mm, :) + slice_width * direction;
      else
        break;
      end
      attempts = attempts + 1;
    end
  end

  obj.pp_UU{i}(mm,:) = pp_saved(mm,:);
  
  attempts = 0;

  while attempts < max_attempts

    obj.pp_UU{i}(mm, :) = rand()*(pp_r - pp_l) + pp_l;

    log_p_prime = obj.Cond_llh_pp_UU(mm, i);
    if log_p_prime >= log_Pstar
      break
    else
      % Shrink in
      if (obj.pp_UU{i}(mm, :) - pp_saved(mm, :)) * direction' > 0
        pp_r = obj.pp_UU{i}(mm, :);
      elseif (obj.pp_UU{i}(mm, :) - pp_saved(mm, :)) * direction' < 0
        pp_l = obj.pp_UU{i}(mm, :);
      else
        error('BUG DETECTED: Shrunk to current position and still not acceptable.');
      end
    end

    attempts = attempts + 1;

  end
  if attempts < max_attempts
    % Nothing to do
  else
    % Reset pp = and update cache
    obj.pp_UU{i}(mm, :) = pp_saved(mm, :);
    obj.UpdateKernelMatrices_pp_UU (mm, i);
  end
end

end

