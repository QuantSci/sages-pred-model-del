rm(list = setdiff(ls(), lsf.str()))
source(here::here("R", "002-folder_paths_and_options.R"))

sages_apoe <-            readRDS(file=fs::path(r_objects_folder, "010_sages_apoe.rds"))
sages_del_assessment <-  readRDS(file=fs::path(r_objects_folder, "010_sages_del_assessment.rds"))
sages_proxy_interview <- readRDS(file=fs::path(r_objects_folder, "010_sages_proxy_iterview.rds"))
sages_slopes_36M <-      readRDS(file=fs::path(r_objects_folder, "010_sages_slopes_36M.rds"))
sages_slopes_48M <-      readRDS(file=fs::path(r_objects_folder, "010_sages_slopes_48M.rds"))
sages_subject <-         readRDS(file=fs::path(r_objects_folder, "010_sages_subject.rds"))
sages_rnj <-             readRDS(file=fs::path(r_objects_folder, "010_sages_rnj.rds"))
sages_mr <-              readRDS(file=fs::path(r_objects_folder, "015_sages_mr.rds"))

# ### Recoding medical record data
# ## Lab values
# # Imputing missing lab values at the mean value.  Missing lab values are considered normal.
# mean_imp <- function(x) {
#   ifelse(is.na(x), mean(x, na.rm=TRUE), x)
# }
# sages_mr <- sages_mr %>%
#   mutate_at(vars(starts_with("vdlab")), .funs = list(imp = ~mean_imp(.)))
# 
# # Create indicators for high and low lab values
# sages_mr <- sages_mr %>%
#   mutate(lab.anion.gap = (vdlab05a_imp + vdlab06a_imp) - (vdlab07a_imp + vdlab08a_imp),
#          lab.corrected.calcium = vdlab14a_imp + 0.8*(4-vdlab13a_imp),
#          lab.bun.cre.ratio = vdlab03a_imp/vdlab04a_imp,
#          lab.wbc.lo     = factor(vdlab01a_imp<=2,             
#                                  levels = c("FALSE", "TRUE"), labels = c("WBC > 2", "WBC <= 2")),
#          lab.wbc.hi     = factor(vdlab01a_imp>=12,            
#                                  levels = c("FALSE", "TRUE"), labels = c("WBC < 12", "WBC >= 12")),
#          lab.hct.lo     = factor(vdlab02a_imp<=30,            
#                                  levels = c("FALSE", "TRUE"), labels = c("HCT > 30", "HCT <= 30")),
#          lab.hct.hi     = factor(vdlab02a_imp>=50,            
#                                  levels = c("FALSE", "TRUE"), labels = c("HCT < 50", "HCT >= 50")),
#          lab.bun.hi     = factor(vdlab03a_imp>=20,            
#                                  levels = c("FALSE", "TRUE"), labels = c("BUN < 20", "BUN >= 20")),
#          lab.cre.hi     = factor(vdlab04a_imp>=1.8,           
#                                  levels = c("FALSE", "TRUE"), labels = c("CRE < 1.8", "CRE >= 1.8")),
#          lab.sod.lo     = factor(vdlab05a_imp<=132,           
#                                  levels = c("FALSE", "TRUE"), labels = c("SOD > 132", "SOD <= 132")),
#          lab.sod.hi     = factor(vdlab05a_imp>=148,           
#                                  levels = c("FALSE", "TRUE"), labels = c("SOD < 148", "SOD >= 148")),
#          lab.pot.lo     = factor(vdlab06a_imp<=3.1,           
#                                  levels = c("FALSE", "TRUE"), labels = c("POT > 3.1", "POT <= 3.1")),
#          lab.pot.hi     = factor(vdlab06a_imp>=5.5,           
#                                  levels = c("FALSE", "TRUE"), labels = c("POT < 5.5", "POT >= 5.5")),
#          lab.anion.hi   = factor(lab.anion.gap>=16,           
#                                  levels = c("FALSE", "TRUE"), labels = c("Anion Gap < 16", "Anion Gap >= 16")),
#          lab.alt.hi     = factor(vdlab10a_imp>=50,            
#                                  levels = c("FALSE", "TRUE"), labels = c("ALT < 50", "ALT >= 50")),
#          lab.ast.hi     = factor(vdlab11a_imp>=50,            
#                                  levels = c("FALSE", "TRUE"), labels = c("AST < 50", "AST >= 50")),
#          lab.bil.hi     = factor(vdlab12a_imp>=1.5,           
#                                  levels = c("FALSE", "TRUE"), labels = c("BIL < 1.5", "BIL >= 1.5")),
#          lab.alb.lo     = factor(vdlab13a_imp<=3.5,           
#                                  levels = c("FALSE", "TRUE"), labels = c("ALB > 3.5", "ALB <= 3.5")),
#          lab.alb.hi     = factor(vdlab13a_imp>=5.2,           
#                                  levels = c("FALSE", "TRUE"), labels = c("ALB < 5.2", "ALB >= 5.2")),
#          lab.cal.lo     = factor(lab.corrected.calcium<=8.5,  
#                                  levels = c("FALSE", "TRUE"), labels = c("CAL > 8.5", "CAL <= 8.5")),
#          lab.cal.hi     = factor(lab.corrected.calcium>=10.5, 
#                                  levels = c("FALSE", "TRUE"), labels = c("CAL < 10.5", "CAL >= 10.5")),
#          lab.glu.lo     = factor(vdlab09a_imp<=50,            
#                                  levels = c("FALSE", "TRUE"), labels = c("GLU > 50", "GLU <= 50")),
#          lab.glu.hi     = factor(vdlab09a_imp>=190,           
#                                  levels = c("FALSE", "TRUE"), labels = c("GLU < 190", "GLU >= 190")),
#          lab.bun.cre.hi = factor(lab.bun.cre.ratio>=18,       
#                                  levels = c("FALSE", "TRUE"), labels = c("BUN/CRE < 18", "BUN/CRE >= 18")),
#          lab.o2.lo      = factor(vdlab15a_imp<=92,            
#                                  levels = c("FALSE", "TRUE"), labels = c("O2 > 92", "O2 <= 92")),
#          lab.wbc.lo.10     = factor(percent_rank(vdlab01a_imp)<0.10,      
#                                     levels = c("FALSE", "TRUE"), labels = c("WBC normal", "WBC lowest 10%")),
#          lab.wbc.hi.10     = factor(percent_rank(vdlab01a_imp)>0.90,      
#                                     levels = c("FALSE", "TRUE"), labels = c("WBC normal", "WBC highest 10%")),
#          lab.hct.lo.10     = factor(percent_rank(vdlab02a_imp)<0.10,      
#                                     levels = c("FALSE", "TRUE"), labels = c("HCT normal", "HCT lowest 10%")),
#          lab.hct.hi.10     = factor(percent_rank(vdlab02a_imp)>0.90,      
#                                     levels = c("FALSE", "TRUE"), labels = c("HCT normal", "HCT highest 10%")),
#          lab.cre.hi.10     = factor(percent_rank(vdlab04a_imp)>0.90,      
#                                     levels = c("FALSE", "TRUE"), labels = c("CRE normal", "CRE highest 10%")),
#          lab.sod.lo.10     = factor(percent_rank(vdlab05a_imp)<0.10,      
#                                     levels = c("FALSE", "TRUE"), labels = c("SOD normal", "SOD lowest 10%")),
#          lab.sod.hi.10     = factor(percent_rank(vdlab05a_imp)>0.90,      
#                                     levels = c("FALSE", "TRUE"), labels = c("SOD normal", "SOD highest 10%")),
#          lab.pot.lo.10     = factor(percent_rank(vdlab06a_imp)<0.10,      
#                                     levels = c("FALSE", "TRUE"), labels = c("POT normal", "POT lowest 10%")),
#          lab.pot.hi.10     = factor(percent_rank(vdlab06a_imp)>0.90,      
#                                     levels = c("FALSE", "TRUE"), labels = c("POT normal", "POT highest 10%")),
#          lab.alt.hi.10     = factor(percent_rank(vdlab10a_imp)>0.90,      
#                                     levels = c("FALSE", "TRUE"), labels = c("ALT normal", "ALT highest 10%")),
#          lab.ast.hi.10     = factor(percent_rank(vdlab11a_imp)>0.90,      
#                                     levels = c("FALSE", "TRUE"), labels = c("AST normal", "AST highest 10%")),
#          lab.bil.hi.10     = factor(percent_rank(vdlab12a_imp)>0.90,      
#                                     levels = c("FALSE", "TRUE"), labels = c("BIL normal", "BIL highest 10%")),
#          lab.bun.cre.hi.10 = factor(percent_rank(lab.bun.cre.ratio)>0.90, 
#                                     levels = c("FALSE", "TRUE"), labels = c("BUN/CRE normal", "BUN/CRE highest 10%")),
#          lab.o2.lo.10      = factor(percent_rank(vdlab15a_imp)<0.10,      
#                                     levels = c("FALSE", "TRUE"), labels = c("O2 normal", "O2 lowest 10%"))) %>%
#   select(-lab01a, -lab02a, -lab03a, -lab04a, -lab05a, -lab06a, -lab07a, -lab08a, -lab09a, -lab10a, 
#          -lab11a, -lab12a, -lab13a, -lab14a, -lab15a, 
#          -vdlab01a, -vdlab02a, -vdlab03a, -vdlab04a, -vdlab05a, -vdlab06a, -vdlab07a, -vdlab08a, -vdlab09a, -vdlab10a,
#          -vdlab11a, -vdlab12a, -vdlab13a, -vdlab14a, -vdlab15a,
#          -vdlab07a_imp, -vdlab08a_imp)
# 
# sages_mr.lab.cutoff.values <- sages_mr %>% 
#   dplyr::summarize(
#       wbc.lo.10     = quantile(vdlab01a_imp, 0.10),
#       wbc.hi.10     = quantile(vdlab01a_imp, 0.90),
#       hct.lo.10     = quantile(vdlab02a_imp, 0.10),      
#       hct.hi.10     = quantile(vdlab02a_imp, 0.90),      
#       cre.hi.10     = quantile(vdlab04a_imp, 0.90),      
#       sod.lo.10     = quantile(vdlab05a_imp, 0.10),      
#       sod.hi.10     = quantile(vdlab05a_imp, 0.90),      
#       pot.lo.10     = quantile(vdlab06a_imp, 0.10),      
#       pot.hi.10     = quantile(vdlab06a_imp, 0.90),      
#       alt.hi.10     = quantile(vdlab10a_imp, 0.90),      
#       ast.hi.10     = quantile(vdlab11a_imp, 0.90),      
#       bil.hi.10     = quantile(vdlab12a_imp, 0.90),      
#       bun.cre.hi.10 = quantile(lab.bun.cre.ratio, 0.90), 
#       o2.lo.10      = quantile(vdlab15a_imp, 0.10)) %>%
#   gather(key = lab, value = cutoff)


