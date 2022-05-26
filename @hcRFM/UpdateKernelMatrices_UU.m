function UpdateKernelMatrices_UU( obj )
%UPDATEKERNELMATRICES Update K_ip_pp and K_pp_pp
% Detailed explanation goes here
%
% James Lloyd, June 2012
  for i = 1:length(obj.ip_UU) 
    obj.K_ip_pp_UU{i}      = obj.arrayKern_UU.Matrix(obj.ip_UU{i}, obj.pp_UU{i});
    obj.K_pp_pp_UU{i}      = obj.arrayKern_UU.Matrix(obj.pp_UU{i});
    obj.chol_K_pp_pp_UU{i} = chol(obj.K_pp_pp_UU{i});
  end
end

