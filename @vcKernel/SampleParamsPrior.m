function new = SampleParamsPrior( obj )
%SAMPLEPARAMSPRIOR Sample parameters from prior
% Detailed explanation goes here
%
% James Lloyd, July 2012

  % Initialise to preserve shape
  new.params = zeros(size(obj.params));

  switch obj.priorType
    case KernelPriors.LogNormals
      % All paramaters have log normal distributions
      % Paramaters stored in log domain, so just compute normal dists
      for i = 1:size(obj.params, 1)
        new.params(i) = obj.priorParams(i,1) + obj.priorParams(i,2) * randn;
      end
      new.diagNoise = obj.noiseParams(1,1) + obj.noiseParams(1,2) * randn;
    case KernelPriors.InverseGammas
      % All parameters are scale parameters and hence get Jeffreys inspired
      % prior
      % Remember, parameters stored in log domain
      for i = 1:size(obj.params, 1)
        new.params(i) = -log(gamrnd(obj.priorParams(i,1), 1 / obj.priorParams(i,2)));
      end
      new.diagNoise = -log(gamrnd(obj.noiseParams(1,1), 1 / obj.noiseParams(1,2)));
  end

end

