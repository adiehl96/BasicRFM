function RFMFirstMoments( Prior_state, Posterior_state, max_index )
%RFMFIRSTMOMENTS Compute and compare first moments of data
% Detailed explanation goes here
%
% James Lloyd, July 2012
  
  %%%% TODO - extend to all variables
  
  % Initialise
  
  U_prior = zeros([size(Prior_state{1}.U), max_index]);
  U_posterior = zeros([size(Prior_state{1}.U), max_index]);
  T_UU_prior = zeros([length(Prior_state{1}.T_UU{1}), length(Prior_state{1}.T_UU), max_index]);
  T_UU_posterior = zeros([length(Prior_state{1}.T_UU{1}), length(Prior_state{1}.T_UU), max_index]);
  pp_UU_prior = zeros([size(Prior_state{1}.pp_UU{1}), length(Prior_state{1}.pp_UU), max_index]);
  pp_UU_posterior = zeros([size(Prior_state{1}.pp_UU{1}), length(Prior_state{1}.pp_UU), max_index]);
  UU_params_prior = zeros([size([Prior_state{1}.arrayKern_UU.params; Prior_state{1}.arrayKern_UU.diagNoise]), max_index]);
  UU_params_posterior = zeros([size([Prior_state{1}.arrayKern_UU.params; Prior_state{1}.arrayKern_UU.diagNoise]), max_index]);
  
  % Reshape cell arrays
  
  for i = 1:max_index
    U_prior(:,:,i) = Prior_state{i}.U;
    U_posterior(:,:,i) = Posterior_state{i}.U;
    for j = 1:length(Prior_state{i}.T_UU)
      T_UU_prior(:,j,i) = Prior_state{i}.T_UU{j};
      T_UU_posterior(:,j,i) = Posterior_state{i}.T_UU{j};
      pp_UU_prior(:,:,j,i) = Prior_state{i}.pp_UU{j};
      pp_UU_posterior(:,:,j,i) = Posterior_state{i}.pp_UU{j};
    end
    UU_params_prior(:,:,i) = [Prior_state{i}.arrayKern_UU.params; Prior_state{i}.arrayKern_UU.diagNoise];
    UU_params_posterior(:,:,i) = [Posterior_state{i}.arrayKern_UU.params; Posterior_state{i}.arrayKern_UU.diagNoise];
  end
  
  % Talk
  
  rejected = 0;
  tests = 0;
  
  fprintf('\n');
  fprintf('U:\n');
  for i = 1:size(U_prior, 1)
    for j = 1:size(U_prior, 2)
      [h p] = ttest(squeeze(U_prior(i,j,:)), squeeze(U_posterior(i,j,:)));
      tests = tests + 1;
      fprintf('%+01.2f %+01.2f : %0.2f : ', mean(U_prior(i,j,:)), mean(U_posterior(i,j,:)), p);
      if h
        fprintf('REJECTED\n')
        rejected = rejected + 1;
      else
        fprintf('accepted\n')
      end
    end
  end
  fprintf('T_UU:\n');
  for i = 1:size(T_UU_prior, 1)
    for j = 1:size(T_UU_prior, 2)
      [h p] = ttest(squeeze(T_UU_prior(i,j,:)), squeeze(T_UU_posterior(i,j,:)));
      tests = tests + 1;
      fprintf('%+01.2f %+01.2f : %0.2f : ', mean(T_UU_prior(i,j,:)), mean(T_UU_posterior(i,j,:)), p);
      if h
        fprintf('REJECTED\n')
        rejected = rejected + 1;
      else
        fprintf('accepted\n')
      end
    end
  end
  fprintf('pp_UU:\n');
  for i = 1:size(pp_UU_prior, 1)
    for j = 1:size(pp_UU_prior, 2)
      for k = 1:size(pp_UU_prior, 3)
        [h p] = ttest(squeeze(pp_UU_prior(i,j,k,:)), squeeze(pp_UU_posterior(i,j,k,:)));
        tests = tests + 1;
        fprintf('%+01.2f %+01.2f : %0.2f : ', mean(pp_UU_prior(i,j,k,:)), mean(pp_UU_posterior(i,j,k,:)), p);
        if h
          fprintf('REJECTED\n')
          rejected = rejected + 1;
        else
          fprintf('accepted\n')
        end
      end
    end
  end
  fprintf('Kern_UU:\n');
  for i = 1:size(UU_params_prior, 1)
    for j = 1:size(UU_params_prior, 2)
      [h p] = ttest(squeeze(UU_params_prior(i,j,:)), squeeze(UU_params_posterior(i,j,:)));
      tests = tests + 1;
      fprintf('%+01.2f %+01.2f : %0.2f : ', mean(UU_params_prior(i,j,:)), mean(UU_params_posterior(i,j,:)), p);
      if h
        fprintf('REJECTED\n')
        rejected = rejected + 1;
      else
        fprintf('accepted\n')
      end
    end
  end
  
  fprintf('\n%04d / %04d = %02.0f%% rejected\n\n', rejected, tests, 100 * rejected / tests);
  
end

