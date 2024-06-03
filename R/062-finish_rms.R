rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))

sages_reduced <- readRDS(file=fs::path(r_objects_folder, "060_sages_reduced.rds"))
# sages_recipe <- readRDS(file=fs::path(r_objects_folder, "060_sages_recipe.rds"))

# These are the results from the expert panel
# vdage-vdiadlanyc are 7 with 3+ votes
expert_panel_3plus_nice_names <- c("vdage", "vdp43301", "vdp41721", "vdgcp_rta", "vdcci", "vdeduc_r", "vdiadlanyc")
# vdfemale-vdsurg are 13 with 2+ votes
expert_panel_2plus_nice_names <- c(expert_panel_3plus_nice_names, "vdfemale", "vdp41508", "vdsf12pcs", "vdfriedfrail5", "vdapache", "vdsurg")
# vdnonwhite-vdhearingimp are any receiving 1+ votes
expert_panel_1plus_nice_names <- c(expert_panel_2plus_nice_names, "vdnonwhite", "vdlivesalone", "ins03", "lab01a", "lab05a", "lab15c", "lab.bun.cre.ratio.1", 
                                   "vdp43101", "vdp41509", "vdp41722", "wtar01", "vdadlany", "vdgds15", "vdhearingimp", "vdp41504", "vdp41515", "op01_3", "apoe4")


# 7 variables
expert_panel_3plus <- c("vdage", "vdp43301_Yes", "vdp41721_Yes", "vdgcp_rta", 
                        "vdcci", "vdeduc_r", "vdiadlanyc_Impairment")
# 7 + 7 variables
expert_panel_2plus <- c(expert_panel_3plus, "vdfemale_Female", "vdp41508", "vdsf12pcs", "vdfriedfrail5_Slow_timed_walk", 
                        "vdapache", "vdsurg_Vascular", "vdsurg_Gastrointestinal")
# 7 + 7 + 18 variables
expert_panel_1plus <- c(expert_panel_2plus, "vdnonwhite_Nonwhite", "vdlivesalone_Alone", "ins03_No.Private.Insurance", "lab01a", 
                        "lab05a", "lab15c", "lab.bun.cre.ratio.1", "vdp43101", 
                        "vdp41509", "vdp41722_Yes", "wtar01", "vdadlany_Impairment", 
                        "vdgds15", "vdhearingimp_Impairment", "vdp41504_Yes", "vdp41515", 
                        "op01_3_ASA.class._3_4", "apoe4_X1")
# Checking that the variable names are specified correctly after step_dummy turned some into dummy indicators
# sages_juiced %>%
#   select(all_of(expert_panel_1plus))

N_pca_to_keep <- 15
pca93_to_keep <- str_c("pca93_", str_pad(1:N_pca_to_keep, pad = "0", width = 2))
pca7_to_keep <- str_c("pca7_", 1:7)
pca14_to_keep <- str_c("pca14_", str_pad(1:14, pad = "0", width = 2))
pca32_to_keep <- str_c("pca32_", str_pad(1:N_pca_to_keep, pad = "0", width = 2))

sages_reduced <- sages_reduced %>%
  filter(!is.na(vdgcp_slope72m))


# str(sages_train)

as.double.factor <- function(x) {
  as.numeric(levels(x))[x]
}
sages_reduced <- sages_reduced %>%
  mutate(
    # vdsf12pf = as.double.factor(vdsf12pf),
    # vdsf12rp = as.double.factor(vdsf12rp),
    # vdsf12bp = as.double.factor(vdsf12bp),
    # vdsf12gh = as.double.factor(vdsf12gh),
    # vdsf12vt = as.double.factor(vdsf12vt),
    # vdsf12sf = as.double.factor(vdsf12sf),
    # vdsf12re = as.double.factor(vdsf12re),
    # vdsf12mh = as.double.factor(vdsf12mh),
    vdp41515 = fct_collapse(vdp41515, "2" = "2_3"),
    vdp41515 = as.double.factor(vdp41515)
  )

# set.seed(222)
# # Put 80% of the data into the training set 
# sages_split <- rsample::initial_split(sages_reduced, prop = .8)
# 
# # Create data frames for the two sets:
# sages_train <- rsample::training(sages_split)
# sages_test  <- rsample::testing(sages_split)


