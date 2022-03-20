function llh = Cond_llh_2array( W, X, ObsModel, params )
%Cond_llh_2array Calculates llh of data given function
% Depends on data observation model
%
% Written by James Lloyd, June 2012

  switch ObsModel
    case ObservationModels.Logit
      % Pass through logistic then apply Bernoulli llh
      p = logistic(W);
      llh = Bernoulli_llh(p, X);
    case ObservationModels.Gaussian
      llh = -0.5 * sum(sum((W - X) .^ 2)) * params.precision;
    case ObservationModels.Poisson
      %%%% - Does passing through exp do what we want?
      llh = sum(sum(log(poisspdf(floor(X), exp(W)))));
end

