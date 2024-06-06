rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))

sages_recipe_93  <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe93.rds"))
sages_recipe_7   <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe7.rds"))
sages_recipe_14  <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe14.rds"))
sages_recipe_32  <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe32.rds"))
sages_recipe_rnj  <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe32.rds"))

sages_recipe_93_rcs <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe93_rcs.rds"))
sages_recipe_7_rcs  <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe7_rcs.rds"))
sages_recipe_14_rcs <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe14_rcs.rds"))
sages_recipe_32_rcs <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe32_rcs.rds"))

# N_pca_to_keep <- readRDS(file=fs::path(r_objects_folder, "062_N_pca_to_keep.rds"))



# Ch 7 - Setup the workflow
# Linear regression
# glm_mod <- parsnip::linear_reg() %>% 
#   parsnip::set_engine("glm") %>% 
#   parsnip::set_mode("regression")
# 
# glm_wf <- workflows::workflow() %>%
#   workflows::add_model(glm_mod) %>%
#   workflows::add_recipe(sages_recipe)


# Elastic net
glmnet_mod <- parsnip::linear_reg(penalty = tune(), mixture = tune()) %>% 
  parsnip::set_engine("glmnet") %>% 
  parsnip::set_mode("regression")

glmnet_wf_93 <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe_93)

glmnet_wf_7 <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe_7)

glmnet_wf_14 <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe_14)

glmnet_wf_32 <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe_32)

glmnet_wf_rnj <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe_rnj)

glmnet_wf_93_rcs <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe_93_rcs)

glmnet_wf_7_rcs <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe_7_rcs)

glmnet_wf_14_rcs <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe_14_rcs)

glmnet_wf_32_rcs <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe_32_rcs)

# Random forest
rf_mod <- parsnip::rand_forest(trees = tune(), min_n = tune()) %>%
  parsnip::set_engine("ranger") %>% 
  parsnip::set_mode("regression")

rf_wf_93 <- workflows::workflow() %>% 
  add_model(rf_mod) %>%
  workflows::add_recipe(sages_recipe_93)

rf_wf_7 <- workflows::workflow() %>% 
  add_model(rf_mod) %>%
  workflows::add_recipe(sages_recipe_7)

rf_wf_14 <- workflows::workflow() %>% 
  add_model(rf_mod) %>%
  workflows::add_recipe(sages_recipe_14)

rf_wf_32 <- workflows::workflow() %>% 
  add_model(rf_mod) %>%
  workflows::add_recipe(sages_recipe_32)

# Gradient boosted models
lgbm_mod <- boost_tree(trees = tune(), learn_rate = tune())  %>%
  parsnip::set_engine("lightgbm", num_threads = 1) %>%
  parsnip::set_mode("regression")

lgbm_wf_93 <- workflows::workflow() %>% 
  add_model(lgbm_mod) %>%
  workflows::add_recipe(sages_recipe_93)

lgbm_wf_7 <- workflows::workflow() %>% 
  add_model(lgbm_mod) %>%
  workflows::add_recipe(sages_recipe_7)

lgbm_wf_14 <- workflows::workflow() %>% 
  add_model(lgbm_mod) %>%
  workflows::add_recipe(sages_recipe_14)

lgbm_wf_32 <- workflows::workflow() %>% 
  add_model(lgbm_mod) %>%
  workflows::add_recipe(sages_recipe_32)

lgbm_wf_rnj <- workflows::workflow() %>% 
  add_model(lgbm_mod) %>%
  workflows::add_recipe(sages_recipe_rnj)


# saveRDS(glm_wf,            file=fs::path(r_objects_folder, "065_glm_wf.rds"))
saveRDS(glmnet_wf_93,         file=fs::path(r_objects_folder, "065_glmnet_wf_93.rds"))
saveRDS(rf_wf_93,             file=fs::path(r_objects_folder, "065_rf_wf_93.rds"))
saveRDS(lgbm_wf_93,           file=fs::path(r_objects_folder, "065_lgbm_wf_93.rds"))
saveRDS(glmnet_wf_7,         file=fs::path(r_objects_folder, "065_glmnet_wf_7.rds"))
saveRDS(rf_wf_7,             file=fs::path(r_objects_folder, "065_rf_wf_7.rds"))
saveRDS(lgbm_wf_7,           file=fs::path(r_objects_folder, "065_lgbm_wf_7.rds"))
saveRDS(glmnet_wf_14,         file=fs::path(r_objects_folder, "065_glmnet_wf_14.rds"))
saveRDS(rf_wf_14,             file=fs::path(r_objects_folder, "065_rf_wf_14.rds"))
saveRDS(lgbm_wf_14,           file=fs::path(r_objects_folder, "065_lgbm_wf_14.rds"))
saveRDS(glmnet_wf_32,         file=fs::path(r_objects_folder, "065_glmnet_wf_32.rds"))
saveRDS(rf_wf_32,             file=fs::path(r_objects_folder, "065_rf_wf_32.rds"))
saveRDS(lgbm_wf_32,           file=fs::path(r_objects_folder, "065_lgbm_wf_32.rds"))
saveRDS(glmnet_wf_rnj,         file=fs::path(r_objects_folder, "065_glmnet_wf_rnj.rds"))

saveRDS(glmnet_wf_93_rcs,         file=fs::path(r_objects_folder, "065_glmnet_wf_93_rcs.rds"))
saveRDS(glmnet_wf_7_rcs,         file=fs::path(r_objects_folder, "065_glmnet_wf_7_rcs.rds"))
saveRDS(glmnet_wf_14_rcs,         file=fs::path(r_objects_folder, "065_glmnet_wf_14_rcs.rds"))
saveRDS(glmnet_wf_32_rcs,         file=fs::path(r_objects_folder, "065_glmnet_wf_32_rcs.rds"))




