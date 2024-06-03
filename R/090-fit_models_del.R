rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))


# sages_train <- readRDS(file=fs::path(r_objects_folder, "082_sages_train.rds"))
# sages_split <- readRDS(file=fs::path(r_objects_folder, "082_sages_split.rds"))
sages_reduced <- readRDS(file=fs::path(r_objects_folder, "082_sages_reduced.rds"))

pca93_to_keep <-  readRDS(file=fs::path(r_objects_folder, "082_pca93_to_keep.rds"))
pca7_to_keep  <-  readRDS(file=fs::path(r_objects_folder, "082_pca7_to_keep.rds"))
pca14_to_keep <-  readRDS(file=fs::path(r_objects_folder, "082_pca14_to_keep.rds"))
pca32_to_keep <-  readRDS(file=fs::path(r_objects_folder, "082_pca32_to_keep.rds"))

# glm_wf     <- readRDS(file=fs::path(r_objects_folder, "085_glm_wf.rds"))
# lgbm_wf_93    <- readRDS(file=fs::path(r_objects_folder, "085_lgbm_wf_93.rds"))

glmnet_wf_93  <- readRDS(file=fs::path(r_objects_folder, "085_glmnet_wf_93.rds"))
glmnet_wf_7   <- readRDS(file=fs::path(r_objects_folder, "085_glmnet_wf_7.rds"))
glmnet_wf_14  <- readRDS(file=fs::path(r_objects_folder, "085_glmnet_wf_14.rds"))
glmnet_wf_32  <- readRDS(file=fs::path(r_objects_folder, "085_glmnet_wf_32.rds"))

glmnet_wf_93_rcs  <- readRDS(file=fs::path(r_objects_folder, "085_glmnet_wf_93_rcs.rds"))
glmnet_wf_7_rcs   <- readRDS(file=fs::path(r_objects_folder, "085_glmnet_wf_7_rcs.rds"))
glmnet_wf_14_rcs  <- readRDS(file=fs::path(r_objects_folder, "085_glmnet_wf_14_rcs.rds"))
glmnet_wf_32_rcs  <- readRDS(file=fs::path(r_objects_folder, "085_glmnet_wf_32_rcs.rds"))

rf_wf_93  <- readRDS(file=fs::path(r_objects_folder, "085_rf_wf_93.rds"))
rf_wf_7   <- readRDS(file=fs::path(r_objects_folder, "085_rf_wf_7.rds"))
rf_wf_14  <- readRDS(file=fs::path(r_objects_folder, "085_rf_wf_14.rds"))
rf_wf_32  <- readRDS(file=fs::path(r_objects_folder, "085_rf_wf_32.rds"))

set.seed(222)
# Put 80% of the data into the training set
sages_split <- rsample::initial_split(sages_reduced, prop = .8)

# Create data frames for the two sets:
sages_train <- rsample::training(sages_split)
sages_test  <- rsample::testing(sages_split)

set.seed(12)
sages_folds <- vfold_cv(sages_train, v = 10)

grid_glmnet <- 
  glmnet_wf_93 %>% 
  extract_parameter_set_dials() %>% 
  grid_latin_hypercube(size = 25)


# grid_lgbm <- 
#   lgbm_wf %>% 
#   extract_parameter_set_dials() %>% 
#   grid_latin_hypercube(size = 25)

ctrl <- control_grid(save_pred = TRUE)
sages_metrics <- metric_set(accuracy, kap, roc_auc)


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

glmnet_res_93_rcs <- glmnet_wf_93_rcs %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_glmnet,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

glmnet_res_7_rcs <- glmnet_wf_7_rcs %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_glmnet,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

glmnet_res_14_rcs <- glmnet_wf_14_rcs %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_glmnet,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

glmnet_res_32_rcs <- glmnet_wf_32_rcs %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_glmnet,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

#####################
### Random forest
grid_rf <-
  rf_wf_93 %>%
  extract_parameter_set_dials() %>%
  grid_latin_hypercube(size = 40)


rf_res_93 <- rf_wf_93 %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_rf,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

rf_res_7 <- rf_wf_7 %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_rf,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

rf_res_14 <- rf_wf_14 %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_rf,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

rf_res_32 <- rf_wf_32 %>%
  tune_grid(
    resamples = sages_folds,
    grid = grid_rf,
    # The options below are not required by default
    control = ctrl,
    metrics = sages_metrics
  )

