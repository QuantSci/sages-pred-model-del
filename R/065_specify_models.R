
sages_train <- readRDS(file=fs::path(r_objects_folder, "060_sages_train.rds"))


# recipe steps
# Impute values for the few variables that missing values
# Create dummy variables out of the factor variables so they can be used in the PCA
# Normalize the variables because that is better for PCA
# Do the PCA
sages_recipe2 <- recipes::recipe(vdgcp_slope36m ~ ., data = sages_train) %>%
  recipes::update_role(studyid, new_role = "id") %>%
  recipes::step_impute_knn(all_predictors(),
                           impute_with = recipes::imp_vars(all_predictors())) %>%
  recipes::step_dummy(all_nominal(), -has_role("id"), -all_outcomes()) %>%
  recipes::step_normalize(recipes::all_numeric(), -all_outcomes()) %>%
  recipes::step_pca(all_predictors(), threshold = .85)

# Ch 7 - Setup the workflow
# Linear regression
glm_mod <- parsnip::linear_reg() %>% 
  parsnip::set_engine("glm") %>% 
  parsnip::set_mode("regression")

glm_wf <- workflows::workflow() %>%
  workflows::add_model(glm_mod) %>%
  workflows::add_recipe(sages_recipe2)


# Elastic net
glmnet_mod <- parsnip::linear_reg(penalty = tune()) %>% 
  parsnip::set_engine("glmnet") %>% 
  parsnip::set_mode("regression")

glmnet_wf <- workflows::workflow() %>%
  workflows::add_model(glmnet_mod) %>%
  workflows::add_recipe(sages_recipe2)

# Random forest
rf_mod <- parsnip::rand_forest(trees = tune(), min_n = tune()) %>%
  parsnip::set_engine("ranger") %>% 
  parsnip::set_mode("regression")

rf_wf <- workflows::workflow() %>% 
  add_model(rf_mod) %>%
  workflows::add_recipe(sages_recipe2)

# Gradient boosted models
lgbm_mod <- boost_tree(trees = tune(), learn_rate = tune())  %>%
  parsnip::set_engine("lightgbm", num_threads = 1) %>%
  parsnip::set_mode("regression")

lgbm_wf <- workflows::workflow() %>% 
  add_model(lgbm_mod) %>%
  workflows::add_recipe(sages_recipe2)

saveRDS(sages_recipe2,     file=fs::path(r_objects_folder, "065_sages_recipe2.rds"))
saveRDS(glm_wf,            file=fs::path(r_objects_folder, "065_glm_wf.rds"))
saveRDS(glmnet_wf,         file=fs::path(r_objects_folder, "065_glmnet_wf.rds"))
saveRDS(rf_wf,             file=fs::path(r_objects_folder, "065_rf_wf.rds"))
saveRDS(lgbm_wf,           file=fs::path(r_objects_folder, "065_lgbm_wf.rds"))

