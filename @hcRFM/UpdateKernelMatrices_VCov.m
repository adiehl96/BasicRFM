function UpdateKernelMatrices_VCov( obj )
%UPDATEKERNELMATRICES Update K_ip_pp and K_pp_pp
% Detailed explanation goes here
%
% James Lloyd, June 2012
  for i = 1:length(obj.ip_VCov) 
    obj.K_ip_pp_VCov{i}      = obj.arrayKern_VCov.Matrix(obj.ip_VCov{i}, obj.pp_VCov{i});
    obj.K_pp_pp_VCov{i}      = obj.arrayKern_VCov.Matrix(obj.pp_VCov{i});
    obj.chol_K_pp_pp_VCov{i} = chol(obj.K_pp_pp_VCov{i});
  end
end