saveRDS(glmnet_res_93,         file=fs::path(r_objects_folder, "090_glmnet_res_93.rds"))
saveRDS(glmnet_res_7,          file=fs::path(r_objects_folder, "090_glmnet_res_7.rds"))
saveRDS(glmnet_res_14,         file=fs::path(r_objects_folder, "090_glmnet_res_14.rds"))
saveRDS(glmnet_res_32,         file=fs::path(r_objects_folder, "090_glmnet_res_32.rds"))
saveRDS(glmnet_res_93_rcs,         file=fs::path(r_objects_folder, "090_glmnet_res_93_rcs.rds"))
saveRDS(glmnet_res_7_rcs,          file=fs::path(r_objects_folder, "090_glmnet_res_7_rcs.rds"))
saveRDS(glmnet_res_14_rcs,         file=fs::path(r_objects_folder, "090_glmnet_res_14_rcs.rds"))
saveRDS(glmnet_res_32_rcs,         file=fs::path(r_objects_folder, "090_glmnet_res_32_rcs.rds"))
saveRDS(rf_res_93,         file=fs::path(r_objects_folder, "090_rf_res_93.rds"))
saveRDS(rf_res_7,          file=fs::path(r_objects_folder, "090_rf_res_7.rds"))
saveRDS(rf_res_14,         file=fs::path(r_objects_folder, "090_rf_res_14.rds"))
saveRDS(rf_res_32,         file=fs::path(r_objects_folder, "090_rf_res_32.rds"))

collect_metrics(glmnet_res_93)
collect_metrics(glmnet_res_7)
collect_metrics(glmnet_res_14)
collect_metrics(glmnet_res_32)
show_best(glmnet_res_93, metric = "kap")
show_best(glmnet_res_7, metric = "kap")
show_best(glmnet_res_14, metric = "kap")
show_best(glmnet_res_32, metric = "kap")

collect_metrics(glmnet_res_93_rcs)
collect_metrics(glmnet_res_7_rcs)
collect_metrics(glmnet_res_14_rcs)
collect_metrics(glmnet_res_32_rcs)
show_best(glmnet_res_93_rcs, metric = "kap")
show_best(glmnet_res_7_rcs, metric = "kap")
show_best(glmnet_res_14_rcs, metric = "kap")
show_best(glmnet_res_32_rcs, metric = "kap")
# # show_best(glmnet_res, metric = "kap")
# # collect_metrics(rf_res)
# # show_best(rf_res, metric = "kap")
# # 
# autoplot(glmnet_res_93)
# # autoplot(rf_res)
# 
glmnet_best_93 <- select_best(glmnet_res_93, metric = "kap")
# glmnet_best_93

glmnet_wf_final_93 <- finalize_workflow(glmnet_wf_93, glmnet_best_93)
glmnet_final_93 <- last_fit(glmnet_wf_final_93, sages_split, metrics = sages_metrics)
# collect_metrics(glmnet_final_93)

glmnet_best_7 <- select_best(glmnet_res_7, metric = "kap")
# glmnet_best_7

glmnet_wf_final_7 <- finalize_workflow(glmnet_wf_7, glmnet_best_7)
glmnet_final_7 <- last_fit(glmnet_wf_final_7, sages_split, metrics = sages_metrics)
# collect_metrics(glmnet_final_7)

glmnet_best_14 <- select_best(glmnet_res_14, metric = "kap")
# glmnet_best_14

glmnet_wf_final_14 <- finalize_workflow(glmnet_wf_14, glmnet_best_14)
glmnet_final_14 <- last_fit(glmnet_wf_final_14, sages_split, metrics = sages_metrics)
# collect_metrics(glmnet_final_14)

glmnet_best_32 <- select_best(glmnet_res_32, metric = "kap")
# glmnet_best_32

glmnet_wf_final_32 <- finalize_workflow(glmnet_wf_32, glmnet_best_32)
glmnet_final_32 <- last_fit(glmnet_wf_final_32, sages_split, metrics = sages_metrics)
# collect_metrics(glmnet_final_32)

glmnet_best_93_rcs <- select_best(glmnet_res_93_rcs, metric = "kap")
# glmnet_best_93_rcs

glmnet_wf_final_93_rcs <- finalize_workflow(glmnet_wf_93_rcs, glmnet_best_93_rcs)
glmnet_final_93_rcs <- last_fit(glmnet_wf_final_93_rcs, sages_split, metrics = sages_metrics)
# collect_metrics(glmnet_final_93_rcs)

glmnet_best_7_rcs <- select_best(glmnet_res_7_rcs, metric = "kap")
# glmnet_best_7_rcs

