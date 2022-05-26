function UpdateKernelMatrices_pp_UU( obj, pp_index, array_index )
%UPDATEKERNELMATRICES Update K_ip_pp and K_pp_pp when pseudo points change
% Detailed explanation goes here
%
% James Lloyd, June 2012
  i = array_index;
  %%%% TODO - make use of cheap updates if possible
%   obj.K_pp_pp_UU{i} = obj.arrayKern_UU.Matrix(obj.pp_UU{i}); 
  obj.K_pp_pp_UU{i}(:, pp_index) = obj.arrayKern_UU.Matrix(obj.pp_UU{i}, ...
                                                           obj.pp_UU{i}(pp_index, :)); 
  obj.K_pp_pp_UU{i}(pp_index, :) = obj.K_pp_pp_UU{i}(:, pp_index);
  % And update the diagonal element separately since we need noise to be
  % added
  obj.K_pp_pp_UU{i}(pp_index, pp_index) = obj.arrayKern_UU.Matrix(obj.pp_UU{i}(pp_index, :)); 
  %%%% Would be nice if this could be done via rank 1 update style
  %%%% algorithm
  obj.chol_K_pp_pp_UU{i} = chol(obj.K_pp_pp_UU{i});
  obj.K_ip_pp_UU{i}(:, pp_index) = obj.arrayKern_UU.Matrix(obj.ip_UU{i}, ...
                                                           obj.pp_UU{i}(pp_index, :));
end