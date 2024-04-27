rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))


sages_train <- readRDS(file=fs::path(r_objects_folder, "062_sages_train.rds"))
sages_juiced2 <- readRDS(file=fs::path(r_objects_folder, "062_sages_juiced2.rds"))

sages_split <- readRDS(file=fs::path(r_objects_folder, "062_sages_split.rds"))

# glm_wf     <- readRDS(file=fs::path(r_objects_folder, "065_glm_wf.rds"))
glmnet_wf_93  <- readRDS(file=fs::path(r_objects_folder, "065_glmnet_wf_93.rds"))
# rf_wf_93      <- readRDS(file=fs::path(r_objects_folder, "065_rf_wf_93.rds"))
# lgbm_wf_93    <- readRDS(file=fs::path(r_objects_folder, "065_lgbm_wf_93.rds"))

glmnet_wf_7   <- readRDS(file=fs::path(r_objects_folder, "065_glmnet_wf_7.rds"))
glmnet_wf_14  <- readRDS(file=fs::path(r_objects_folder, "065_glmnet_wf_14.rds"))
glmnet_wf_32  <- readRDS(file=fs::path(r_objects_folder, "065_glmnet_wf_32.rds"))



set.seed(12)
sages_folds <- vfold_cv(sages_train, v = 10)

grid_glmnet <- 
  glmnet_wf_93 %>% 
  extract_parameter_set_dials() %>% 
  grid_latin_hypercube(size = 25)

# grid_rf <- 
#   rf_wf %>% 
#   extract_parameter_set_dials() %>% 
#   grid_latin_hypercube(size = 25)
# 
# grid_lgbm <- 
#   lgbm_wf %>% 
#   extract_parameter_set_dials() %>% 
#   grid_latin_hypercube(size = 25)

ctrl <- control_grid(save_pred = TRUE)
sages_metrics <- metric_set(rmse, rsq, mae)

# glm_fit <- fit(glm_wf, data = sages_folds)


glmnet_res_93 <- glmnet_wf_93 %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_glmnet,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

glmnet_res_7 <- glmnet_wf_7 %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_glmnet,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

glmnet_res_14 <- glmnet_wf_14 %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_glmnet,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

glmnet_res_32 <- glmnet_wf_32 %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_glmnet,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

# rf_res_93 <- rf_wf_93 %>%
#   tune_grid(
#     resamples = sages_folds,
#     grid = grid_rf,
#     # The options below are not required by default
#     control = ctrl,
#     metrics = sages_metrics
#   )

# lgbm_param <- lgbm_wf_93 %>%
#   extract_parameter_set_dials() %>%
#   update(trees = trees(c(1L, 100L)),
#          learn_rate = learn_rate(c(-5, -1)))
# 
# lgbm_res_93 <- lgbm_wf_93 %>%
#   tune_grid(
#     resamples = sages_folds,
#     grid = grid_lgbm,
#     # The options below are not required by default
#     param_info = lgbm_param,
#     control = ctrl,
#     metrics = sages_metrics
#   )

# saveRDS(glm_res,            file=fs::path(r_objects_folder, "070_glm_res.rds"))
saveRDS(glmnet_res_93,         file=fs::path(r_objects_folder, "070_glmnet_res_93.rds"))
saveRDS(glmnet_res_7,          file=fs::path(r_objects_folder, "070_glmnet_res_7.rds"))
saveRDS(glmnet_res_14,         file=fs::path(r_objects_folder, "070_glmnet_res_14.rds"))
saveRDS(glmnet_res_32,         file=fs::path(r_objects_folder, "070_glmnet_res_32.rds"))
# saveRDS(rf_res_93,             file=fs::path(r_objects_folder, "070_rf_res_93.rds"))
# saveRDS(lgbm_res_93,           file=fs::path(r_objects_folder, "070_lgbm_res_93.rds"))