glmnet_wf_final_7_rcs <- finalize_workflow(glmnet_wf_7_rcs, glmnet_best_7_rcs)
glmnet_final_7_rcs <- last_fit(glmnet_wf_final_7_rcs, sages_split, metrics = sages_metrics)
# collect_metrics(glmnet_final_7_rcs)

glmnet_best_14_rcs <- select_best(glmnet_res_14_rcs, metric = "kap")
# glmnet_best_14_rcs

glmnet_wf_final_14_rcs <- finalize_workflow(glmnet_wf_14_rcs, glmnet_best_14_rcs)
glmnet_final_14_rcs <- last_fit(glmnet_wf_final_14_rcs, sages_split, metrics = sages_metrics)
# collect_metrics(glmnet_final_14_rcs)

glmnet_best_32_rcs <- select_best(glmnet_res_32_rcs, metric = "kap")
# glmnet_best_32_rcs

glmnet_wf_final_32_rcs <- finalize_workflow(glmnet_wf_32_rcs, glmnet_best_32_rcs)
glmnet_final_32_rcs <- last_fit(glmnet_wf_final_32_rcs, sages_split, metrics = sages_metrics)
# collect_metrics(glmnet_final_32_rcs)

rf_best_93 <- select_best(rf_res_93, metric = "kap")
# rf_best_93

rf_wf_final_93 <- finalize_workflow(rf_wf_93, rf_best_93)
rf_final_93 <- last_fit(rf_wf_final_93, sages_split, metrics = sages_metrics)
# collect_metrics(rf_final_93)

rf_best_7 <- select_best(rf_res_7, metric = "kap")
# rf_best_7

rf_wf_final_7 <- finalize_workflow(rf_wf_7, rf_best_7)
rf_final_7 <- last_fit(rf_wf_final_7, sages_split, metrics = sages_metrics)
# collect_metrics(rf_final_7)

rf_best_14 <- select_best(rf_res_14, metric = "kap")
# rf_best_14

rf_wf_final_14 <- finalize_workflow(rf_wf_14, rf_best_14)
rf_final_14 <- last_fit(rf_wf_final_14, sages_split, metrics = sages_metrics)
# collect_metrics(rf_final_14)

rf_best_32 <- select_best(rf_res_32, metric = "kap")
# rf_best_32

rf_wf_final_32 <- finalize_workflow(rf_wf_32, rf_best_32)
rf_final_32 <- last_fit(rf_wf_final_32, sages_split, metrics = sages_metrics)
# collect_metrics(rf_final_32)


# rf_best_93 <- select_best(rf_res_93, metric = "kap")
# rf_best_93
# 
# rf_wf_final_93 <- finalize_workflow(rf_wf_93, rf_best_93)
# rf_final_93 <- last_fit(rf_wf_final_93, sages_split)
# collect_metrics(rf_final_93)
# 
# lgbm_best_93 <- select_best(lgbm_res_93, metric = "kap")
# lgbm_best_93
# 
# lgbm_wf_final_93 <- finalize_workflow(lgbm_wf_93, lgbm_best_93)
# lgbm_final_93 <- last_fit(lgbm_wf_final_93, sages_split)
# collect_metrics(lgbm_final_93)

saveRDS(glmnet_final_93,         file=fs::path(r_objects_folder, "090_glmnet_final_93.rds"))
saveRDS(glmnet_final_7,          file=fs::path(r_objects_folder, "090_glmnet_final_7.rds"))
saveRDS(glmnet_final_14,         file=fs::path(r_objects_folder, "090_glmnet_final_14.rds"))
saveRDS(glmnet_final_32,         file=fs::path(r_objects_folder, "090_glmnet_final_32.rds"))

saveRDS(glmnet_final_93_rcs,         file=fs::path(r_objects_folder, "090_glmnet_final_93_rcs.rds"))
saveRDS(glmnet_final_7_rcs,          file=fs::path(r_objects_folder, "090_glmnet_final_7_rcs.rds"))
saveRDS(glmnet_final_14_rcs,         file=fs::path(r_objects_folder, "090_glmnet_final_14_rcs.rds"))
saveRDS(glmnet_final_32_rcs,         file=fs::path(r_objects_folder, "090_glmnet_final_32_rcs.rds"))

saveRDS(rf_final_93,         file=fs::path(r_objects_folder, "090_rf_final_93.rds"))
saveRDS(rf_final_7,          file=fs::path(r_objects_folder, "090_rf_final_7.rds"))
saveRDS(rf_final_14,         file=fs::path(r_objects_folder, "090_rf_final_14.rds"))
saveRDS(rf_final_32,         file=fs::path(r_objects_folder, "090_rf_final_32.rds"))



