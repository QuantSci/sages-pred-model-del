
sages_reduced <- readRDS(file=fs::path(r_objects_folder, "060_sages_reduced.rds"))
sages_recipe <- readRDS(file=fs::path(r_objects_folder, "060_sages_recipe.rds"))

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
# Do the PCA

sages_recipe <- recipes::recipe(vdgcp_slope36m ~ ., data = sages_train) %>%
  recipes::step_dummy(all_nominal(), -all_outcomes()) %>%
  recipes::step_normalize(recipes::all_numeric(), -all_outcomes()) 
sages_prepped <- recipes::prep(sages_recipe)
sages_juiced <- recipes::juice(sages_prepped)

n_pca <- (length(sages_juiced)-1)
sages_recipe2 <- sages_recipe %>%
  recipes::step_pca(all_predictors(), num_comp = n_pca)


sages_prepped2 <- recipes::prep(sages_recipe2)
sages_juiced2 <- recipes::juice(sages_prepped2)

# foo <- var(sages_juiced2) %>% diag()
# foo <- foo[-1]
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

n_pc_to_keep <- 25
pc_to_keep <- str_c("PC", str_pad(1:n_pc_to_keep, width = 2, pad = "0")) 
sages_recipe3 <- sages_recipe2 %>%
  step_select(all_outcomes(), all_of(pc_to_keep))

sages_prepped3 <- recipes::prep(sages_recipe3)
sages_juiced3 <- recipes::juice(sages_prepped3)

sages_recipe4 <- sages_recipe3 %>%
  step_ns(all_predictors(), deg_free = 3)

sages_prepped4 <- recipes::prep(sages_recipe4)
sages_juiced4 <- recipes::juice(sages_prepped4)

saveRDS(sages_split,       file=fs::path(r_objects_folder, "062_sages_split.rds"))
saveRDS(sages_train,       file=fs::path(r_objects_folder, "062_sages_train.rds"))
saveRDS(sages_test,        file=fs::path(r_objects_folder, "062_sages_test.rds"))
saveRDS(n_pc_to_keep,      file=fs::path(r_objects_folder, "062_n_pc_to_keep.rds"))
saveRDS(sages_juiced2,     file=fs::path(r_objects_folder, "062_sages_juiced2.rds"))
saveRDS(sages_recipe3,     file=fs::path(r_objects_folder, "062_sages_recipe3.rds"))
saveRDS(sages_juiced3,     file=fs::path(r_objects_folder, "062_sages_juiced3.rds"))
saveRDS(sages_recipe4,     file=fs::path(r_objects_folder, "062_sages_recipe4.rds"))
saveRDS(sages_juiced4,     file=fs::path(r_objects_folder, "062_sages_juiced4.rds"))


