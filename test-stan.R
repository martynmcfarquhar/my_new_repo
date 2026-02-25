library(cmdstanr)
library(bayesplot)
library(posterior)

data <- list("N" = 100,
             "y" = rnorm(100))

mod <- cmdstan_model(stan_file="test-stan.stan")
fit <- mod$sample(data=data)

fit$print(c("mu","sigma"))

# Check model
color_scheme_set("brightblue")
mcmc_combo(fit$draws(), pars=c("mu","sigma"), combo=c("hist","trace"))

# PPC
y_rep <- as.matrix(as_draws_matrix(fit$draws("y_rep")))
ppc_dens_overlay(data$y,y_rep[1:100,])