## Creating indicators for the 10 most common comorbidities in the Charlson
# Using ICD codes to create indicators of Myocardial infarction and Connective tissue disease
icd_pad <- function(x) {
  as.character(round(x, 2))
}
sages_mr_icd <- sages_mr %>%
  select(studyid, starts_with("icd")) %>%
  mutate_if(is.numeric, .funs = list(~icd_pad(.))) %>%
  pivot_longer(cols = starts_with("icd")) %>%
  mutate(icd.mi = value %in% c("410", "412"),
         icd.ctd = value %in% c("710.0", "710.1", "710.4", "714", "714.0", "714.1", "714.2", "714.81", "725")) %>%
  group_by(studyid) %>%
  summarise(icd.mi = max(icd.mi),
            icd.ctd = max(icd.ctd)) %>%
  ungroup()
# Merge the ICD indicators back into the MR data
sages_mr <- sages_mr %>%
  left_join(sages_mr_icd, by = "studyid")

# Create the factors for the 10 comorbidities
sages_mr <- sages_mr %>%
  mutate(#1. Diabetes--mild to moderate
    comorbid.diab_mod = case_when(dxv2==1 ~ 1, 
                                  TRUE ~ 0),
    #2. Tumor, exclude luekemia, lymphoma, and metastatic cancer
    comorbid.tumor = case_when(dxm1==1 ~ 1, 
                               TRUE ~ 0),
    #3. Peripheral vascular disease
    comorbid.pvd = case_when(dxv5==1 ~ 1,
                             TRUE ~ 0),
    #4. Myocardial infarction
    comorbid.mi = case_when(dxc1a==1 ~ 1,
                            icd.mi==1 ~ 1,
                            TRUE ~ 0),
    #5. Connective tissue disease
    comorbid.ctd = case_when(dxi3==1 ~ 1,
                             icd.ctd==1 ~ 1,
                             TRUE ~ 0),
    #6. Chronic respiratory disease
    comorbid.crd = case_when(dxr1==1 ~ 1,
                             TRUE ~ 0),
    #7. Carotid stenosis
    comorbid.cs = case_when(dxn4==1 ~ 1,
                            TRUE ~ 0),
    #8. Diabetes with end organ damage
    comorbid.diab_sev = case_when(dxv3==1 ~ 1,
                                  TRUE ~ 0),
    #9. Congestive heart failure
    comorbid.chf = case_when(dxc2==1 ~ 1,
                             TRUE ~ 0),
    #10. Stroke
    comorbid.stroke = case_when(dxn1==1 ~ 1,
                                TRUE ~ 0)
  ) %>%
  mutate(comorbid.diab_mod = factor(comorbid.diab_mod, 
                                    levels = c(0, 1), labels = c("No diabetes", "Diabetes - Mild to moderate")),
         comorbid.tumor    = factor(comorbid.tumor, 
                                    levels = c(0, 1), labels = c("No tumor", "Tumor")),
         comorbid.pvd      = factor(comorbid.pvd, 
                                    levels = c(0, 1), labels = c("No PVD", "Peripheral vascular disease")),
         comorbid.mi       = factor(comorbid.mi, 
                                    levels = c(0, 1), labels = c("No MI", "Myocardial infarction")),
         comorbid.ctd      = factor(comorbid.ctd, 
                                    levels = c(0, 1), labels = c("No CTD", "Connective tissue disease")),
         comorbid.crd      = factor(comorbid.crd, 
                                    levels = c(0, 1), labels = c("No CRD", "Chronic respiratory disease")),
         comorbid.cs       = factor(comorbid.cs, 
                                    levels = c(0, 1), labels = c("No CS", "Carotid stenosis")),
         comorbid.diab_sev = factor(comorbid.diab_sev, 
                                    levels = c(0, 1), labels = c("No diabetes", "Diabetes - Severe with end organ damage")),
         comorbid.chf      = factor(comorbid.chf, 
                                    levels = c(0, 1), labels = c("No CHF", "Congestive heart failure")),
         comorbid.stroke   = factor(comorbid.stroke, 
                                    levels = c(0, 1), labels = c("No stroke", "Stroke")))

