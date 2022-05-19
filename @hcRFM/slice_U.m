function slice_U( obj, array_index, slice_width, step_out, max_attempts)
%SLICE_U Slice sampling of latent node points
% Detailed explanation goes here
%
% James Lloyd, June 2012

% Set up local variables
i = array_index;
[M d] = size(obj.U);

%For a random permutation of the latent positions
for mm = randperm(M)
  %Set the slice level
  log_Pstar = obj.Cond_llh_U(mm, i);
  log_Pstar = log_Pstar + log(rand);

  direction = rand(1, d);
  direction = direction / sqrt(sum(direction.^2));

  rr = rand;
  U_l = obj.U(mm,:) - rr * slice_width * direction;
  U_r = obj.U(mm,:) + (1 - rr) * slice_width * direction;

  U_saved = obj.U;
  
  attempts = 0;

  if step_out
    while attempts < max_attempts
      obj.U(mm, :) = U_l;
      test_p = obj.Cond_llh_U(mm, i);
      if test_p > log_Pstar
        U_l = obj.U(mm, :) - slice_width * direction;
      else
        break;
      end
      attempts = attempts + 1;
    end
    obj.U(mm,:) = U_saved(mm,:);
    while attempts < max_attempts
      obj.U(mm, :) = U_r;
      test_p = obj.Cond_llh_U(mm, i);
      if test_p > log_Pstar
        U_r = obj.U(mm, :) + slice_width * direction;
      else
        break;
      end
      attempts = attempts + 1;
    end
  end

  obj.U(mm,:) = U_saved(mm,:);
  
  attempts = 0;

  while attempts < max_attempts

    obj.U(mm, :) = rand()*(U_r - U_l) + U_l;

    log_p_prime = obj.Cond_llh_U(mm, i);
    if log_p_prime >= log_Pstar
      break
    else
      % Shrink in
      if (obj.U(mm, :) - U_saved(mm, :)) * direction' > 0
        U_r = obj.U(mm, :);
      elseif (obj.U(mm, :) - U_saved(mm, :)) * direction' < 0
        U_l = obj.U(mm, :);
      else
        error('BUG DETECTED: Shrunk to current position and still not acceptable.');
      end
    end

    attempts = attempts + 1;

  end
  if attempts < max_attempts
    % Nothing to do
  else
    % Reset U = and update cache
    obj.U(mm, :) = U_saved(mm, :);
    for j = 1:length(obj.data_UU.train_X_v)
      obj.UpdateKernelMatrices_ip_UU ((obj.data_UU.train_X_i{i} == mm) | ...
                                      (obj.data_UU.train_X_j{i} == mm), j);
    end
  end
end

end

