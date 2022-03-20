function UpdateKernelMatrices_UCov( obj )
%UPDATEKERNELMATRICES Update K_ip_pp and K_pp_pp
% Detailed explanation goes here
%
% James Lloyd, June 2012
  for i = 1:length(obj.ip_UCov) 
    obj.K_ip_pp_UCov{i}      = obj.arrayKern_UCov.Matrix(obj.ip_UCov{i}, obj.pp_UCov{i});
    obj.K_pp_pp_UCov{i}      = obj.arrayKern_UCov.Matrix(obj.pp_UCov{i});
    obj.chol_K_pp_pp_UCov{i} = chol(obj.K_pp_pp_UCov{i});
  end
end

