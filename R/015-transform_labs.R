rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))

sages_mr <-              readRDS(file=fs::path(r_objects_folder, "010_sages_mr.rds"))
sages_subject <-              readRDS(file=fs::path(r_objects_folder, "010_sages_subject.rds"))

sages_subject <- sages_subject %>%
  select(studyid, vdage, vdfemale, vdnonwhite)

# Recode the labs missing values

sages_mr <- sages_mr %>%
  mutate(lab01a = car::recode(lab01a, "999.8:1000 = NA"),
         lab02a = car::recode(lab02a, "99.8:100 = NA"),
         lab03a = car::recode(lab03a, "998.9:999.1 = NA"),
         lab04a = car::recode(lab04a, "99.8:100 = NA"),
         lab05a = car::recode(lab05a, "998.9:999.1 = NA"),
         lab06a = car::recode(lab06a, "99.8:100 = NA"),
         lab07a = car::recode(lab07a, "998.9:999.1 = NA"),
         lab08a = car::recode(lab08a, "99.8:100 = NA"),
         lab09a = car::recode(lab09a, "998.9:999.1 = NA"),
         lab10a = car::recode(lab10a, "998.9:999.1 = NA"),
         lab11a = car::recode(lab11a, "998.9:999.1 = NA"),
         lab12a = car::recode(lab12a, "99.8:100 = NA"),
         lab13a = car::recode(lab13a, "9.8:10 = NA"),
         lab14a = car::recode(lab14a, "99.8:100 = NA"),
         lab15a = car::recode(lab15a, "998.9:999.1 = NA"),
         lab01c = car::recode(lab01c, "999.8:1000 = NA"),
         lab02c = car::recode(lab02c, "99.8:100 = NA"),
         lab03c = car::recode(lab03c, "998.9:999.1 = NA"),
         lab04c = car::recode(lab04c, "99.8:100 = NA"),
         lab05c = car::recode(lab05c, "998.9:999.1 = NA"),
         lab06c = car::recode(lab06c, "99.8:100 = NA"),
         lab08c = car::recode(lab08c, "99.8:100 = NA"),
         lab15c = car::recode(lab15c, "998.9:999.1 = NA"),
         lab16c = car::recode(lab16c, "9.9:10.1 = NA"),
         lab17c = car::recode(lab17c, "998.9:999.1 = NA"),
         lab18c = car::recode(lab18c, "998.9:999.1 = NA"),
         lab02e = car::recode(lab02e, "99.8:100 = NA"),
         lab03e = car::recode(lab03e, "998.9:999.1 = NA"),
         lab04e = car::recode(lab04e, "99.8:100 = NA"),
         lab05e = car::recode(lab05e, "998.9:999.1 = NA")
  )

labelled::var_label(sages_mr$lab01a) <- "WBC (x103) (Pre-op)"
labelled::var_label(sages_mr$lab02a) <- "Hematocrit (%) (Pre-op)"
labelled::var_label(sages_mr$lab03a) <- "BUN (mg/dL) (Pre-op)"
labelled::var_label(sages_mr$lab04a) <- "Creatinine (mg/dL) (Pre-op)"
labelled::var_label(sages_mr$lab05a) <- "Sodium (mEq/L) (Pre-op)"
labelled::var_label(sages_mr$lab06a) <- "Potassium (mEq/L) (Pre-op)"
labelled::var_label(sages_mr$lab07a) <- "Chloride (mEq/L) (Pre-op)"
labelled::var_label(sages_mr$lab08a) <- "Bicarbonate mEq/L) (Pre-op)"
labelled::var_label(sages_mr$lab09a) <- "Glucose (mg/dL) (Pre-op)"
labelled::var_label(sages_mr$lab10a) <- "ALT (IU/L) (Pre-op)"
labelled::var_label(sages_mr$lab11a) <- "AST (IU/L) (Pre-op)"
labelled::var_label(sages_mr$lab12a) <- "Bilirubin (mg/dL) (Pre-op)"
labelled::var_label(sages_mr$lab13a) <- "Albumin (g/dL) (Pre-op)"
labelled::var_label(sages_mr$lab14a) <- "Calcium (mg/dL) (Pre-op)"
labelled::var_label(sages_mr$lab15a) <- "O2 saturation (%) (Pre-op)"
labelled::var_label(sages_mr$lab01c) <- "WBC (x103) (POD1)"
labelled::var_label(sages_mr$lab02c) <- "Hematocrit (%) (POD1)"
labelled::var_label(sages_mr$lab03c) <- "BUN (mg/dL) (POD1)"
labelled::var_label(sages_mr$lab04c) <- "Creatinine (mg/dL) (POD1)"
labelled::var_label(sages_mr$lab05c) <- "Sodium (mEq/L) (POD1)"
labelled::var_label(sages_mr$lab06c) <- "Potassium (mEq/L) (POD1)"
labelled::var_label(sages_mr$lab08c) <- "Bicarbonate (mEq/L) (POD1)"
labelled::var_label(sages_mr$lab15c) <- "O2 saturation (%) (POD1)"
labelled::var_label(sages_mr$lab16c) <- "ABG: pH (POD1)"
labelled::var_label(sages_mr$lab17c) <- "p02 (mmHg) (POD1)"
labelled::var_label(sages_mr$lab18c) <- "pCO2 (mmHg) (POD1)"
labelled::var_label(sages_mr$lab02e) <- "Hematocrit (%) (POD2)"
labelled::var_label(sages_mr$lab03e) <- "BUN (mg/dL) (POD2)"
labelled::var_label(sages_mr$lab04e) <- "Creatinine (mg/dL) (POD2)"
labelled::var_label(sages_mr$lab05e) <- "Sodium (mEq/L) (POD2)"