labelled::var_label(sages_mr$comorbid.diab_mod) <- "Diabetes - mild to moderate"
labelled::var_label(sages_mr$comorbid.tumor) <- "Tumor"
labelled::var_label(sages_mr$comorbid.pvd) <- "Peripheral vascular disease"
labelled::var_label(sages_mr$comorbid.mi) <- "Myocardial infarction"
labelled::var_label(sages_mr$comorbid.ctd) <- "Connective tissue disease"
labelled::var_label(sages_mr$comorbid.crd) <- "Chronic respiratory disease"
labelled::var_label(sages_mr$comorbid.cs) <- "Carotid stenosis"
labelled::var_label(sages_mr$comorbid.diab_sev) <- "Diabetes - severe with end organ damage"
labelled::var_label(sages_mr$comorbid.chf) <- "Congestive heart failure"
labelled::var_label(sages_mr$comorbid.stroke) <- "Stroke"

# Comorbities, Insurance status, Anesthesia
sages_mr <- sages_mr %>%
  mutate(vdcci3     = fct_collapse(as.character(vdcci), "cci_0" = "0", "cci_1" = "1", "cci_2_7" = c("2", "3", "4", "5", "6", "7")),
         vdcci5     = fct_collapse(as.character(vdcci), "cci_0" = "0", "cci_1" = "1", "cci_2" = "2", "cci_3" = "3", "cci4_7" = c("4", "5", "6", "7")),
         vdvascom   = fct_recode(as.character(vdvascom), "No comorbidity" = "0", "Vascular comorbidity" = "1"),
         ins01      = fct_recode(as.character(ins01), "Insurance" = "2") %>% fct_expand("No Insurance"),
         ins02      = fct_recode(as.character(ins02), "Medicare" = "1", "No Medicare" = "2") %>% fct_relevel("Medicare", "No Medicare") ,
         ins03      = fct_recode(as.character(ins03), "Private Insurance" = "1", "No Private Insurance" = "2") %>% fct_relevel("Private Insurance", "No Private Insurance"),
         ins04      = fct_recode(as.character(ins04), "Medicaid" = "1", "No Medicaid" = "2") %>% fct_relevel("No Medicaid", "Medicaid"),
         ins05      = fct_recode(as.character(ins05), "No Other Insurance" = "2", "Other Insurance" = "1") %>% fct_relevel("No Other Insurance", "Other Insurance"),
         ci01       = fct_recode(as.character(ci01), "No Cognitive Impairment" = "2",  "Cognitive Impairment (Chart)" = "1") %>%
           fct_relevel(c("No Cognitive Impairment", "Cognitive Impairment (Chart)")),
         dep01      = fct_collapse(as.character(dep01), "No Depression" = c("2", "8"), "Depression (Chart)" = "1") %>%
           fct_relevel(c("No Depression", "Depression (Chart)")),
         op01_3     = fct_collapse(as.character(op01), "ASA class:_1_2" = c("1", "2"), "ASA class:_3_4" = c("3", "4")),
         vdanesth   = case_when((op04a==1 & op04b==2) ~ "1",
                                (op04a==2 & op04b==1) ~ "2",
                                (op04a==1 & op04b==1) ~ "3",
                                (op04a==2 & op04b==2 & op04c==1) ~ "2"),
         vdanesth   = fct_recode(vdanesth, "General Anesthesia" = "1", "Spinal Anesthesia" = "2", "General and Spinal Anesthesia" = "3"),
         vdanesth_spi = fct_collapse(vdanesth, "General Anesthesia only" = "General Anesthesia", 
                                     "Any Spinal Anesthesia" = c("Spinal Anesthesia", "General and Spinal Anesthesia"))) %>%
  select(-op04a, -op04b, -op04c, -icd.mi, -icd.ctd)

