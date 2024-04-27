rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))

sages_reduced <- readRDS(file=fs::path(r_objects_folder, "080_sages_reduced.rds"))
sages_recipe <- readRDS(file=fs::path(r_objects_folder, "080_sages_recipe.rds"))



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

set.seed(222)
# Put 80% of the data into the training set 
sages_split <- rsample::initial_split(sages_reduced, prop = .8)

# Create data frames for the two sets:
sages_train <- rsample::training(sages_split)
sages_test  <- rsample::testing(sages_split)



# recipe steps
# Create dummy variables out of the factor variables so they can be used in the PCA
# Normalize the variables because that is better for PCA
# Do the PCA:
# 1. on all the variables
# 2. on the subset of variables that received at least 3 votes from the expert panel 
# 3. on the subset of variables that received at least 2 votes from the expert panel 
# 4. on the subset of variables that received at least 1 votes from the expert panel 

sages_recipe <- recipes::recipe(vdsagesdeliriumever ~ ., data = sages_train) %>%
  recipes::step_dummy(all_nominal(), -all_outcomes()) %>%
  recipes::step_normalize(recipes::all_numeric(), -all_outcomes()) 
sages_prepped <- recipes::prep(sages_recipe)
sages_juiced <- recipes::juice(sages_prepped)

# This is to make sure we get all the pca components from the first step
n_pca <- (length(sages_juiced)-1)

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


sages_recipe2 <- sages_recipe %>%
  recipes::step_pca(all_predictors(), num_comp = n_pca, prefix = "pca93_", keep_original_cols = TRUE) %>%
  recipes::step_pca(all_predictors(), num_comp = 7, columns = expert_panel_3plus, prefix = "pca7_", keep_original_cols = TRUE) %>%
  recipes::step_pca(all_predictors(), num_comp = 14, columns = expert_panel_2plus, prefix = "pca14_", keep_original_cols = TRUE) %>%
  recipes::step_pca(all_predictors(), num_comp = 32, columns = expert_panel_1plus, prefix = "pca32_", keep_original_cols = TRUE)

sages_prepped2 <- recipes::prep(sages_recipe2)
sages_juiced2 <- recipes::juice(sages_prepped2)

# foo <- sages_juiced2 %>%
#   select(starts_with("pca93")) %>%
#   var() %>%
#   diag()
# amount_var_explained <- foo / sum(foo)
# cumsum(amount_var_explained)
# goo <- tibble(v = amount_var_explained,
#               sum = cumsum(v)) %>%
#   mutate(pc = row_number())
# 
# ggplot(goo, aes(x = pc, y = sum)) +
#   geom_line() +
#   scale_x_continuous("Number of components") +
#   scale_y_continuous("Percent variance explained") +
#   hrbrthemes::theme_ipsum()
# 
# 
# foo <- sages_juiced2 %>%
#   select(starts_with("pca7")) %>%
#   var() %>%
#   diag()
# amount_var_explained <- foo / sum(foo)
# cumsum(amount_var_explained)


# doing the splines in a different file
# sages_recipe4 <- sages_recipe3 %>%
#   step_ns(all_predictors(), deg_free = 3)
# 
# sages_prepped4 <- recipes::prep(sages_recipe4)
# sages_juiced4 <- recipes::juice(sages_prepped4)

N_pca_to_keep <- 15
saveRDS(N_pca_to_keep,       file=fs::path(r_objects_folder, "082_N_pca_to_keep.rds"))

saveRDS(sages_split,       file=fs::path(r_objects_folder, "082_sages_split.rds"))
saveRDS(sages_train,       file=fs::path(r_objects_folder, "082_sages_train.rds"))
saveRDS(sages_test,        file=fs::path(r_objects_folder, "082_sages_test.rds"))
saveRDS(n_pca,             file=fs::path(r_objects_folder, "082_n_pca.rds"))
saveRDS(sages_juiced2,     file=fs::path(r_objects_folder, "082_sages_juiced2.rds"))
saveRDS(sages_recipe2,     file=fs::path(r_objects_folder, "082_sages_recipe2.rds"))

saveRDS(expert_panel_3plus,     file=fs::path(r_objects_folder, "082_expert_panel_3plus.rds"))
saveRDS(expert_panel_2plus,     file=fs::path(r_objects_folder, "082_expert_panel_2plus.rds"))
saveRDS(expert_panel_1plus,     file=fs::path(r_objects_folder, "082_expert_panel_1plus.rds"))
saveRDS(expert_panel_3plus_nice_names,     file=fs::path(r_objects_folder, "082_expert_panel_3plus_nice_names.rds"))
saveRDS(expert_panel_2plus_nice_names,     file=fs::path(r_objects_folder, "082_expert_panel_2plus_nice_names.rds"))
saveRDS(expert_panel_1plus_nice_names,     file=fs::path(r_objects_folder, "082_expert_panel_1plus_nice_names.rds"))

readr::write_csv(sages_juiced2, here::here("data", "082_sages_juiced2.csv"))
