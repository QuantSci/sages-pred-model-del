rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))


sages_combined <-   readRDS(file=fs::path(r_objects_folder, "022_sages_combined.rds"))
variable_df <- readRDS(file=fs::path(r_objects_folder, "021_variable_df.rds"))
outcome_variables <- readRDS(file=fs::path(r_objects_folder, "020_outcome_variables.rds"))

the_outcome_variable <- "vdgcp_slope72m"
outcome_variables_to_drop <- outcome_variables[!outcome_variables %in% the_outcome_variable]

sages_combined <- haven::zap_formats(sages_combined)
sages_combined <- haven::zap_label(sages_combined)
sages_combined <- sages_combined %>%
  select(-all_of(outcome_variables_to_drop))
# glimpse(sages_combined)


# Ch 8 - Create the recipe
# Start the recipe to do the RMS redundancy analysis
# Remove variables with (near)zero variance, otherwise the redundancy analysis won't work
sages_recipe_rms <- recipes::recipe(vdgcp_slope72m ~ ., data = sages_combined) %>%
  recipes::step_nzv(all_predictors(), freq_cut = 96/4)


# Getting the training data set with the zero variance variables removed
sages_prepped_rms <- recipes::prep(sages_recipe_rms)
sages_juiced_rms <- recipes::juice(sages_prepped_rms)


# Create a formula of all the predictors after the predictors with no variance were dropped
sages_predictors <- colnames(sages_juiced_rms)
sages_predictors <- sages_predictors[!sages_predictors %in% c("studyid", "vdsagesdeliriumever", "vdgcp_slope36m", "vdgcp_slope48m", "vdgcp_slope72m")]
b <- paste(sages_predictors, collapse = " + ")
sages_formula <- paste(" ~ ", b, sepby = "") %>% as.formula()
# Do the redundancy analysis
foo <- Hmisc::redun(sages_formula, data = sages_juiced_rms, r2=.85)

variables_to_keep <- foo$In[!(foo$In %in% "vdp41516")]
# Starting a new recipe by keeping only those variables found in the redundancy analysis
sages_recipe <- recipes::recipe(vdgcp_slope72m ~ ., data = sages_combined) %>%
  # recipes::update_role(studyid, new_role = "id") %>%
  recipes::step_select(has_role("id"), all_outcomes(), all_of(variables_to_keep)) 
# Creating a new data set based on the reduced variable list, and then recreating the training/testing split
sages_prepped <- recipes::prep(sages_recipe)
sages_reduced <- recipes::bake(sages_prepped, new_data = sages_combined)





### Save the R objects
saveRDS(sages_juiced_rms,            file=fs::path(r_objects_folder, "060_sages_juiced_rms.rds"))
saveRDS(sages_reduced,            file=fs::path(r_objects_folder, "060_sages_reduced.rds"))
# saveRDS(sages_recipe,            file=fs::path(r_objects_folder, "060_sages_recipe.rds"))
saveRDS(variables_to_keep,            file=fs::path(r_objects_folder, "060_variables_to_keep.rds"))



