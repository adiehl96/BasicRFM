classdef vcKernel
  %vcKernel Wrapper for GPML kernels
  % Contains
  %  - name of kernel function
  %  - parameters of kernel function
  %  - a method to compute the prior of the parameters
  %  - a method to compute kernel matrices
  %
  % Written by James Lloyd, June 2012
  
  % For now, all properties are generic
  % If releasing code it may be advisable to make some protected etc.
  properties
    
    name = 'covSEiso'; % Name of GPML kernel function
    params = [log(1) ; log(2)]; % Parameters to be passed to GPML
    
    diagNoise = log(0.1); % Diagonal noise - part of prior
    jitter = 10e-6; % Diagonal noise  - for numerical stability
    
    priorType = KernelPriors.LogNormals; % Form of prior
    priorParams = [log(1), 0.5;
                   log(2), 0.5]; % Form depends on prior type
    noiseParams = [log(0.1), 0.5]; % Parameters for prior on noise
    
  end
  
  methods
      
    llh = Prior(obj); % Prior for parameters
    matrix = Matrix(obj, X, Z); % Calculate kernel matrix
    new = SampleParamsPrior(obj); % Sample parameters from prior
    
  end
  
end
