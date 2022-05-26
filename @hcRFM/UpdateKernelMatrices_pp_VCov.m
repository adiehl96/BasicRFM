function UpdateKernelMatrices_pp_VCov( obj, pp_index, array_index )
%UPDATEKERNELMATRICES Update K_ip_pp and K_pp_pp when pseudo points change
% Detailed explanation goes here
%
% James Lloyd, June 2012
  i = array_index;
  % TODO - make use of rank 1 updates
  %   obj.K_pp_pp_VCov{i} = obj.arrayKern_VCov.Matrix(obj.pp_VCov{i}); 
  obj.K_pp_pp_VCov{i}(:, pp_index) = obj.arrayKern_VCov.Matrix(obj.pp_VCov{i}, ...
                                                           obj.pp_VCov{i}(pp_index, :)); 
  obj.K_pp_pp_VCov{i}(pp_index, :) = obj.K_pp_pp_VCov{i}(:, pp_index);
  % And update the diagonal element separately since we need noise to be
  % added
  obj.K_pp_pp_VCov{i}(pp_index, pp_index) = obj.arrayKern_VCov.Matrix(obj.pp_VCov{i}(pp_index, :)); 
  obj.chol_K_pp_pp_VCov{i} = chol(obj.K_pp_pp_VCov{i});
  obj.K_ip_pp_VCov{i}(:, pp_index) = obj.arrayKern_VCov.Matrix(obj.ip_VCov{i}, ...
                                                           obj.pp_VCov{i}(pp_index, :));
end