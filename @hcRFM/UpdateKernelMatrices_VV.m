function UpdateKernelMatrices_VV( obj )
%UPDATEKERNELMATRICES Update K_ip_pp and K_pp_pp
% Detailed explanation goes here
%
% James Lloyd, June 2012
  for i = 1:length(obj.ip_VV) 
    obj.K_ip_pp_VV{i}      = obj.arrayKern_VV.Matrix(obj.ip_VV{i}, obj.pp_VV{i});
    obj.K_pp_pp_VV{i}      = obj.arrayKern_VV.Matrix(obj.pp_VV{i});
    obj.chol_K_pp_pp_VV{i} = chol(obj.K_pp_pp_VV{i});
  end
end

