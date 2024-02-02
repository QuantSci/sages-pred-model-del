

sages_combined <-   readRDS(file=fs::path(r_objects_folder, "020_sages_combined.rds"))
variable_df <- readRDS(file=fs::path(r_objects_folder, "021_variable_df.rds"))

covariates_to_use <- variable_df %>%
  filter(covariates_to_use_3) %>%
  pull(covariates_all)

sages_combined <- sages_combined %>%
  select(all_of(covariates_to_use))


sages_combined <- haven::zap_formats(sages_combined)
sages_combined <- haven::zap_label(sages_combined)
sages_combined <- sages_combined %>%
  select(-vdsagesdeliriumever, -vdgcp_slope48m)
# glimpse(sages_combined)


# Ch 6 - Set up the model
# set.seed(222)
# # Put 80% of the data into the training set 
# sages_split <- rsample::initial_split(sages_combined, prop = .8)
# 
# # Create data frames for the two sets:
# sages_train_pre_rms <- rsample::training(sages_split)
# sages_test_pre_rms  <- rsample::testing(sages_split)



# Ch 8 - Create the recipe
# Start the recipe to do the RMS redundancy analysis
# Remove variables with (near)zero variance, otherwise the redundancy analysis won't work
sages_recipe_rms <- recipes::recipe(vdgcp_slope36m ~ ., data = sages_combined) %>%
  recipes::step_nzv(all_predictors())


# Getting the training data set with the zero variance variables removed
sages_prepped_rms <- recipes::prep(sages_recipe_rms)
sages_juiced_rms <- recipes::juice(sages_prepped_rms)

saveRDS(sages_juiced_rms,            file=fs::path(r_objects_folder, "060_sages_juiced_rms.rds"))

# Create a formula of all the predictors after the predictors with no variance were dropped
sages_predictors <- colnames(sages_juiced_rms)
sages_predictors <- sages_predictors[!sages_predictors %in% c("studyid", "vdgcp_slope36m", "vdgcp_slope48m")]
b <- paste(sages_predictors, collapse = " + ")
sages_formula <- paste(" ~ ", b, sepby = "") %>% as.formula()
# Do the redundancy analysis
foo <- Hmisc::redun(sages_formula, data = sages_juiced_rms, r2=.85)


# Starting a new recipe by keeping only those variables found in the redundancy analysis
sages_recipe <- recipes::recipe(vdgcp_slope36m ~ ., data = sages_combined) %>%
  # recipes::update_role(studyid, new_role = "id") %>%
  recipes::step_select(has_role("id"), all_outcomes(), all_of(foo$In)) 
# Creating a new data set based on the reduced variable list, and then recreating the training/testing split
sages_prepped <- recipes::prep(sages_recipe)
sages_reduced <- recipes::bake(sages_prepped, new_data = sages_combined)

saveRDS(sages_reduced,            file=fs::path(r_objects_folder, "060_sages_reduced.rds"))


set.seed(222)
# Put 80% of the data into the training set 
sages_split <- rsample::initial_split(sages_reduced, prop = .8)

# Create data frames for the two sets:
sages_train <- rsample::training(sages_split)
sages_test  <- rsample::testing(sages_split)

### Save the R objects
saveRDS(sages_split,            file=fs::path(r_objects_folder, "060_sages_split.rds"))
saveRDS(sages_train,            file=fs::path(r_objects_folder, "060_sages_train.rds"))
saveRDS(sages_test,            file=fs::path(r_objects_folder, "060_sages_test.rds"))



