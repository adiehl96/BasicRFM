function slice_V( obj, array_index, slice_width, step_out, max_attempts)
%SLICE_V Slice sampling of latent node points
% Detailed explanation goes here
%
% James Lloyd, June 2012

% Set up local variables
i = array_index;
[M d] = size(obj.V);

%For a random permutation of the latent positions
for mm = randperm(M)
  %Set the slice level
  log_Pstar = obj.Cond_llh_V(mm, i);
  log_Pstar = log_Pstar + log(rand);

  direction = rand(1, d);
  direction = direction / sqrt(sum(direction.^2));

  rr = rand;
  V_l = obj.V(mm,:) - rr * slice_width * direction;
  V_r = obj.V(mm,:) + (1 - rr) * slice_width * direction;

  V_saved = obj.V;
  
  attempts = 0;

  if step_out
    while attempts < max_attempts
      obj.V(mm, :) = V_l;
      test_p = obj.Cond_llh_V(mm, i);
      if test_p > log_Pstar
        V_l = obj.V(mm, :) - slice_width * direction;
      else
        break;
      end
      attempts = attempts + 1;
    end
    obj.V(mm,:) = V_saved(mm,:);
    while attempts < max_attempts
      obj.V(mm, :) = V_r;
      test_p = obj.Cond_llh_V(mm, i);
      if test_p > log_Pstar
        V_r = obj.V(mm, :) + slice_width * direction;
      else
        break;
      end
      attempts = attempts + 1;
    end
  end

  obj.V(mm,:) = V_saved(mm,:);
  
  attempts = 0;

  while attempts < max_attempts

    obj.V(mm, :) = rand()*(V_r - V_l) + V_l;

    log_p_prime = obj.Cond_llh_V(mm, i);
    if log_p_prime >= log_Pstar
      break
    else
      % Shrink in
      if (obj.V(mm, :) - V_saved(mm, :)) * direction' > 0
        V_r = obj.V(mm, :);
      elseif (obj.V(mm, :) - V_saved(mm, :)) * direction' < 0
        V_l = obj.V(mm, :);
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
    obj.V(mm, :) = V_saved(mm, :);
    for j = 1:length(obj.data_VV.train_X_v)
      obj.UpdateKernelMatrices_ip_VV ((obj.data_VV.train_X_i{i} == mm) | ...
                                      (obj.data_VV.train_X_j{i} == mm), j);
    end
    for j = 1:length(obj.data_UV.train_X_v)
      obj.UpdateKernelMatrices_ip_UV ((obj.data_UV.train_X_j{i} == mm), j);
    end
    for j = 1:length(obj.data_VCov.train_X_v)
      obj.UpdateKernelMatrices_ip_VCov ((obj.data_VCov.train_X_i{i} == mm), j);
    end
  end
end

end