labelled::var_label(sages_mr$vdcci3) <- "Charlson Comorbidity Index (3 categories)"
labelled::var_label(sages_mr$vdcci5) <- "Charlson Comorbidity Index (5 categories)"
labelled::var_label(sages_mr$vdcci) <- "Charlson Comorbidity Index"
labelled::var_label(sages_mr$vdvascom) <- "Vascular Comorbidity"
labelled::var_label(sages_mr$ins01) <- "No Insurance"
labelled::var_label(sages_mr$ins02) <- "Has Medicare"
labelled::var_label(sages_mr$ins03) <- "Has Private Insurance"
labelled::var_label(sages_mr$ins04) <- "Has Medicaid"
labelled::var_label(sages_mr$ins05) <- "Has Other Insurance"
labelled::var_label(sages_mr$ci01) <- "Evidence of Cognitive Impairment"
labelled::var_label(sages_mr$dep01) <- "Evidence of Depression"
labelled::var_label(sages_mr$op01_3) <- "ASA class"
labelled::var_label(sages_mr$vdanesth_spi) <- "Anesthesia Type"
                   
sages_subject <- sages_subject %>%
  select(studyid, dispo_ccbl, timefr, vdage, vdfemale, vdnonwhite, vdeduc_r, vdlivesalone, 
         vdsmokingstatus, vdalcohol, vdmlta_metmins,
         vdgcp_rta,  wtar01, 
         vdadlany, vdiadlany, vdiadlanyc,  
         vdgds15, vdsf12pcs, vdsf12mcs, vdsf12pf, vdsf12rp, vdsf12bp, vdsf12gh, vdsf12vt, vdsf12sf, vdsf12re, vdsf12mh,
         vdhearingimp, vddrisk93_1, 
         vdfriedfrail1, vdfriedfrail2, vdfriedfrail3, vdfriedfrail4, vdfriedfrail5,
         vdsurg, 
         vdcrp_preop, vdcrp_pod2,
         vd3ms, vdbmi3, vdesl, pai03) %>%
  mutate_at(vars(vdfemale, vdnonwhite, vdlivesalone, vdsmokingstatus, vdalcohol,
                 vdadlany, vdiadlany, vdiadlanyc, vdhearingimp, vddrisk93_1,
                 vdfriedfrail1, vdfriedfrail2, vdfriedfrail3, vdfriedfrail4, vdfriedfrail5, vdsurg, vdesl,
                 vdsf12pf, vdsf12rp, vdsf12bp, vdsf12gh, vdsf12vt, vdsf12sf, vdsf12re, vdsf12mh), factor)

