rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))

sages_recipe <- readRDS(file=fs::path(r_objects_folder, "062_sages_recipe2.rds"))
sages_juiced <- readRDS(file=fs::path(r_objects_folder, "062_sages_juiced2.rds"))
N_pca_to_keep <- readRDS(file=fs::path(r_objects_folder, "062_N_pca_to_keep.rds"))


pca93_to_keep <- str_c("pca93_", str_pad(1:N_pca_to_keep, pad = "0", width = 2))
pca7_to_keep <- str_c("pca7_", 1:7)
pca14_to_keep <- str_c("pca14_", str_pad(1:14, pad = "0", width = 2))
pca32_to_keep <- str_c("pca32_", str_pad(1:N_pca_to_keep, pad = "0", width = 2))

sages_recipe_93 <- sages_recipe %>%
  step_select(vdgcp_slope72m, all_of(pca93_to_keep))
sages_recipe_7 <- sages_recipe %>%
  step_select(vdgcp_slope72m, all_of(pca7_to_keep))
sages_recipe_14 <- sages_recipe %>%
  step_select(vdgcp_slope72m, all_of(pca14_to_keep))
sages_recipe_32 <- sages_recipe %>%
  step_select(vdgcp_slope72m, all_of(pca32_to_keep))



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

saveRDS(sages_recipe_93,     file=fs::path(r_objects_folder, "065_sages_recipe_93.rds"))
saveRDS(sages_recipe_7,      file=fs::path(r_objects_folder, "065_sages_recipe_7.rds"))
saveRDS(sages_recipe_14,     file=fs::path(r_objects_folder, "065_sages_recipe_14.rds"))
saveRDS(sages_recipe_32,     file=fs::path(r_objects_folder, "065_sages_recipe_32.rds"))
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

