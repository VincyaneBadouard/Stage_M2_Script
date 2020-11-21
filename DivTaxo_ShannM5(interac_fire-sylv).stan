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
  vector [N] Sylv; // sylviculture
  vector [N] Fire; // feu
  vector [N] Ced; // Cedrela (espèce invasive)
  vector [N] Soil; // Proportion de sol hydromorphique (espèce invasive)
  vector [N] Interac; // fire & sylv standardised multiplication (= interaction)
  int<lower=1> N_pred; // Predicted values number
  vector [N_pred] Sylv_pred; // range for response prediction. Same length than predicted response.
  vector [N_pred] Fire_pred; 
  vector [N_pred] Ced_pred; 
  vector [N_pred] Soil_pred;
  vector [N_pred] Interac_pred; 
 
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real<lower=0> theta0; // theta0 is constant and positiv
  real theta1; // theta1 = syviculture parameter 
  real theta2; // theta2 = fire parameter 
  real theta3; // theta2 = Cedrela parameter 
  real theta4; // theta4 = soil parameter
  real theta5; // theta5 = Sylv:Fire interaction parameter
  real<lower=0> sigma; // Model error
}


// The model to be estimated. We model the output
// 'y' to be lognormally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  DivTaxo_Shann ~ lognormal(log(theta0 + theta1*Sylv + theta2*Fire + theta3*Ced + theta4*Soil + theta5*Interac), sigma); // Likelihood
}

// Response predicted values
generated quantities {
  vector  [N_pred] Pred_DivTaxo_Sylv = theta0 + theta1*Sylv_pred; // Median (=exp(mu). Other covariants are taken at the average : 0 (standardized)
  vector  [N_pred] Pred_DivTaxo_Fire = theta0 + theta2*Fire_pred; // Median (=exp(mu). Other covariants are taken at the average : 0 (standardized)
  vector  [N_pred] Pred_DivTaxo_Ced = theta0 + theta3*Ced_pred; // Median (=exp(mu). Other covariants are taken at the average : 0 (standardized)
  vector  [N_pred] Pred_DivTaxo_Soil = theta0 + theta4*Soil_pred; // Median (=exp(mu). Other covariants are taken at the average : 0 (standardized)
  vector  [N_pred] Pred_DivTaxo_sylvXfire = theta0  + theta5*Interac_pred; // Median (=exp(mu). Other covariants are taken at the average : 0 (standardized)
}