labelled::var_label(sages_subject$studyid) <- "Studyid"
labelled::var_label(sages_subject$vdage) <- "Age at This Visit"
labelled::var_label(sages_subject$vdfemale) <- "Female"
labelled::var_label(sages_subject$vdnonwhite) <- "Nonwhite"
labelled::var_label(sages_subject$vdeduc_r) <- "Respondent's Education, Years"
labelled::var_label(sages_subject$vdlivesalone) <- "Lives alone"
labelled::var_label(sages_subject$vdsmokingstatus) <- "Smoking status"
labelled::var_label(sages_subject$vdalcohol) <- "Alcohol"
labelled::var_label(sages_subject$vdmlta_metmins) <- "MLTA"
labelled::var_label(sages_subject$vdgcp_rta) <- "Baseline GCP"
labelled::var_label(sages_subject$wtar01) <- "WTAR"
labelled::var_label(sages_subject$vdadlany) <- "ADL (any)"
labelled::var_label(sages_subject$vdiadlany) <- "IADL (any)"
labelled::var_label(sages_subject$vdiadlanyc) <- "IADL cognitive (any)"
labelled::var_label(sages_subject$vdgds15) <- "Geriatric Depression Scale Score  (/15 Points)"
labelled::var_label(sages_subject$vdhearingimp) <- "Hearing impairment"
labelled::var_label(sages_subject$vddrisk93_1) <- "Vision Impairment"
labelled::var_label(sages_subject$vdfriedfrail1) <- "Frailty - Weight Loss"
labelled::var_label(sages_subject$vdfriedfrail2) <- "Frailty - Exhaustion"
labelled::var_label(sages_subject$vdfriedfrail3) <- "Frailty - Low Physical Activity"
labelled::var_label(sages_subject$vdfriedfrail4) <- "Frailty - Low Grip Strength"
labelled::var_label(sages_subject$vdfriedfrail5) <- "Frailty - Low Timed Walk"
labelled::var_label(sages_subject$vdsurg) <- "Surgery"
labelled::var_label(sages_subject$vdcrp_preop) <- "CRP - preop"
labelled::var_label(sages_subject$vdcrp_pod2) <- "CRP - POD2"
labelled::var_label(sages_subject$vd3ms) <- "3MS Score"
labelled::var_label(sages_subject$vdbmi3) <- "BMI"
labelled::var_label(sages_subject$vdesl) <- "English is second language"
labelled::var_label(sages_subject$vdsf12pf) <- "SF12 - Physical Functioning"
labelled::var_label(sages_subject$vdsf12rp) <- "SF12 - Role Physical"
labelled::var_label(sages_subject$vdsf12bp) <- "SF12 - Bodily Pain"
labelled::var_label(sages_subject$vdsf12gh) <- "SF12 - General Health"
labelled::var_label(sages_subject$vdsf12vt) <- "SF12 - Vitality"
labelled::var_label(sages_subject$vdsf12sf) <- "SF12 - Social Functioning"
labelled::var_label(sages_subject$vdsf12re) <- "SF12 - Role Emotional"
labelled::var_label(sages_subject$vdsf12mh) <- "SF12 - Mental Health"

# labeling apoe
sages_apoe <- sages_apoe %>%
  mutate_at(vars(apoe4), factor)
labelled::var_label(sages_apoe$apoe4) <- "APOE 4"
# labeling delirium
sages_del_assessment <- sages_del_assessment %>%
  mutate_at(vars(vdsagesdeliriumever), factor)
