function UpdateKernelMatrices_UV( obj )
%UPDATEKERNELMATRICES Update K_ip_pp and K_pp_pp
% Detailed explanation goes here
%
% James Lloyd, June 2012
  for i = 1:length(obj.ip_UV) 
    obj.K_ip_pp_UV{i}      = obj.arrayKern_UV.Matrix(obj.ip_UV{i}, obj.pp_UV{i});
    obj.K_pp_pp_UV{i}      = obj.arrayKern_UV.Matrix(obj.pp_UV{i});
    obj.chol_K_pp_pp_UV{i} = chol(obj.K_pp_pp_UV{i});
  end
end

