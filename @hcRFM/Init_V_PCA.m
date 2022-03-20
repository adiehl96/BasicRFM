function Init_V_PCA( obj )
%INIT_U_Rand Randomly initialise U - temporary function
% Write a description of all variables here
%
% James Lloyd, June 2012

%%%% Update description
  % Construct covariate data matrix
  
  CovMatrix = [];
  for i = 1:length(obj.data_VCov.train_X_v)
    CovMatrix = [CovMatrix, obj.data_VCov.train_X_v{i}];
  end
  
  % PCA
  
  [~, SCORE] = princomp(zscore(CovMatrix));

  %obj.U = randn(rows, obj.D_L_U);
  obj.V = SCORE(:,1:min(size(SCORE, 2), obj.D_L_V));
  % Any remaining dimensions are initialised randomly
  obj.V = [obj.V randn(size(SCORE, 1), obj.D_L_V - min(size(SCORE, 2), obj.D_L_V))];
end

