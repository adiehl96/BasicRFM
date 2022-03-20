function Talk (obj, performance)
%TALK Output some summary stats
% Detailed explanation goes here
%
% James Lloyd, June 2012

 if nargin < 2
   performance = obj.performance;
 end

 for i = 1:length(performance.UU)
   fprintf('\n');
   fprintf('UU %2d : ', i)
   switch obj.ObservationModel_UU
     case ObservationModels.Logit
       fprintf('AUC = %0.2f : Error = %0.2f', performance.UU{i}.AUC, ...
                                              performance.UU{i}.ClassifierError);
     case {ObservationModels.Gaussian, ObservationModels.Poisson}
       fprintf('RMSE = %0.2f : MAE = %0.2f', performance.UU{i}.RMSE, performance.UU{i}.MAE);
   end
 end

 for i = 1:length(performance.VV)
   fprintf('\n');
   fprintf('VV %2d : ', i)
   switch obj.ObservationModel_VV
     case ObservationModels.Logit
       fprintf('AUC = %0.2f : Error = %0.2f', performance.VV{i}.AUC, ...
                                              performance.VV{i}.ClassifierError);
     case {ObservationModels.Gaussian, ObservationModels.Poisson}
       fprintf('RMSE = %0.2f : MAE = %0.2f', performance.VV{i}.RMSE, performance.VV{i}.MAE);
   end
 end

 for i = 1:length(performance.UV)
   fprintf('\n');
   fprintf('UV %2d : ', i)
   switch obj.ObservationModel_UV
     case ObservationModels.Logit
       fprintf('AUC = %0.2f : Error = %0.2f', performance.UV{i}.AUC, ...
                                              performance.UV{i}.ClassifierError);
     case {ObservationModels.Gaussian, ObservationModels.Poisson}
       fprintf('RMSE = %0.2f : MAE = %0.2f', performance.UV{i}.RMSE, performance.UV{i}.MAE);
   end
 end

 for i = 1:length(performance.UCov)
   fprintf('\n');
   fprintf(' U %2d : ', i)
   switch obj.ObservationModel_UCov{i}
     case ObservationModels.Logit
       fprintf('AUC = %0.2f : Error = %0.2f', performance.UCov{i}.AUC, ...
                                              performance.UCov{i}.ClassifierError);
     case {ObservationModels.Gaussian, ObservationModels.Poisson}
       fprintf('RMSE = %0.2f : MAE = %0.2f', performance.UCov{i}.RMSE, performance.UCov{i}.MAE);
   end
 end

 for i = 1:length(performance.VCov)
   fprintf('\n');
   fprintf(' V %2d : ', i)
   switch obj.ObservationModel_VCov{i}
     case ObservationModels.Logit
       fprintf('AUC = %0.2f : Error = %0.2f', performance.VCov{i}.AUC, ...
                                              performance.VCov{i}.ClassifierError);
     case {ObservationModels.Gaussian, ObservationModels.Poisson}
       fprintf('RMSE = %0.2f : MAE = %0.2f', performance.VCov{i}.RMSE, performance.VCov{i}.MAE);
   end
 end
 
 
end

