

sages_train <- readRDS(file=fs::path(r_objects_folder, "060_sages_train.rds"))
sages_split <- readRDS(file=fs::path(r_objects_folder, "060_sages_split.rds"))

glm_wf     <- readRDS(file=fs::path(r_objects_folder, "065_glm_wf.rds"))
glmnet_wf  <- readRDS(file=fs::path(r_objects_folder, "065_glmnet_wf.rds"))
rf_wf      <- readRDS(file=fs::path(r_objects_folder, "065_rf_wf.rds"))
lgbm_wf    <- readRDS(file=fs::path(r_objects_folder, "065_lgbm_wf.rds"))





set.seed(12)
sages_folds <- vfold_cv(sages_train, v = 10)

grid_glmnet <- 
  glmnet_wf %>% 
  extract_parameter_set_dials() %>% 
  grid_latin_hypercube(size = 25)

grid_rf <- 
  rf_wf %>% 
  extract_parameter_set_dials() %>% 
  grid_latin_hypercube(size = 25)

grid_lgbm <- 
  lgbm_wf %>% 
  extract_parameter_set_dials() %>% 
  grid_latin_hypercube(size = 25)

ctrl <- control_grid(save_pred = TRUE)
sages_metrics <- metric_set(rmse, rsq, mae)

# glm_fit <- fit(glm_wf, data = sages_folds)


glmnet_res <- glmnet_wf %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_glmnet,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

rf_res <- rf_wf %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_rf,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

lgbm_param <- lgbm_wf %>%
  extract_parameter_set_dials() %>%
  update(trees = trees(c(1L, 100L)),
         learn_rate = learn_rate(c(-5, -1)))

lgbm_res <- lgbm_wf %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_lgbm,
    # The options below are not required by default
    param_info = lgbm_param,
    control = ctrl,
    metrics = sages_metrics
  )

# saveRDS(glm_res,            file=fs::path(r_objects_folder, "070_glm_res.rds"))
saveRDS(glmnet_res,         file=fs::path(r_objects_folder, "070_glmnet_res.rds"))
saveRDS(rf_res,             file=fs::path(r_objects_folder, "070_rf_res.rds"))
saveRDS(lgbm_res,           file=fs::path(r_objects_folder, "070_lgbm_res.rds"))

# collect_metrics(glm_res)
# collect_metrics(glmnet_res)
# show_best(glmnet_res, metric = "rmse")
# collect_metrics(rf_res)
# show_best(rf_res, metric = "rmse")
# 
# autoplot(glmnet_res)
# autoplot(rf_res)

glmnet_best <- select_best(glmnet_res, metric = "rmse")
glmnet_best

glmnet_wf_final <- finalize_workflow(glmnet_wf, glmnet_best)
glmnet_final <- last_fit(glmnet_wf_final, sages_split)
collect_metrics(glmnet_final)

rf_best <- select_best(rf_res, metric = "rmse")
rf_best

rf_wf_final <- finalize_workflow(rf_wf, rf_best)
rf_final <- last_fit(rf_wf_final, sages_split)
collect_metrics(rf_final)

lgbm_best <- select_best(lgbm_res, metric = "rmse")
lgbm_best

lgbm_wf_final <- finalize_workflow(lgbm_wf, lgbm_best)
lgbm_final <- last_fit(lgbm_wf_final, sages_split)
collect_metrics(lgbm_final)

saveRDS(glmnet_final,         file=fs::path(r_objects_folder, "070_glmnet_final.rds"))
saveRDS(rf_final,             file=fs::path(r_objects_folder, "070_rf_final.rds"))
saveRDS(lgbm_final,           file=fs::path(r_objects_folder, "070_lgbm_final.rds"))


lgbm_final %>%
  collect_predictions() %>%
  cal_plot_regression(
    truth = vdgcp_slope36m,
    estimate = .pred,
    alpha = .5
  ) +
  ggtitle("Gradient boosted trees") +
  hrbrthemes::theme_ipsum()

library(probably)
lgbm_res %>%
  collect_predictions(
    parameters = lgbm_best
  ) %>%
  cal_plot_regression(
    truth = vdgcp_slope36m,
    estimate = .pred,
    alpha = .5
  ) +
  ggtitle("Gradient boosted trees") +
  hrbrthemes::theme_ipsum()
