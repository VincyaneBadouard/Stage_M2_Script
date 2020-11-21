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
  vector <lower=0> [N] DivFctnal_Shann; // Response variable sur R+ (pas utiliser les donnees pour borner)
  vector [N] Sylv; // sylviculture
  vector [N] Fire; // feu
  vector [N] Ced; // Cedrela (espèce invasive)
  vector [N] Soil; // Proportion de sol hydromorphique 
  int<lower=1> N_pred; // Predicted values number
  vector [N_pred] Ced_pred; 
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real<lower=0> theta0; // theta0 is constant and positiv
  real theta1; // theta1 = syviculture parameter 
  real theta2; // theta2 = fire parameter 
  real theta3a; // theta3a = Cedrela parameter croissant part of intermediate HP
  real theta3b; // theta3b = Cedrela parameter descending part 
  real theta4; // theta4 = soil parameter
  real<lower=0> sigma;
}


// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  DivFctnal_Shann ~ lognormal(log(theta0 + theta1*Sylv + theta2*Fire + theta3a*Ced + theta3b*Ced .* Ced + theta4*Soil), sigma); // Likelihood
}

// Response predicted values
generated quantities {
  vector  [N_pred] Pred_DivFctnal_CedIDH = theta0 + theta3a*Ced_pred + theta3b*Ced_pred .* Ced_pred; // Median (=exp(mu). Other covariants are taken at the average : 0 (standardized)
}