my_rcs1 <- function(x) {
  rms::rcs(x, 3)[,1]
}
my_rcs2 <- function(x) {
  rms::rcs(x, 3)[,2]
}
# recipe steps
# For each of these four scenarios:
# 1. on all the variables
# 2. on the subset of variables that received at least 3 votes from the expert panel 
# 3. on the subset of variables that received at least 2 votes from the expert panel 
# 4. on the subset of variables that received at least 1 votes from the expert panel 

# - part A (used more for the report)
# Create dummy variables out of the factor variables so they can be used in the PCA
# Normalize the variables because that is better for PCA
# Do the PCA, keep all the components

# - part B (used for the analysis)
# keep the top 14 components

# - part C
# create the restricted cubic splines
# keep the splines


sages_recipe_93_all_pca <- recipes::recipe(vdgcp_slope72m ~ ., data = sages_reduced) %>%
  recipes::step_dummy(all_nominal(), -all_outcomes()) %>%
  recipes::step_normalize(recipes::all_numeric(), -all_outcomes()) %>%
  recipes::step_pca(all_predictors(), num_comp = 94, prefix = "pca93_", keep_original_cols = FALSE)
sages_prepped93 <- recipes::prep(sages_recipe_93_all_pca)
sages_juiced93 <- recipes::juice(sages_prepped93)

sages_recipe_93 <- sages_recipe_93_all_pca  %>%
  step_select(vdgcp_slope72m, all_of(pca93_to_keep))

sages_recipe_93_rcs <- sages_recipe_93 %>%
  step_mutate_at(all_predictors(), fn = list(rcs1 = my_rcs1, rcs2 = my_rcs2)) %>%
  step_select(all_outcomes(), contains("rcs"))

sages_recipe_7_all_pca <- recipes::recipe(vdgcp_slope72m ~ ., data = sages_reduced) %>%
  recipes::step_dummy(all_nominal(), -all_outcomes()) %>%
  recipes::step_normalize(recipes::all_numeric(), -all_outcomes()) %>%
  recipes::step_pca(all_predictors(), num_comp = 7, columns = expert_panel_3plus, prefix = "pca7_", keep_original_cols = FALSE)  
sages_prepped7 <- recipes::prep(sages_recipe_7_all_pca)
sages_juiced7 <- recipes::juice(sages_prepped7)

sages_recipe_7 <- sages_recipe_7_all_pca  %>%
  step_select(vdgcp_slope72m, all_of(pca7_to_keep))

sages_recipe_7_rcs <- sages_recipe_7 %>%
  step_mutate_at(all_predictors(), fn = list(rcs1 = my_rcs1, rcs2 = my_rcs2)) %>%
  step_select(all_outcomes(), contains("rcs"))

sages_recipe_14_all_pca <- recipes::recipe(vdgcp_slope72m ~ ., data = sages_reduced) %>%
  recipes::step_dummy(all_nominal(), -all_outcomes()) %>%
  recipes::step_normalize(recipes::all_numeric(), -all_outcomes()) %>%
  recipes::step_pca(all_predictors(), num_comp = 14, columns = expert_panel_2plus, prefix = "pca14_", keep_original_cols = FALSE)  
sages_prepped14 <- recipes::prep(sages_recipe_14_all_pca)
sages_juiced14 <- recipes::juice(sages_prepped14)

sages_recipe_14 <- sages_recipe_14_all_pca  %>%
  step_select(vdgcp_slope72m, all_of(pca14_to_keep))

sages_recipe_14_rcs <- sages_recipe_14 %>%
  step_mutate_at(all_predictors(), fn = list(rcs1 = my_rcs1, rcs2 = my_rcs2)) %>%
  step_select(all_outcomes(), contains("rcs"))

sages_recipe_32_all_pca <- recipes::recipe(vdgcp_slope72m ~ ., data = sages_reduced) %>%
  recipes::step_dummy(all_nominal(), -all_outcomes()) %>%
  recipes::step_normalize(recipes::all_numeric(), -all_outcomes()) %>%
  recipes::step_pca(all_predictors(), num_comp = 32, columns = expert_panel_1plus, prefix = "pca32_", keep_original_cols = FALSE)  
sages_prepped32 <- recipes::prep(sages_recipe_32_all_pca)
sages_juiced32 <- recipes::juice(sages_prepped32)

