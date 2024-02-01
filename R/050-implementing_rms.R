
sages.combined <-   readRDS(file=fs::path(r_objects_folder, "020_sages_combined.rds"))
sages.combined <- haven::zap_formats(sages.combined)
sages.combined <- haven::zap_label(sages.combined)
sages.combined <- sages.combined %>%
  select(-vdgcp_slope48m)
glimpse(sages.combined)


# Ch 6 - Set up the model
set.seed(222)
# Put 3/4 of the data into the training set 
sages_split <- rsample::initial_split(sages.combined, prop = 3/4)

# Create data frames for the two sets:
sages_train <- rsample::training(sages_split)
sages_test  <- rsample::testing(sages_split)




# Ch 8 - Create the recipe
# Start the recipe to do the RMS redundancy analysis
# Remove variables with (near)zero variance, otherwise the redundancy analysis won't work
sages_recipe_rms <- recipes::recipe(vdgcp_slope36m ~ ., data = sages_train) %>%
  recipes::update_role(studyid, new_role = "id") %>%
  recipes::step_nzv(all_predictors())


# Getting the training data set with the zero variance variables removed
sages_prepped_rms <- recipes::prep(sages_recipe_rms)
sages_juiced_rms <- recipes::juice(sages_prepped_rms)

# Create a formula of all the predictors after the predictors with no variance were dropped
sages_predictors <- colnames(sages_juiced_rms)
sages_predictors <- sages_predictors[!sages_predictors %in% c("studyid", "vdgcp_slope36m", "vdgcp_slope48m")]
b <- paste(sages_predictors, collapse = " + ")
sages_formula <- paste(" ~ ", b, sepby = "") %>% as.formula()
# Do the redundancy analysis
foo <- Hmisc::redun(sages_formula, data = sages_juiced_rms, r2=.85)

# Starting a new recipe by keeping only those variables found in the redundancy analysis

sages_recipe <- recipes::recipe(vdgcp_slope36m ~ ., data = sages_train) %>%
  recipes::update_role(studyid, new_role = "id") %>%
  recipes::step_select(has_role("id"), all_outcomes(), all_of(foo$In)) 
# This prepping and juicing is to double check that the recipe worked
# sages_prepped <- recipes::prep(sages_recipe)
# sages_juiced <- recipes::juice(sages_prepped)


# recipe steps
# Impute values for the few variables that missing values
# Create dummy variables out of the factor variables so they can be used in the PCA
# Normalize the variables because that is better for PCA
# Do the PCA
sages_recipe2 <- sages_recipe %>%
  recipes::step_impute_knn(all_predictors(),
                           impute_with = recipes::imp_vars(all_predictors())) %>%
  recipes::step_dummy(all_nominal(), -has_role("id"), -all_outcomes()) %>%
  recipes::step_normalize(recipes::all_numeric(), -all_outcomes()) %>%
  recipes::step_pca(all_predictors(), threshold = .85)
# This prepping and juicing is to double check that the recipe worked
sages_prepped2 <- recipes::prep(sages_recipe2)
# sages_juiced2 <- recipes::juice(sages_prepped2)


# Moving Ch 7 stuff to after the recipe was created
# Ch 7 - Setup the workflow
glm_mod <- parsnip::linear_reg() %>% 
  parsnip::set_engine("glm")

glm_wf <- workflows::workflow() %>%
  workflows::add_model(glm_mod) %>%
  workflows::add_recipe(sages_recipe2)
glm_fit <- fit(glm_wf, data = sages_train)
# Ch 9 - Model evaluation

# sages_test_baked <- recipes::bake(sages_prepped2, new_data = sages_test)
# sages_test_res <- predict(glm_fit, new_data = sages_test_baked)

sages_test_res <- predict(glm_fit, new_data = sages_test)
sages_test_res <- predict(glm_fit, new_data = sages_test %>% select(-vdgcp_slope36m))
sages_metrics <- metric_set(rmse, rsq, mae)
sages_metrics(ames_test_res, truth = Sale_Price, estimate = .pred)

###################################

sages_recipe3 <- recipes::recipe(vdgcp_slope36m ~ ., data = sages_train) %>%
  recipes::update_role(studyid, new_role = "id") %>%
  # recipes::step_select(has_role("id"), all_outcomes(), all_predictors()) %>%
  recipes::step_impute_knn(all_predictors(),
                           impute_with = recipes::imp_vars(all_predictors())) %>%
  recipes::step_dummy(all_nominal(), -has_role("id"), -all_outcomes()) %>%
  recipes::step_normalize(recipes::all_numeric(), -all_outcomes()) %>%
  recipes::step_pca(all_predictors(), threshold = .85)


glm_wf3 <- workflows::workflow() %>%
  workflows::add_model(glm_mod) %>%
  workflows::add_recipe(sages_recipe3)
glm_fit3 <- fit(glm_wf3, data = sages_train)

sages_test_res3 <- predict(glm_fit3, new_data = sages_test)


glm_fit <- 
  glm_mod %>% 
  parsnip::fit(vdgcp_slope36m ~ vdfemale + vdnonwhite, data = sages_train)
glm_fit


