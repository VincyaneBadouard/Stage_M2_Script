//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=1> N; // Observations number (plots number)
  vector <lower=0> [N] DivTaxo_Shann; // Response variable rajouter que ca doit etre positif pas utiliser les donnees
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real<lower=0> theta0; // // theta0 is constant and positiv
  real<lower=0> sigma;
}
transformed parameters {
  real mu = log(theta0); // not to declare mu in parameters block
}


// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  DivTaxo_Shann ~ lognormal(mu, sigma); // Likelihood
}

