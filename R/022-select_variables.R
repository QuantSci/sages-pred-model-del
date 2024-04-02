
sages_combined <-   readRDS(file=fs::path(r_objects_folder, "020_sages_combined.rds"))
variable_df <- readRDS(file=fs::path(r_objects_folder, "021_variable_df.rds"))

covariates_to_use <- variable_df %>%
  filter(covariates_to_use_4) %>%
  pull(covariates_all)

sages_combined <- sages_combined %>%
  select(all_of(covariates_to_use))

saveRDS(sages_combined,            file=fs::path(r_objects_folder, "022_sages_combined.rds"))