sages_recipe_32 <- sages_recipe_32_all_pca  %>%
  step_select(vdgcp_slope72m, all_of(pca32_to_keep))

sages_recipe_32_rcs <- sages_recipe_32 %>%
  step_mutate_at(all_predictors(), fn = list(rcs1 = my_rcs1, rcs2 = my_rcs2)) %>%
  step_select(all_outcomes(), contains("rcs"))


# doing the splines in a different file
# sages_recipe4 <- sages_recipe3 %>%
#   step_ns(all_predictors(), deg_free = 3)
# 
# sages_prepped4 <- recipes::prep(sages_recipe4)
# sages_juiced4 <- recipes::juice(sages_prepped4)


saveRDS(N_pca_to_keep,       file=fs::path(r_objects_folder, "062_N_pca_to_keep.rds"))
saveRDS(sages_reduced,           file=fs::path(r_objects_folder, "062_sages_reduced.rds"))
saveRDS(sages_juiced93,           file=fs::path(r_objects_folder, "062_sages_juiced93.rds"))
saveRDS(sages_juiced7,           file=fs::path(r_objects_folder, "062_sages_juiced7.rds"))
saveRDS(sages_juiced14,           file=fs::path(r_objects_folder, "062_sages_juiced14.rds"))
saveRDS(sages_juiced32,           file=fs::path(r_objects_folder, "062_sages_juiced32.rds"))

# saveRDS(sages_split,       file=fs::path(r_objects_folder, "062_sages_split.rds"))
# saveRDS(sages_train,       file=fs::path(r_objects_folder, "062_sages_train.rds"))
# saveRDS(sages_test,        file=fs::path(r_objects_folder, "062_sages_test.rds"))
# saveRDS(n_pca,             file=fs::path(r_objects_folder, "062_n_pca.rds"))

saveRDS(expert_panel_3plus,     file=fs::path(r_objects_folder, "062_expert_panel_3plus.rds"))
saveRDS(expert_panel_2plus,     file=fs::path(r_objects_folder, "062_expert_panel_2plus.rds"))
saveRDS(expert_panel_1plus,     file=fs::path(r_objects_folder, "062_expert_panel_1plus.rds"))
saveRDS(expert_panel_3plus_nice_names,     file=fs::path(r_objects_folder, "062_expert_panel_3plus_nice_names.rds"))
saveRDS(expert_panel_2plus_nice_names,     file=fs::path(r_objects_folder, "062_expert_panel_2plus_nice_names.rds"))
saveRDS(expert_panel_1plus_nice_names,     file=fs::path(r_objects_folder, "062_expert_panel_1plus_nice_names.rds"))

saveRDS(sages_recipe_93,     file=fs::path(r_objects_folder, "062_sages_recipe93.rds"))
saveRDS(sages_recipe_7,      file=fs::path(r_objects_folder, "062_sages_recipe7.rds"))
saveRDS(sages_recipe_14,     file=fs::path(r_objects_folder, "062_sages_recipe14.rds"))
saveRDS(sages_recipe_32,     file=fs::path(r_objects_folder, "062_sages_recipe32.rds"))

saveRDS(sages_recipe_93_rcs,     file=fs::path(r_objects_folder, "062_sages_recipe93_rcs.rds"))
saveRDS(sages_recipe_7_rcs,      file=fs::path(r_objects_folder, "062_sages_recipe7_rcs.rds"))
saveRDS(sages_recipe_14_rcs,     file=fs::path(r_objects_folder, "062_sages_recipe14_rcs.rds"))
saveRDS(sages_recipe_32_rcs,     file=fs::path(r_objects_folder, "062_sages_recipe32_rcs.rds"))

saveRDS(pca93_to_keep,     file=fs::path(r_objects_folder, "062_pca93_to_keep.rds"))
saveRDS(pca7_to_keep,      file=fs::path(r_objects_folder, "062_pca7_to_keep.rds"))
saveRDS(pca14_to_keep,     file=fs::path(r_objects_folder, "062_pca14_to_keep.rds"))
saveRDS(pca32_to_keep,     file=fs::path(r_objects_folder, "062_pca32_to_keep.rds"))

# readr::write_csv(sages_juiced2, here::here("data", "062_sages_juiced2.csv"))





