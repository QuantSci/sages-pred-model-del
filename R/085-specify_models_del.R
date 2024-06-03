rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))

sages_recipe_93  <- readRDS(file=fs::path(r_objects_folder, "082_sages_recipe93.rds"))
sages_recipe_7   <- readRDS(file=fs::path(r_objects_folder, "082_sages_recipe7.rds"))
sages_recipe_14  <- readRDS(file=fs::path(r_objects_folder, "082_sages_recipe14.rds"))
sages_recipe_32  <- readRDS(file=fs::path(r_objects_folder, "082_sages_recipe32.rds"))

sages_recipe_93_rcs <- readRDS(file=fs::path(r_objects_folder, "082_sages_recipe93_rcs.rds"))
sages_recipe_7_rcs  <- readRDS(file=fs::path(r_objects_folder, "082_sages_recipe7_rcs.rds"))
sages_recipe_14_rcs <- readRDS(file=fs::path(r_objects_folder, "082_sages_recipe14_rcs.rds"))
sages_recipe_32_rcs <- readRDS(file=fs::path(r_objects_folder, "082_sages_recipe32_rcs.rds"))

# N_pca_to_keep <- readRDS(file=fs::path(r_objects_folder, "082_N_pca_to_keep.rds"))

glmnet_mod <- parsnip::logistic_reg(penalty = tune(), mixture = tune()) %>% 
  parsnip::set_engine("glmnet") %>% 
  parsnip::set_mode("classification")

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
  parsnip::set_mode("classification")

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
  parsnip::set_mode("classification")

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


# saveRDS(glm_wf,            file=fs::path(r_objects_folder, "085_glm_wf.rds"))
saveRDS(glmnet_wf_93,         file=fs::path(r_objects_folder, "085_glmnet_wf_93.rds"))
saveRDS(rf_wf_93,             file=fs::path(r_objects_folder, "085_rf_wf_93.rds"))
saveRDS(lgbm_wf_93,           file=fs::path(r_objects_folder, "085_lgbm_wf_93.rds"))
saveRDS(glmnet_wf_7,         file=fs::path(r_objects_folder, "085_glmnet_wf_7.rds"))
saveRDS(rf_wf_7,             file=fs::path(r_objects_folder, "085_rf_wf_7.rds"))
saveRDS(lgbm_wf_7,           file=fs::path(r_objects_folder, "085_lgbm_wf_7.rds"))
saveRDS(glmnet_wf_14,         file=fs::path(r_objects_folder, "085_glmnet_wf_14.rds"))
saveRDS(rf_wf_14,             file=fs::path(r_objects_folder, "085_rf_wf_14.rds"))
saveRDS(lgbm_wf_14,           file=fs::path(r_objects_folder, "085_lgbm_wf_14.rds"))
saveRDS(glmnet_wf_32,         file=fs::path(r_objects_folder, "085_glmnet_wf_32.rds"))
saveRDS(rf_wf_32,             file=fs::path(r_objects_folder, "085_rf_wf_32.rds"))
saveRDS(lgbm_wf_32,           file=fs::path(r_objects_folder, "085_lgbm_wf_32.rds"))

saveRDS(glmnet_wf_93_rcs,         file=fs::path(r_objects_folder, "085_glmnet_wf_93_rcs.rds"))
saveRDS(glmnet_wf_7_rcs,         file=fs::path(r_objects_folder,  "085_glmnet_wf_7_rcs.rds"))
saveRDS(glmnet_wf_14_rcs,         file=fs::path(r_objects_folder, "085_glmnet_wf_14_rcs.rds"))
saveRDS(glmnet_wf_32_rcs,         file=fs::path(r_objects_folder, "085_glmnet_wf_32_rcs.rds"))