sages_mr_pre_imp <- sages_mr
# Dropping variables that have more than 50% missingness
sages_mr_labs <- sages_mr %>%
  left_join(sages_subject, by = "studyid") %>%
  select(vdage, vdfemale, vdnonwhite, vdcci, starts_with("lab"))

my_missing_fxn <- function(x) {
  sum(is.na(x))
}
covariates_excessive_missing_labs <- sages_mr_labs %>%
  summarize_all(my_missing_fxn) %>%
  pivot_longer(everything(), names_to = "covariate", values_to = "n_missing") %>%
  filter(n_missing >=566 * .5) %>%
  pull(covariate)

sages_mr_labs <- sages_mr_labs %>%
  select(-all_of(covariates_excessive_missing_labs))

# Impute missing values using MICE


# mice::md.pattern(sages_mr_labs)
set.seed(1111)
sages_mr_labs_imp <- mice::mice(sages_mr_labs, m=1, method = "pmm")
foo <- complete(sages_mr_labs_imp, "long", include = FALSE) %>%
  as_tibble() %>%
  select(starts_with("lab"))

sages_mr <- sages_mr %>%
  select(-starts_with("lab")) %>%
  bind_cols(foo)

# Create indicators for abnormal lab values
sages_mr <- sages_mr %>%
  mutate(# Pre-op
         lab.wbc.1.lo     = factor(lab01a <=2,             
                                   levels = c("FALSE", "TRUE"), labels = c("WBC > 2", "WBC <= 2")),
         lab.wbc.1.hi     = factor(lab01a >=15,            
                                   levels = c("FALSE", "TRUE"), labels = c("WBC < 15", "WBC >= 15")),
         lab.hct.1.lo     = factor(lab02a <=21,            
                                   levels = c("FALSE", "TRUE"), labels = c("HCT > 21", "HCT <= 21")),
         lab.hct.1.hi     = factor(lab02a >=62,            
                                   levels = c("FALSE", "TRUE"), labels = c("HCT < 62", "HCT >= 62")),
         lab.bun.1.hi     = factor(lab03a >=50,            
                                   levels = c("FALSE", "TRUE"), labels = c("BUN < 50", "BUN >= 50")),
         lab.cre.1.hi     = factor(lab04a >=5,           
                                   levels = c("FALSE", "TRUE"), labels = c("CRE < 5", "CRE >= 5")),
         lab.sod.1.lo     = factor(lab05a <=120,           
                                   levels = c("FALSE", "TRUE"), labels = c("SOD > 120", "SOD <= 120")),
         lab.sod.1.hi     = factor(lab05a >=160,           
                                   levels = c("FALSE", "TRUE"), labels = c("SOD < 160", "SOD >= 160")),
         lab.pot.1.lo     = factor(lab06a <=2.9,           
                                   levels = c("FALSE", "TRUE"), labels = c("POT > 2.9", "POT <= 2.9")),
         lab.pot.1.hi     = factor(lab06a >=6.0,           
                                   levels = c("FALSE", "TRUE"), labels = c("POT < 6.0", "POT >= 6.0")),
         lab.chl.1.lo     = factor(lab07a <=85,           
                                   levels = c("FALSE", "TRUE"), labels = c("CHL > 85", "CHL <= 85")),
         lab.chl.1.hi     = factor(lab07a >=115,           
                                   levels = c("FALSE", "TRUE"), labels = c("CHL < 115", "CHL >= 115")),
         lab.bic.1.lo     = factor(lab08a <=10,           
                                   levels = c("FALSE", "TRUE"), labels = c("BIC > 10", "BIC <= 10")),
         lab.bic.1.hi     = factor(lab08a >=40,           
                                   levels = c("FALSE", "TRUE"), labels = c("BIC < 40", "BIC >= 40")),
         lab.glu.1.lo     = factor(lab09a <=40,            
                                   levels = c("FALSE", "TRUE"), labels = c("GLU > 40", "GLU <= 40")),
         lab.glu.1.hi     = factor(lab09a >=400,           
                                   levels = c("FALSE", "TRUE"), labels = c("GLU < 400", "GLU >= 400")),
         # lab.alt.1.hi     = factor(lab10a >=400,            
         #                           levels = c("FALSE", "TRUE"), labels = c("ALT < 400", "ALT >= 400")),
         # lab.ast.1.hi     = factor(lab11a >=400,            
         #                           levels = c("FALSE", "TRUE"), labels = c("AST < 400", "AST >= 400")),
         # lab.bil.1.hi     = factor(lab12a >=15,           
         #                           levels = c("FALSE", "TRUE"), labels = c("BIL < 15", "BIL >= 15")),
         # lab.alb.1.lo     = factor(lab13a <=1.4,           
         #                           levels = c("FALSE", "TRUE"), labels = c("ALB > 1.4", "ALB <= 1.4")),
         # lab.alb.1.hi     = factor(lab13a >=6.0,           
         #                           levels = c("FALSE", "TRUE"), labels = c("ALB < 6.0", "ALB >= 6.0")),
         
         # lab.corrected.calcium.1 = lab14a + 0.8*(4-lab13a),
         # lab.cal.1.lo     = factor(lab.corrected.calcium.1 <=6.0,  
         #                           levels = c("FALSE", "TRUE"), labels = c("CAL > 6.0", "CAL <= 6.0")),
         # lab.cal.1.hi     = factor(lab.corrected.calcium.1 >=13.0, 
         #                           levels = c("FALSE", "TRUE"), labels = c("CAL < 13.0", "CAL >= 13.0")),
         lab.o2.1.lo      = factor(lab15a <=87,            
                                   levels = c("FALSE", "TRUE"), labels = c("O2 > 87", "O2 <= 87")),
         lab.bun.cre.ratio.1 = lab03a/lab04a,
         lab.anion.gap.1 = (lab05a + lab06a) - (lab07a + lab08a),
         lab.bun.cre.1.hi = factor(lab.bun.cre.ratio.1>=18,
                                 levels = c("FALSE", "TRUE"), labels = c("BUN/CRE < 18", "BUN/CRE >= 18")),
         lab.anion.1.hi   = factor(lab.anion.gap.1>=16,
                                 levels = c("FALSE", "TRUE"), labels = c("Anion Gap < 16", "Anion Gap >= 16")),

         
         lab.wbc.1.abnormal     = factor(as.numeric(lab.wbc.1.lo) ==2 | as.numeric(lab.wbc.1.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("WBC normal", "WBC abnormal")),
         lab.hct.1.abnormal     = factor(as.numeric(lab.hct.1.lo) ==2 | as.numeric(lab.hct.1.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("HCT normal", "HCT abnormal")),
         lab.bun.1.abnormal     = factor(as.numeric(lab.bun.1.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("BUN normal", "BUN abnormal")),
         lab.cre.1.abnormal     = factor(as.numeric(lab.cre.1.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("CRE normal", "CRE abnormal")),
         lab.sod.1.abnormal     = factor(as.numeric(lab.sod.1.lo) ==2 | as.numeric(lab.sod.1.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("SOD normal", "SOD abnormal")),
         lab.pot.1.abnormal     = factor(as.numeric(lab.pot.1.lo)==2 | as.numeric(lab.pot.1.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("POT normal", "POT abnormal")),
         lab.chl.1.abnormal     = factor(as.numeric(lab.chl.1.lo) ==2 | as.numeric(lab.chl.1.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("CHL normal", "CHL abnormal")),
         lab.bic.1.abnormal     = factor(as.numeric(lab.bic.1.lo) ==2 | as.numeric(lab.bic.1.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("BIC normal", "BIC abnormal")),
         lab.glu.1.abnormal     = factor(as.numeric(lab.glu.1.lo) ==2 | as.numeric(lab.glu.1.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("GLU normal", "GLU abnormal")),
         # lab.alt.1.abnormal     = factor(as.numeric(lab.alt.1.hi)==2,      
         #                                 levels = c("FALSE", "TRUE"), labels = c("ALT normal", "ALT abnormal")),
         # lab.ast.1.abnormal     = factor(as.numeric(lab.ast.1.hi)==2,      
         #                                 levels = c("FALSE", "TRUE"), labels = c("AST normal", "AST abnormal")),
         # lab.bil.1.abnormal     = factor(as.numeric(lab.bil.1.hi)==2,      
         #                                 levels = c("FALSE", "TRUE"), labels = c("BIL normal", "BIL abnormal")),
         # lab.alb.1.abnormal     = factor(as.numeric(lab.alb.1.lo) ==2 | as.numeric(lab.alb.1.hi)==2,      
         #                                 levels = c("FALSE", "TRUE"), labels = c("ALB normal", "ALB abnormal")),
         # lab.cal.1.abnormal     = factor(as.numeric(lab.cal.1.lo)==2 | as.numeric(lab.cal.1.hi)==2,      
         #                                 levels = c("FALSE", "TRUE"), labels = c("CAL normal", "CAL abnormal")),
         lab.o2.1.abnormal     = factor(as.numeric(lab.o2.1.lo) ==2 ,      
                                         levels = c("FALSE", "TRUE"), labels = c("O2 normal", "O2 abnormal")),
         lab.bun.cre.1.abnormal     = factor(as.numeric(lab.bun.cre.1.hi) ==2 ,      
                                        levels = c("FALSE", "TRUE"), labels = c("BUN/CRE normal", "BUN/CRE abnormal")),
         lab.anion.1.abnormal     = factor(as.numeric(lab.anion.1.hi) ==2 ,      
                                        levels = c("FALSE", "TRUE"), labels = c("Anion Gap normal", "Anion Gap abnormal")),
         # Post-op Day 1
         lab.wbc.2.lo     = factor(lab01c <=2,             
                                   levels = c("FALSE", "TRUE"), labels = c("WBC > 2", "WBC <= 2")),
         lab.wbc.2.hi     = factor(lab01c >=15,            
                                   levels = c("FALSE", "TRUE"), labels = c("WBC < 15", "WBC >= 15")),
         lab.hct.2.lo     = factor(lab02c <=21,            
                                   levels = c("FALSE", "TRUE"), labels = c("HCT > 21", "HCT <= 21")),
         lab.hct.2.hi     = factor(lab02c >=62,            
                                   levels = c("FALSE", "TRUE"), labels = c("HCT < 62", "HCT >= 62")),
         lab.bun.2.hi     = factor(lab03c >=50,            
                                   levels = c("FALSE", "TRUE"), labels = c("BUN < 50", "BUN >= 50")),
         lab.cre.2.hi     = factor(lab04c >=5,           
                                   levels = c("FALSE", "TRUE"), labels = c("CRE < 5", "CRE >= 5")),
         lab.sod.2.lo     = factor(lab05c <=120,           
                                   levels = c("FALSE", "TRUE"), labels = c("SOD > 120", "SOD <= 120")),
         lab.sod.2.hi     = factor(lab05c >=160,           
                                   levels = c("FALSE", "TRUE"), labels = c("SOD < 160", "SOD >= 160")),
         lab.pot.2.lo     = factor(lab06c <=2.9,           
                                   levels = c("FALSE", "TRUE"), labels = c("POT > 2.9", "POT <= 2.9")),
         lab.pot.2.hi     = factor(lab06c >=6.0,           
                                   levels = c("FALSE", "TRUE"), labels = c("POT < 6.0", "POT >= 6.0")),
         lab.bic.2.lo     = factor(lab08c <=10,           
                                   levels = c("FALSE", "TRUE"), labels = c("BIC > 10", "BIC <= 10")),
         lab.bic.2.hi     = factor(lab08c >=40,           
                                   levels = c("FALSE", "TRUE"), labels = c("BIC < 40", "BIC >= 40")),
         lab.o2.2.lo      = factor(lab15c <=87,            
                                   levels = c("FALSE", "TRUE"), labels = c("O2 > 87", "O2 <= 87")),
         # lab.agb.2.lo     = factor(lab16c <=7.2,           
         #                           levels = c("FALSE", "TRUE"), labels = c("AGB > 7.2", "AGB <= 7.2")),
         # lab.agb.2.hi     = factor(lab16c >=7.6,           
         #                           levels = c("FALSE", "TRUE"), labels = c("AGB < 7.6", "AGB >= 7.6")),
         # lab.po2.2.lo     = factor(lab17c <=40,           
         #                           levels = c("FALSE", "TRUE"), labels = c("pO2 > 40", "pO2 <= 40")),
         # lab.pco2.2.lo     = factor(lab18c <=20,           
         #                           levels = c("FALSE", "TRUE"), labels = c("pCO2 > 20", "pCO2 <= 20")),
         # lab.pco2.2.hi     = factor(lab18c >=60,           
         #                           levels = c("FALSE", "TRUE"), labels = c("pCO2 < 60", "pCO2 >= 60")),
         lab.wbc.2.abnormal     = factor(as.numeric(lab.wbc.2.lo) ==2 | as.numeric(lab.wbc.2.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("WBC normal", "WBC abnormal")),
         lab.hct.2.abnormal     = factor(as.numeric(lab.hct.2.lo) ==2 | as.numeric(lab.hct.2.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("HCT normal", "HCT abnormal")),
         lab.bun.2.abnormal     = factor(as.numeric(lab.bun.2.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("BUN normal", "BUN abnormal")),
         lab.cre.2.abnormal     = factor(as.numeric(lab.cre.2.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("CRE normal", "CRE abnormal")),
         lab.sod.2.abnormal     = factor(as.numeric(lab.sod.2.lo) ==2 | as.numeric(lab.sod.2.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("SOD normal", "SOD abnormal")),
         lab.pot.2.abnormal     = factor(as.numeric(lab.pot.2.lo)==2 | as.numeric(lab.pot.2.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("POT normal", "POT abnormal")),
         lab.bic.2.abnormal     = factor(as.numeric(lab.bic.2.lo) ==2 | as.numeric(lab.bic.2.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("BIC normal", "BIC abnormal")),
         lab.o2.2.abnormal     = factor(as.numeric(lab.o2.2.lo) ==2 ,      
                                        levels = c("FALSE", "TRUE"), labels = c("O2 normal", "O2 abnormal")),
         # lab.agb.2.abnormal     = factor(as.numeric(lab.agb.2.lo) ==2 | as.numeric(lab.agb.2.hi)==2,      
         #                                levels = c("FALSE", "TRUE"), labels = c("AGB normal", "AGB abnormal")),
         # lab.po2.2.abnormal     = factor(as.numeric(lab.po2.2.lo) ==2 ,      
         #                                levels = c("FALSE", "TRUE"), labels = c("pO2 normal", "pO2 abnormal")),
         # lab.pco2.2.abnormal     = factor(as.numeric(lab.pco2.2.lo) ==2 | as.numeric(lab.pco2.2.hi)==2,      
         #                                levels = c("FALSE", "TRUE"), labels = c("pCO2 normal", "pCO2 abnormal")),
         # Post-op after day 1
         lab.hct.3.lo     = factor(lab02e <=21,            
                                   levels = c("FALSE", "TRUE"), labels = c("HCT > 21", "HCT <= 21")),
         lab.hct.3.hi     = factor(lab02e >=62,            
                                   levels = c("FALSE", "TRUE"), labels = c("HCT < 62", "HCT >= 62")),
         lab.bun.3.hi     = factor(lab03e >=50,            
                                   levels = c("FALSE", "TRUE"), labels = c("BUN < 50", "BUN >= 50")),
         lab.cre.3.hi     = factor(lab04e >=5,           
                                   levels = c("FALSE", "TRUE"), labels = c("CRE < 5", "CRE >= 5")),
         lab.sod.3.lo     = factor(lab05e <=120,           
                                   levels = c("FALSE", "TRUE"), labels = c("SOD > 120", "SOD <= 120")),
         lab.sod.3.hi     = factor(lab05e >=160,           
                                   levels = c("FALSE", "TRUE"), labels = c("SOD < 160", "SOD >= 160")),
         lab.hct.3.abnormal     = factor(as.numeric(lab.hct.3.lo) ==2 | as.numeric(lab.hct.3.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("HCT normal", "HCT abnormal")),
         lab.bun.3.abnormal     = factor(as.numeric(lab.bun.3.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("BUN normal", "BUN abnormal")),
         lab.cre.3.abnormal     = factor(as.numeric(lab.cre.3.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("CRE normal", "CRE abnormal")),
         lab.sod.3.abnormal     = factor(as.numeric(lab.sod.3.lo) ==2 | as.numeric(lab.sod.3.hi)==2,      
                                         levels = c("FALSE", "TRUE"), labels = c("SOD normal", "SOD abnormal"))
  )


# labelled::var_label(sages_mr$lab.corrected.calcium.1) <- "Corrected Calcium (Pre-op)"
labelled::var_label(sages_mr$lab.bun.cre.ratio.1) <- "BUN/creatinine ratio (Pre-op)"
labelled::var_label(sages_mr$lab.anion.gap.1) <- "Anion Gap (Pre-op)"

labelled::var_label(sages_mr$lab.wbc.1.lo) <- "WBC <= 2 (Pre-op)"
labelled::var_label(sages_mr$lab.wbc.1.hi) <- "WBC >= 15 (Pre-op)"
labelled::var_label(sages_mr$lab.hct.1.lo) <- "HCT <= 21 (Pre-op)"
labelled::var_label(sages_mr$lab.hct.1.hi) <- "HCT >= 62 (Pre-op)"
labelled::var_label(sages_mr$lab.bun.1.hi) <- "BUN >= 50 (Pre-op)"
labelled::var_label(sages_mr$lab.cre.1.hi) <- "CRE >= 5 (Pre-op)"
labelled::var_label(sages_mr$lab.sod.1.lo) <- "SOD <= 120 (Pre-op)"
labelled::var_label(sages_mr$lab.sod.1.hi) <- "SOD >= 160 (Pre-op)"
labelled::var_label(sages_mr$lab.pot.1.lo) <- "POT <= 2.9 (Pre-op)"
labelled::var_label(sages_mr$lab.pot.1.hi) <- "POT >= 6.0 (Pre-op)"
labelled::var_label(sages_mr$lab.chl.1.lo) <- "CHL <= 85 (Pre-op)"
labelled::var_label(sages_mr$lab.chl.1.hi) <- "CHL >= 115 (Pre-op)"
labelled::var_label(sages_mr$lab.bic.1.lo) <- "BIC <= 10 (Pre-op)"
labelled::var_label(sages_mr$lab.bic.1.hi) <- "BIC >= 40 (Pre-op)"
labelled::var_label(sages_mr$lab.glu.1.lo) <- "GLU <= 40 (Pre-op)"
labelled::var_label(sages_mr$lab.glu.1.hi) <- "GLU >= 400 (Pre-op)"
# labelled::var_label(sages_mr$lab.alt.1.hi) <- "ALT >= 400 (Pre-op)"
# labelled::var_label(sages_mr$lab.ast.1.hi) <- "AST >= 400 (Pre-op)"
# labelled::var_label(sages_mr$lab.bil.1.hi) <- "BIL >= 15 (Pre-op)"
# labelled::var_label(sages_mr$lab.alb.1.lo) <- "ALB <= 1.4 (Pre-op)"
# labelled::var_label(sages_mr$lab.alb.1.hi) <- "ALB >= 6.0 (Pre-op)"
# labelled::var_label(sages_mr$lab.cal.1.lo) <- "Corrected CAL <= 6.0 (Pre-op)"
# labelled::var_label(sages_mr$lab.cal.1.hi) <- "Corrected CAL >= 13.0 (Pre-op)"
labelled::var_label(sages_mr$lab.o2.1.lo) <- "O2 <= 87 (Pre-op)"
labelled::var_label(sages_mr$lab.bun.cre.1.hi) <- "BUN/CRE >= 18 (Pre-op)"
labelled::var_label(sages_mr$lab.anion.1.hi) <- "Anion Gap >= 16 (Pre-op)"

labelled::var_label(sages_mr$lab.wbc.1.abnormal) <- "Abnormal labs: WBC <= 2 or WBC >= 15 (Pre-op)"
labelled::var_label(sages_mr$lab.hct.1.abnormal) <- "Abnormal labs: HCT <= 21 or HCT >= 62 (Pre-op)"
labelled::var_label(sages_mr$lab.bun.1.abnormal) <- "Abnormal labs: BUN >= 50 (Pre-op)"
labelled::var_label(sages_mr$lab.cre.1.abnormal) <- "Abnormal labs: CRE >= 5 (Pre-op)"
labelled::var_label(sages_mr$lab.sod.1.abnormal) <- "Abnormal labs: SOD <= 120 or SOD >= 160 (Pre-op)"
labelled::var_label(sages_mr$lab.pot.1.abnormal) <- "Abnormal labs: POT <= 2.9 or POT >= 6.0 (Pre-op)"
labelled::var_label(sages_mr$lab.chl.1.abnormal) <- "Abnormal labs: CHL <= 85 or CHL >= 115 (Pre-op)"
labelled::var_label(sages_mr$lab.bic.1.abnormal) <- "Abnormal labs: BIC <= 10 or BIC >= 40 (Pre-op)"
labelled::var_label(sages_mr$lab.glu.1.abnormal) <- "Abnormal labs: GLU <= 40 or GLU >= 400 (Pre-op)"
# labelled::var_label(sages_mr$lab.alt.1.abnormal) <- "Abnormal labs: ALT >= 400 (Pre-op)"
# labelled::var_label(sages_mr$lab.ast.1.abnormal) <- "Abnormal labs: AST >= 400 (Pre-op)"
# labelled::var_label(sages_mr$lab.bil.1.abnormal) <- "Abnormal labs: BIL >= 15 (Pre-op)"
# labelled::var_label(sages_mr$lab.alb.1.abnormal) <- "Abnormal labs: ALB <= 1.4  or ALB >= 6.0 (Pre-op)"
# labelled::var_label(sages_mr$lab.cal.1.abnormal) <- "Abnormal labs: Corrected CAL <= 6.0 or Corrected CAL >= 13.0 (Pre-op)"
labelled::var_label(sages_mr$lab.o2.1.abnormal)  <- "Abnormal labs: O2 <= 87 (Pre-op)"
labelled::var_label(sages_mr$lab.bun.cre.1.abnormal) <- "Abnormal labs: BUN/CRE >= 18 (Pre-op)"
labelled::var_label(sages_mr$lab.anion.1.abnormal) <- "Abnormal labs: Anion Gap >= 16 (Pre-op)"

labelled::var_label(sages_mr$lab.wbc.2.lo) <- "WBC <= 2 (POD1)"
labelled::var_label(sages_mr$lab.wbc.2.hi) <- "WBC >= 15 (POD1)"
labelled::var_label(sages_mr$lab.hct.2.lo) <- "HCT <= 21 (POD1)"
labelled::var_label(sages_mr$lab.hct.2.hi) <- "HCT >= 62 (POD1)"
labelled::var_label(sages_mr$lab.bun.2.hi) <- "BUN >= 50 (POD1)"
labelled::var_label(sages_mr$lab.cre.2.hi) <- "CRE >= 5 (POD1)"
labelled::var_label(sages_mr$lab.sod.2.lo) <- "SOD <= 120 (POD1)"
labelled::var_label(sages_mr$lab.sod.2.hi) <- "SOD >= 160 (POD1)"
labelled::var_label(sages_mr$lab.pot.2.lo) <- "POT <= 2.9 (POD1)"
labelled::var_label(sages_mr$lab.pot.2.hi) <- "POT >= 6.0 (POD1)"
labelled::var_label(sages_mr$lab.bic.2.lo) <- "BIC <= 10 (POD1)"
labelled::var_label(sages_mr$lab.bic.2.hi) <- "BIC >= 40 (POD1)"
labelled::var_label(sages_mr$lab.o2.2.lo) <- "O2 <= 87 (POD1)"
# labelled::var_label(sages_mr$lab.agb.2.lo) <- "AGB <= 7.2 (POD1)"
# labelled::var_label(sages_mr$lab.agb.2.hi) <- "AGB >= 7.6 (POD1)"
# labelled::var_label(sages_mr$lab.po2.2.lo) <- "pO2 <= 40 (POD1)"
# labelled::var_label(sages_mr$lab.pco2.2.lo) <- "pCO2 <= 20 (POD1)"
# labelled::var_label(sages_mr$lab.pco2.2.hi) <- "pCO2 >= 60 (POD1)"

labelled::var_label(sages_mr$lab.wbc.2.abnormal)  <- "Abnormal labs: WBC <= 2 or WBC >= 15 (POD1)"
labelled::var_label(sages_mr$lab.hct.2.abnormal)  <- "Abnormal labs: HCT <= 21 or HCT >= 62 (POD1)"
labelled::var_label(sages_mr$lab.bun.2.abnormal)  <- "Abnormal labs: BUN >= 50 (POD1)"
labelled::var_label(sages_mr$lab.cre.2.abnormal)  <- "Abnormal labs: CRE >= 5 (POD1)"
labelled::var_label(sages_mr$lab.sod.2.abnormal)  <- "Abnormal labs: SOD <= 120 or SOD >= 160 (POD1)"
labelled::var_label(sages_mr$lab.pot.2.abnormal)  <- "Abnormal labs: POT <= 2.9 or POT >= 6.0 (POD1)"
labelled::var_label(sages_mr$lab.bic.2.abnormal)  <- "Abnormal labs: BIC <= 10 or BIC >= 40 (POD1)"
labelled::var_label(sages_mr$lab.o2.2.abnormal)   <- "Abnormal labs: O2 <= 87 (POD1)"
# labelled::var_label(sages_mr$lab.agb.2.abnormal)  <- "Abnormal labs: AGB <= 7.2 or AGB >= 7.6 (POD1)"
# labelled::var_label(sages_mr$lab.po2.2.abnormal)  <- "Abnormal labs: pO2 <= 40 (POD1)"
# labelled::var_label(sages_mr$lab.pco2.2.abnormal) <- "Abnormal labs: pCO2 <= 20 or pCO2 >= 60 (POD1)"

labelled::var_label(sages_mr$lab.hct.3.lo) <- "HCT <= 21 (POD2)"
labelled::var_label(sages_mr$lab.hct.3.hi) <- "HCT >= 62 (POD2)"
labelled::var_label(sages_mr$lab.bun.3.hi) <- "BUN >= 50 (POD2)"
labelled::var_label(sages_mr$lab.cre.3.hi) <- "CRE >= 5 (POD2)"
labelled::var_label(sages_mr$lab.sod.3.lo) <- "SOD <= 120 (POD2)"
labelled::var_label(sages_mr$lab.sod.3.hi) <- "SOD >= 160 (POD2)"

labelled::var_label(sages_mr$lab.hct.3.abnormal) <- "Abnormal labs: HCT <= 21 or HCT >= 62 (POD2)"
labelled::var_label(sages_mr$lab.bun.3.abnormal) <- "Abnormal labs: BUN >= 50 (POD2)"
labelled::var_label(sages_mr$lab.cre.3.abnormal) <- "Abnormal labs: CRE >= 5 (POD2)"
labelled::var_label(sages_mr$lab.sod.3.abnormal) <- "Abnormal labs: SOD <= 120 or SOD >= 160 (POD2)"


saveRDS(sages_mr_pre_imp,      file=fs::path(r_objects_folder, "015_sages_mr_pre_imp.rds"))
saveRDS(covariates_excessive_missing_labs,      file=fs::path(r_objects_folder, "015_covariates_excessive_missing_labs.rds"))
saveRDS(sages_mr,              file=fs::path(r_objects_folder, "015_sages_mr.rds"))