# # collect_metrics(glm_res)
# collect_metrics(glmnet_res_93)
# collect_metrics(glmnet_res_7)
# collect_metrics(glmnet_res_14)
# collect_metrics(glmnet_res_32)
# show_best(glmnet_res_93, metric = "rmse")
# show_best(glmnet_res_7, metric = "rmse")
# show_best(glmnet_res_14, metric = "rmse")
# show_best(glmnet_res_32, metric = "rmse")
# # show_best(glmnet_res, metric = "rmse")
# # collect_metrics(rf_res)
# # show_best(rf_res, metric = "rmse")
# # 
# autoplot(glmnet_res_93)
# # autoplot(rf_res)
# 
glmnet_best_93 <- select_best(glmnet_res_93, metric = "rmse")
# glmnet_best_93

glmnet_wf_final_93 <- finalize_workflow(glmnet_wf_93, glmnet_best_93)
glmnet_final_93 <- last_fit(glmnet_wf_final_93, sages_split)
# collect_metrics(glmnet_final_93)

glmnet_best_7 <- select_best(glmnet_res_7, metric = "rmse")
# glmnet_best_7

glmnet_wf_final_7 <- finalize_workflow(glmnet_wf_7, glmnet_best_7)
glmnet_final_7 <- last_fit(glmnet_wf_final_7, sages_split)
# collect_metrics(glmnet_final_7)

glmnet_best_14 <- select_best(glmnet_res_14, metric = "rmse")
# glmnet_best_14

glmnet_wf_final_14 <- finalize_workflow(glmnet_wf_14, glmnet_best_14)
glmnet_final_14 <- last_fit(glmnet_wf_final_14, sages_split)
# collect_metrics(glmnet_final_14)

glmnet_best_32 <- select_best(glmnet_res_32, metric = "rmse")
# glmnet_best_32

glmnet_wf_final_32 <- finalize_workflow(glmnet_wf_32, glmnet_best_32)
glmnet_final_32 <- last_fit(glmnet_wf_final_32, sages_split)
# collect_metrics(glmnet_final_32)

# rf_best_93 <- select_best(rf_res_93, metric = "rmse")
# rf_best_93
# 
# rf_wf_final_93 <- finalize_workflow(rf_wf_93, rf_best_93)
# rf_final_93 <- last_fit(rf_wf_final_93, sages_split)
# collect_metrics(rf_final_93)
# 
# lgbm_best_93 <- select_best(lgbm_res_93, metric = "rmse")
# lgbm_best_93
# 
# lgbm_wf_final_93 <- finalize_workflow(lgbm_wf_93, lgbm_best_93)
# lgbm_final_93 <- last_fit(lgbm_wf_final_93, sages_split)
# collect_metrics(lgbm_final_93)

saveRDS(glmnet_final_93,         file=fs::path(r_objects_folder, "070_glmnet_final_93.rds"))
saveRDS(glmnet_final_7,         file=fs::path(r_objects_folder, "070_glmnet_final_7.rds"))
saveRDS(glmnet_final_14,         file=fs::path(r_objects_folder, "070_glmnet_final_14.rds"))
saveRDS(glmnet_final_32,         file=fs::path(r_objects_folder, "070_glmnet_final_32.rds"))
# saveRDS(rf_final,             file=fs::path(r_objects_folder, "070_rf_final.rds"))
# saveRDS(lgbm_final,           file=fs::path(r_objects_folder, "070_lgbm_final.rds"))

# glmnet_final_93 %>%
#   collect_predictions() %>%
#   cal_plot_regression(
#     truth = vdgcp_slope36m,
#     estimate = .pred,
#     alpha = .5
#   ) +
#   ggtitle("Elastic net") +
#   hrbrthemes::theme_ipsum()



# lgbm_final %>%
#   collect_predictions() %>%
#   cal_plot_regression(
#     truth = vdgcp_slope36m,
#     estimate = .pred,
#     alpha = .5
#   ) +
#   ggtitle("Gradient boosted trees") +
#   hrbrthemes::theme_ipsum()
# 
# library(probably)
# lgbm_res %>%
#   collect_predictions(
#     parameters = lgbm_best
#   ) %>%
#   cal_plot_regression(
#     truth = vdgcp_slope36m,
#     estimate = .pred,
#     alpha = .5
#   ) +
#   ggtitle("Gradient boosted trees") +
#   hrbrthemes::theme_ipsum()
