function UpdateKernelMatrices_pp_UCov( obj, pp_index, array_index )
%UPDATEKERNELMATRICES Update K_ip_pp and K_pp_pp when pseudo points change
% Detailed explanation goes here
%
% James Lloyd, June 2012
  i = array_index;
  % Could make use of rank 1 updates - not big time saving
%   obj.K_pp_pp_UCov{i} = obj.arrayKern_UCov.Matrix(obj.pp_UCov{i}); 
  obj.K_pp_pp_UCov{i}(:, pp_index) = obj.arrayKern_UCov.Matrix(obj.pp_UCov{i}, ...
                                                           obj.pp_UCov{i}(pp_index, :)); 
  obj.K_pp_pp_UCov{i}(pp_index, :) = obj.K_pp_pp_UCov{i}(:, pp_index);
  % And update the diagonal element separately since we need noise to be
  % added
  obj.K_pp_pp_UCov{i}(pp_index, pp_index) = obj.arrayKern_UCov.Matrix(obj.pp_UCov{i}(pp_index, :)); 
  obj.chol_K_pp_pp_UCov{i} = chol(obj.K_pp_pp_UCov{i});
  obj.K_ip_pp_UCov{i}(:, pp_index) = obj.arrayKern_UCov.Matrix(obj.ip_UCov{i}, ...
                                                           obj.pp_UCov{i}(pp_index, :));
end