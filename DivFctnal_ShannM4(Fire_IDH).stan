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

}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real<lower=0> theta0; // theta0 is constant and positiv
  real theta1; // theta1 = syviculture parameter  
  real theta2a; // theta2a = fire parameter croissant part of intermediate HP
  real theta2b; // theta2b = fire parameter descending part 
  real theta3; // theta3 = Cedrela parameter
  real theta4; // theta4 = soil parameter
  real<lower=0> sigma;
}


// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  DivFctnal_Shann ~ lognormal(log(theta0 + theta1*Sylv + theta2a*Fire + theta2b*Fire .* Fire + theta3*Ced + theta4*Soil), sigma); // Likelihood
}