labelled::var_label(sages_del_assessment$vdsagesdeliriumever) <- "SAGES Delirium"
# labeling slopes
labelled::var_label(sages_slopes_36M$vdgcp_slope36m) <- "Estimated instantaneous slope, 36 months"
labelled::var_label(sages_slopes_48M$vdgcp_slope48m) <- "Estimated slope, 2-48 months"
# labeling proxy interview
labelled::var_label(sages_proxy_interview$vdiqc_proxy) <- "IQCODE, Proxy Report"

sages_rnj <- sages_rnj %>%
  mutate(vdp41301 = factor(vdp41301, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41302 = factor(vdp41302, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41303 = factor(vdp41303, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41304 = factor(vdp41304, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41311 = factor(vdp41311, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41312 = factor(vdp41312, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41313 = factor(vdp41313, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41314 = factor(vdp41314, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41315 = factor(vdp41315, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41316 = factor(vdp41316, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41317 = factor(vdp41317, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41318 = factor(vdp41318, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41319 = factor(vdp41319, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41320 = factor(vdp41320, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41321 = factor(vdp41321, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41322 = factor(vdp41322, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41323 = factor(vdp41323, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41324 = factor(vdp41324, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41325 = factor(vdp41325, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41326 = factor(vdp41326, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41327 = factor(vdp41327, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41328 = factor(vdp41328, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41329 = factor(vdp41329, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41330 = factor(vdp41330, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41331 = factor(vdp41331, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41501 = factor(vdp41501, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41502 = factor(vdp41502, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41503 = factor(vdp41503, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41504 = factor(vdp41504, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41505 = factor(vdp41505, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41510 = factor(vdp41510, levels = c(0, 1, 2), labels = c("0", "1", "2")),
         vdp41510 = fct_collapse((vdp41510), "0" = "0", "1_2" = c("1", "2")),
         vdp41515 = factor(vdp41515, levels = c(0, 1, 2, 3), labels = c("0", "1", "2", "3")),
         vdp41515 = fct_collapse((vdp41515), "0" = "0", "1" = "1", "2_3" = c("2", "3")),
         vdp41516 = factor(vdp41516, levels = c(0, 1, 2, 3, 4, 5, 6, 9), labels = c("0", "1", "2", "3", "4", "5", "6", "9")),
         vdp41516 = fct_collapse((vdp41516), "0" = "0", "1" = "1", "2" = "2", "3" = "3", "4_9" = c("4", "5", "6", "9")),
         vdp41721 = factor(vdp41721, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41722 = factor(vdp41722, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41723 = factor(vdp41723, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41724 = factor(vdp41724, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41725 = factor(vdp41725, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41726 = factor(vdp41726, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41727 = factor(vdp41727, levels = c(0, 1), labels = c("No", "Yes")),
         vdp41901 = factor(vdp41901, levels = c(0, 1), labels = c("No", "Yes")),
         vdp42303 = factor(vdp42303, levels = c(0, 1), labels = c("No", "Yes")),
         vdp42304 = factor(vdp42304, levels = c(0, 1), labels = c("No", "Yes")),
         vdp42305 = factor(vdp42305, levels = c(0, 1), labels = c("No", "Yes")),
         vdp42309 = factor(vdp42309, levels = c(0, 1), labels = c("No", "Yes")),
         vdp42701 = factor(vdp42701, levels = c(0, 1), labels = c("No", "Yes")),
         vdp42702 = factor(vdp42702, levels = c(0, 1), labels = c("No", "Yes")),
         vdp43301 = factor(vdp43301, levels = c(0, 1), labels = c("No", "Yes")),
         vdp44701 = factor(vdp44701, levels = c(0, 1, 2, 3), labels = c("No clincial imaging", "Low prob of impactful abnormality", "Mid prob of impactful abnormality", "High prob of impactful abnormality")),
         )

labelled::var_label(sages_rnj$vdp41301) <- "Anesthesia: general"
labelled::var_label(sages_rnj$vdp41302) <- "Anesthesia: spinal"
labelled::var_label(sages_rnj$vdp41303) <- "Anesthesia: regional"
labelled::var_label(sages_rnj$vdp41304) <- "Anesthesia: local"
labelled::var_label(sages_rnj$vdp41311) <- "Anesthesia: propofol"
labelled::var_label(sages_rnj$vdp41312) <- "Anesthesia: midazolam"
labelled::var_label(sages_rnj$vdp41313) <- "Anesthesia: fentanyl"
labelled::var_label(sages_rnj$vdp41314) <- "Anesthesia: remifentanil"
labelled::var_label(sages_rnj$vdp41315) <- "Anesthesia: hydromorphone"
labelled::var_label(sages_rnj$vdp41316) <- "Anesthesia: morphine"
labelled::var_label(sages_rnj$vdp41317) <- "Anesthesia: nitrous"
labelled::var_label(sages_rnj$vdp41318) <- "Anesthesia: desflurane"
labelled::var_label(sages_rnj$vdp41319) <- "Anesthesia: succinycholine"
labelled::var_label(sages_rnj$vdp41320) <- "Anesthesia: vecuronium"
labelled::var_label(sages_rnj$vdp41321) <- "Anesthesia: bupivacaine"
labelled::var_label(sages_rnj$vdp41322) <- "Anesthesia: cefazolin"
labelled::var_label(sages_rnj$vdp41323) <- "Anesthesia: ephedrine"
labelled::var_label(sages_rnj$vdp41324) <- "Anesthesia: glycopyrrolate"
labelled::var_label(sages_rnj$vdp41325) <- "Anesthesia: lidocaine"
labelled::var_label(sages_rnj$vdp41326) <- "Anesthesia: mepivacaine"
labelled::var_label(sages_rnj$vdp41327) <- "Anesthesia: neostigmine"
labelled::var_label(sages_rnj$vdp41328) <- "Anesthesia: ondansetron"
labelled::var_label(sages_rnj$vdp41329) <- "Anesthesia: phenylephrine"
labelled::var_label(sages_rnj$vdp41330) <- "Anesthesia: rocuronium"
labelled::var_label(sages_rnj$vdp41331) <- "Anesthesia: vancomycin"
labelled::var_label(sages_rnj$vdp41501) <- "Presence of beta blocker in pre-hospital medication list"
labelled::var_label(sages_rnj$vdp41502) <- "Presence of NSAID in pre-hospital medication list"
labelled::var_label(sages_rnj$vdp41503) <- "Presence of statin in pre-hospital medication list"
labelled::var_label(sages_rnj$vdp41504) <- "Presence of benzodiazepine in pre-hospital medication list"
labelled::var_label(sages_rnj$vdp41505) <- "Presence of opioid in pre-hospital medication list"
labelled::var_label(sages_rnj$vdp41510) <- "Number of medications with ADS activity >1"
labelled::var_label(sages_rnj$vdp41515) <- "Number of medications with ACB activity >1"
labelled::var_label(sages_rnj$vdp41516) <- "ADS score if excluding medications scoring 1 on the ACB scale"
labelled::var_label(sages_rnj$vdp41721) <- "antipsychotics use in days 1-7"
labelled::var_label(sages_rnj$vdp41722) <- "benzodiazepines use in days 1-7"
labelled::var_label(sages_rnj$vdp41723) <- "hydromorphone use in days 1-7"
labelled::var_label(sages_rnj$vdp41724) <- "morphine use in days 1-7"
labelled::var_label(sages_rnj$vdp41725) <- "oxycodone use in days 1-7"
labelled::var_label(sages_rnj$vdp41726) <- "tramadol use in days 1-7"
labelled::var_label(sages_rnj$vdp41727) <- "other opioid use in days 1-7"
labelled::var_label(sages_rnj$vdp41901) <- "ASA Class >=3 (vs <=2)"
labelled::var_label(sages_rnj$vdp42303) <- "Intraop complication - bradycardia requiring new permanent pacemaker"
labelled::var_label(sages_rnj$vdp42304) <- "Intraop complication - uncontrolled bleeding"
labelled::var_label(sages_rnj$vdp42305) <- "Intraop complication - prolonged severe hypotension"
labelled::var_label(sages_rnj$vdp42309) <- "Intraop complication - other"
labelled::var_label(sages_rnj$vdp42701) <- "Post-operative hypotension (SBP<90 or DBP<60)"
labelled::var_label(sages_rnj$vdp42702) <- "Post-operative hypertension (SBP>140 or DBP>90)"
labelled::var_label(sages_rnj$vdp43301) <- "(icu01 recode) Was the patient ever in the ICU or CCU?"
labelled::var_label(sages_rnj$vdp44701) <- "Adjudicated risk rating (maximum) from clinical neuroimaging"

sages_combined <- sages_subject %>%
  left_join(sages_apoe, by = "studyid") %>%
  left_join(sages_del_assessment, by = "studyid") %>%
  left_join(sages_proxy_interview, by = "studyid") %>%
  left_join(sages_slopes_36M, by = "studyid") %>%
  left_join(sages_slopes_48M, by = "studyid") %>%
  left_join(sages_mr, by = "studyid") %>%
  left_join(sages_rnj, by = "studyid") %>%
  filter(dispo_ccbl!=2 | is.na(dispo_ccbl)) %>%
  select(-dispo_ccbl, -timefr, -op01, -vdanesth, -pai03) %>%
  select(-vdgcp_change36m) 


# # Dropping variables that aren't easily accessible to clinicians
# sages_combined <- sages_combined %>%
#   select(-vdsf12pcs, -vdsf12mcs, -vdsf12pf, -vdsf12rp, -vdsf12bp, -vdsf12gh, -vdsf12vt, -vdsf12sf, -vdsf12re, -vdsf12mh,
#          -vdgcp_rta, -wtar01, -vdmlta_metmins, -vdcrp_preop, -vdcrp_pod2, -apoe4, -vdfriedfrail2, -vdfriedfrail3)

# Dropping the variables used to create the comorbidity indicators
sages_combined <- sages_combined %>%
  select(-icd01a, -icd02a, -icd03a, -icd04a, -icd05a, -icd06a, -icd07a, -icd08a, -icd09a, -icd10a,
         -icd11a, -icd12a, -icd13a, -icd14a, -icd15a, -icd16a, -icd17a, -icd18a, -icd19a, -icd20a,
         -dxv2,   -dxm1,   -dxv5,   -dxc1a,   -dxi3,  -dxr1,   -dxn4,   -dxv3,   -dxc2,   -dxn1)

sages_combined <- sages_combined %>%
  mutate(vdfemale        = fct_recode(vdfemale, "Male" = "0", "Female"="1"),
         vdnonwhite      = fct_recode(vdnonwhite, "White" = "0", "Nonwhite" = "1"),
         vdlivesalone    = fct_recode(vdlivesalone, "Not_alone" = "0", "Alone" = "1"),
         vdsmokingstatus = fct_recode(vdsmokingstatus, "Never_smoker" = "0", "Past_smoker" = "1", 
                                      "Current_smoker" = "2"),
         vdalcohol       = fct_collapse(vdalcohol, "Less_than_5_a_week" = c("3", "4", "5", "6", "7", "8"),
                                        "Five_times_a_week_or_more" = c("1", "2")),
         vdalcohol       = fct_relevel(vdalcohol, "Less_than_5_a_week", "Five_times_a_week_or_more"),
         vdadlany        = fct_recode(vdadlany, "No_impairment" = "0", "Impairment" = "1"),
         vdiadlany       = fct_recode(vdiadlany, "No_impairment" = "0", "Impairment" = "1"),
         vdiadlanyc      = fct_recode(vdiadlanyc, "No_impairment" = "0", "Impairment" = "1"),
         vdhearingimp    = fct_recode(vdhearingimp, "No_impairment" = "0", "Impairment" = "1"),
         vddrisk93_1     = fct_recode(vddrisk93_1, "No_impairment" = "0", "Impairment" = "1"),
         vdfriedfrail1   = fct_recode(vdfriedfrail1, "No_impairment" = "0", "Weight_loss" = "1"),
         vdfriedfrail4   = fct_recode(vdfriedfrail4, "No_impairment" = "0", "Low_grip_strength" = "1"),
         vdfriedfrail5   = fct_recode(vdfriedfrail5, "No_impairment" = "0", "Slow_timed_walk" = "1"),
         vdsurg          = fct_recode(vdsurg, "Orthopedic" = "1", "Vascular" = "2", "Gastrointestinal" = "3"),
         vdesl           = fct_recode(vdesl, "Non_ESL" = "0", "ESL" = "1"))

my_missing_fxn <- function(x) {
  sum(is.na(x))
}
covariates_excessive_missing <- sages_combined %>%
  summarize_all(my_missing_fxn) %>%
  pivot_longer(everything(), names_to = "covariate", values_to = "n_missing") %>%
  filter(n_missing >=566 * .5) %>%
  pull(covariate)


sages_combined <- sages_combined %>%
  select(-all_of(covariates_excessive_missing))

if (identical(covariates_excessive_missing, character(0)) ) {
  covariates_excessive_missing <- "none"
}

# Imputing missing data with MICE
sages_combined_pre_imp <- sages_combined
sages_combined_temp <- sages_combined %>%
  select(-studyid, -vdsagesdeliriumever, -vdgcp_slope36m, -vdgcp_slope48m)
# mice::md.pattern(sages_combined_temp)
set.seed(1111)
sages_combined_imp <- mice::mice(sages_combined_temp, m=1, method = "pmm")
foo <- complete(sages_combined_imp, "long", include = FALSE) %>%
  as_tibble() 

sages_combined <- sages_combined %>%
  select(studyid, vdsagesdeliriumever, vdgcp_slope36m, vdgcp_slope48m) %>%
  bind_cols(foo) %>%
  select(-.imp, -.id)




sages_combined_labels <- labelled::var_label(sages_combined)
#### How to add labels back to a subset of data if the labels were dropped
# foo <- sages_combined
# foo <- haven::zap_label(foo)
# foo <- foo %>% select(studyid, vdage, vdfemale)
# 
# var_names_all <- names(sages_combined)
# var_names_keep <- names(foo)
# var_names_drop <- var_names_all[!(var_names_all %in% var_names_keep)]
# sages_combined_labels_filtered <- sages_combined_labels
# for (x in var_names_drop) {
#   if(x %in% names(sages_combined_labels)) {
#     sages_combined_labels_filtered <- sages_combined_labels_filtered[ -which(names(sages_combined_labels_filtered) %in% x)]
#   }
#   
#   
# }
# labelled::var_label(foo) <- sages_combined_labels_filtered
saveRDS(sages_combined_labels,   file=fs::path(r_objects_folder, "020_sages_combined_labels.rds"))
saveRDS(sages_combined,   file=fs::path(r_objects_folder, "020_sages_combined.rds"))
saveRDS(sages_combined_pre_imp,   file=fs::path(r_objects_folder, "020_sages_combined_pre_imp.rds"))
saveRDS(covariates_excessive_missing,      file=fs::path(r_objects_folder, "020_covariates_excessive_missing.rds"))

