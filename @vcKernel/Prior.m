function llh = Prior( obj )
%PRIOR Calculates prior llh of current parameters
% Case statement of various prior settings
%
% Written by James Lloyd, June 2012
  switch obj.priorType
    case KernelPriors.LogNormals
      % All paramaters have log normal distirbutions
      % Paramaters stored in log domain, so just compute normal probs
      llh = 0;
      % Could write this for loop as a matrix calculation,
      % probably little point though - not inefficient
      for i = 1:size(obj.params, 1)
        llh = llh - 0.5 * ((obj.params(i) - obj.priorParams(i,1))^2) ...
                        / (obj.priorParams(i,2)^2);
      end
      llh = llh - 0.5 * ((obj.diagNoise - obj.noiseParams(1,1))^2) ...
                      / (obj.noiseParams(1,2)^2);
    case KernelPriors.InverseGammas
      % All parameters are scale parameters and hence get Jeffreys inspired
      % prior
      % Remember, parameters stored in log domain
      llh = 0;
      for i = 1:size(obj.params, 1)
        llh = llh + gampdf (exp(-obj.params(i)), obj.priorParams(i,1), 1 / obj.priorParams(i,2));
%         llh = llh + obj.params(i);
      end
      llh = llh + gampdf (exp(-obj.diagNoise), obj.noiseParams(1,1), 1 / obj.noiseParams(1,2));
  end
end

