function prop_success = surf_slice_pp_VV( obj, array_index, slice_width, step_out, max_attempts)
%surf_slice_pp_VV Joint slice sampling of pseudo points and targets
% Slice sample the pseduo points, whilst letting the targets surf the
% current predictive posterior. This is a heuristic to improve mixing
%
% James Lloyd, June 2012

% Set up local variables
i = array_index;
[M d] = size(obj.pp_VV{i});

sucess_count = 0;

%For a random permutation of the latent positions
for mm = randperm(M)
  %Set the slice level
  % This conditional log likelihood is still ok since W_VV updated in
  % calculation
  log_Pstar = obj.Cond_llh_pp_VV(mm, i);
  log_Pstar = log_Pstar + log(rand);

  direction = rand(1, d);
  direction = direction / sqrt(sum(direction.^2));

  rr = rand;
  pp_l = obj.pp_VV{i}(mm,:) - rr * slice_width * direction;
  pp_r = obj.pp_VV{i}(mm,:) + (1 - rr) * slice_width * direction;

  pp_saved = obj.pp_VV{i};
  T_saved = obj.T_VV{i};
  
  not_mm = [1:(mm-1) (mm+1):M];
  full_conditional_surf = obj.K_pp_pp_VV{i}(mm,not_mm) * (obj.K_pp_pp_VV{i}(not_mm, not_mm) ...
                                                       \ obj.T_VV{i}(not_mm));
  surf_height = obj.T_VV{i}(mm) - full_conditional_surf;
  
  attempts = 0;

  if step_out
    while attempts < max_attempts
      obj.pp_VV{i}(mm, :) = pp_l;
      % Surf
      obj.UpdateKernelMatrices_pp_VV (mm, i); % This is slightly inefficient
      full_conditional_surf = obj.K_pp_pp_VV{i}(mm,not_mm) * (obj.K_pp_pp_VV{i}(not_mm, not_mm) ...
                                                           \ obj.T_VV{i}(not_mm));
      obj.T_VV{i}(mm) = full_conditional_surf + surf_height;
      test_p = obj.Cond_llh_pp_VV_No_Update(mm, i);
      if test_p > log_Pstar
        pp_l = obj.pp_VV{i}(mm, :) - slice_width * direction;
      else
        break;
      end
      attempts = attempts + 1;
    end
    while attempts < max_attempts
      obj.pp_VV{i}(mm, :) = pp_r;
      % Surf
      obj.UpdateKernelMatrices_pp_VV (mm, i); % This is slightly inefficient
      full_conditional_surf = obj.K_pp_pp_VV{i}(mm,not_mm) * (obj.K_pp_pp_VV{i}(not_mm, not_mm) ...
                                                           \ obj.T_VV{i}(not_mm));
      obj.T_VV{i}(mm) = full_conditional_surf + surf_height;
      test_p = obj.Cond_llh_pp_VV_No_Update(mm, i);
      if test_p > log_Pstar
        pp_r = obj.pp_VV{i}(mm, :) + slice_width * direction;
      else
        break;
      end
      attempts = attempts + 1;
    end
  end

  obj.pp_VV{i}(mm,:) = pp_saved(mm,:);
  obj.T_VV{i}(mm) = T_saved(mm,:);
  
  attempts = 0;

  while attempts < max_attempts

    obj.pp_VV{i}(mm, :) = rand()*(pp_r - pp_l) + pp_l;
    % Surf
    obj.UpdateKernelMatrices_pp_VV (mm, i); % This is slightly inefficient
    full_conditional_surf = obj.K_pp_pp_VV{i}(mm,not_mm) * (obj.K_pp_pp_VV{i}(not_mm, not_mm) ...
                                                         \ obj.T_VV{i}(not_mm));
    obj.T_VV{i}(mm) = full_conditional_surf + surf_height;
    log_p_prime = obj.Cond_llh_pp_VV_No_Update(mm, i);
    if log_p_prime >= log_Pstar
      break
    else
      % Shrink in
      if (obj.pp_VV{i}(mm, :) - pp_saved(mm, :)) * direction' > 0
        pp_r = obj.pp_VV{i}(mm, :);
      elseif (obj.pp_VV{i}(mm, :) - pp_saved(mm, :)) * direction' < 0
        pp_l = obj.pp_VV{i}(mm, :);
      else
        error('BUG DETECTED: Shrunk to current position and still not acceptable.');
      end
    end

    attempts = attempts + 1;

  end
  if attempts < max_attempts
    % Nothing to do
    sucess_count = sucess_count + 1;
  else
    % Reset pp and T and update cache
    obj.pp_VV{i}(mm, :) = pp_saved(mm, :);
    obj.T_VV{i}(mm) = T_saved(mm);
    obj.UpdateKernelMatrices_pp_VV (mm, i);
  end
  prop_success = sucess_count / M;
end

end

