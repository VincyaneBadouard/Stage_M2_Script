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

// The input data.
data {
  int<lower=1> N; // Observations number (plots number)
  int<lower=1> N_samples; // Predicted values number
  vector [N] Sylv; // sylviculture
  vector [N] Fire; // feu
  vector [N] Ced; // Cedrela (espèce invasive)
  vector [N] Soil; // Proportion de sol hydromorphique (espèce invasive)
  vector[N_samples] theta0;
  vector[N_samples] theta1;
  vector[N_samples] theta2;
  vector[N_samples] theta3;
  vector[N_samples] theta4;
  vector[N_samples] theta5;
  vector[N_samples] sigma;
}

// Empty block
parameters {
}


// Empty block 
model {
}

// Response predicted values
generated quantities {
  matrix <lower=0> [N_samples, N] DivTaxo_Shann; // Predicted response matrix
  for(n in 1:N) {
    for(i in 1:N_samples) { // "_rng" = random number generator,
      DivTaxo_Shann[i, n] = lognormal_rng(log(theta0[i] + theta1[i]*Sylv[n] + theta2[i]*Fire[n] + theta3[i]*Ced[n] + theta4[i]*Soil[n] + theta5[i]*Fire[n] .* Sylv[n]), sigma[i]);
    }  
  }
}
