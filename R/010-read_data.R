### This file reads in the raw data.  
# It's input is the raw data files.
# It's output is the following R objects:
# saveRDS(sages_apoe,            file=path(r.objects.folder.tidymodel, "010_sages_apoe.rds"))
# saveRDS(sages_del_assessment,  file=path(r.objects.folder.tidymodel, "010_sages_del_assessment.rds"))
# saveRDS(sages_mr,              file=path(r.objects.folder.tidymodel, "010_sages_mr.rds"))
# saveRDS(sages_proxy_interview, file=path(r.objects.folder.tidymodel, "010_sages.proxy.iterview.rds"))
# saveRDS(sages_slope_36M,       file=path(r.objects.folder.tidymodel, "010_sages_slope_36M.rds"))
# saveRDS(sages_slope_48M,       file=path(r.objects.folder.tidymodel, "010_sages_slope_48M.rds"))
# saveRDS(sages_subject,         file=path(r.objects.folder.tidymodel, "010_sages_subject.rds"))

### Read in the data

# The (36M) slope variables aren't yet in a frozen file.  They are still in the processing file.
# vdgcp_slope36m = the slope at 36M from the quadratic model
# vdgcp_change36m = the change from from baseline to 36M from the quadratic model

if (Sys.getenv("USER") != "rnj") {
  sages_slope_36M <- haven::read_dta(fs::path(sagesdatafolder, "derived", "clean", "processingfiles", "SAGES-Subject-Interview-Data-Analysis-File.dta"))
}
if (Sys.getenv("USER") == "rnj") {
  sages_slope_36M <- haven::read_dta(fs::path(sagesdatafolder.frozen, "SAGES-Subject-Interview-Data-Analysis-File.dta"))
}
attributes(sages_slope_36M$studyid) <- NULL

sages_slope_36M <- sages_slope_36M %>%
  filter(grepl("S", studyid)) %>%
  filter(timefr==0) %>%
  select(studyid, vdgcp_slope36m, vdgcp_change36m)

# The 48M slope
sages_slope_48M <- haven::read_dta(fs::path(sagesdatafolder.frozen, "slope48.dta")) 
attributes(sages_slope_48M$studyid) <- NULL

sages_slope_48M <- sages_slope_48M %>%
  rename(vdgcp_slope48m = vdgcp_slope48) %>%
  filter(grepl("S", studyid)) %>%
  filter(timefr==0) %>%
  select(-timefr)


# # These are the slopes used by Devore.  They are calculated through 36M
# sages_slope_36M <- read.csv("~/documents/dwork/sages/projects/p1a1/posted/data/derived/slopes.csv", stringsAsFactors=FALSE)
# sages_slope_36M <- sages_slope_36M %>%
#   rename(vdgcp_slope = f_s1)

# Get main subject file
# Keep only the baseline data

sages_subject <- haven::read_dta(fs::path(sagesdatafolder.frozen, "SAGES-Subject-Interview-Data-Analysis-File.dta")) 
attributes(sages_subject$studyid) <- NULL

sages_subject <- sages_subject %>%
  filter(grepl("S", studyid)) %>%
  filter(timefr==0)

# Get delirium status
# Since the variable is time-invariant, keeping only the first record
sages_del_assessment <- haven::read_dta(fs::path(sagesdatafolder.frozen, "SAGES-Delirium-Assessments-Analysis-File.dta"))
attributes(sages_del_assessment$studyid) <- NULL
attributes(sages_del_assessment$vdsagesdeliriumever) <- NULL

sages_del_assessment <- sages_del_assessment %>% 
  select("studyid", "vdsagesdeliriumever") %>%
  group_by(studyid) %>%
  dplyr::slice(1) %>%
  ungroup() %>%
  mutate(vdsagesdeliriumever = factor(vdsagesdeliriumever),
         vdsagesdeliriumever = fct_collapse(vdsagesdeliriumever, "No Delirium" = c("0", "1"), "Delirium" = "2" ))

# Get baseline proxy IQCODE
sages_proxy_interview <- haven::read_dta(fs::path(sagesdatafolder.frozen, "SAGES-Proxy-Interview-Data-Analysis-File.dta"))
attributes(sages_proxy_interview$studyid) <- NULL

sages_proxy_interview <- sages_proxy_interview %>% 
  filter(timefr==0) %>%
  filter(grepl("S", studyid)) %>%
  select("studyid", "vdiqc") %>%
  rename(vdiqc_proxy = vdiqc)

# Get APOE4 status    
if (Sys.getenv("USER") != "rnj") {
  sages_apoe <- haven::read_dta(fs::path(sagesdatafolder, "Source", "Project2", "apoefinal_051914.dta"))
}
if (Sys.getenv("USER") == "rnj") {
  sages_apoe <- haven::read_dta(fs::path(sagesdatafolder.frozen, "apoefinal_051914.dta"))
}
names(sages_apoe) <- tolower(names(sages_apoe))
attributes(sages_apoe$studyid) <- NULL
sages_apoe <- sages_apoe %>%
  select("studyid", "apoe4")

# Get Charlson score, vascular score, lab values
# Setting 999 lab values to missing
# Recoding lab values for certain participants

sages_mr <- haven::read_dta(fs::path(sagesdatafolder.frozen, "SAGES-Medical-Record-Data-Analysis-File.dta"))
attributes(sages_mr$studyid) <- NULL
sages_mr <- sages_mr %>%
  select("studyid", "vdcci", "vdvascom",  
         "ins01", "ins02", "ins03", "ins04", "ins05", "op01", "ci01", "dep01", "op04a", "op04b", "op04c",
         "icd01a", "icd02a", "icd03a", "icd04a", "icd05a", "icd06a", "icd07a", "icd08a", "icd09a", "icd10a",
         "icd11a", "icd12a", "icd13a", "icd14a", "icd15a", "icd16a", "icd17a", "icd18a", "icd19a", "icd20a",
         "dxv2", "dxm1", "dxv5", "dxc1a", "dxi3", "dxr1", "dxn4", "dxv3", "dxc2", "dxn1",   
         "lab01a", "lab02a", "lab03a", "lab04a", "lab05a", "lab06a", "lab07a", "lab08a", "lab09a", "lab10a",
         "lab11a", "lab12a", "lab13a", "lab14a", "lab15a",
         "lab01c", "lab02c", "lab03c", "lab04c", "lab05c", "lab06c", "lab08c", "lab15c", "lab16c",
         "lab17c", "lab18c", 
         "lab02e", "lab03e", "lab04e", "lab05e") %>%
  filter(str_detect(studyid, "S")) 

if (Sys.getenv("USER") != "rnj") {
  sages_rnj <- haven::read_dta(fs::path(sagesdatafolder, "derived", "sages-pred-models", "w71.dta"))
}
if (Sys.getenv("USER") == "rnj") {
  sages_rnj <- haven::read_dta(fs::path(sagesdatafolder.frozen, "w71.dta"))
}

sages_rnj <- sages_rnj %>%
  select(-n560, -vdp41711, -vdp41712, -vdp41713, -vdp41714, -vdp41715, -vdp41716, -vdp41717, -vdp44702) 


n560 <- haven::read_dta(fs::path(sagesdatafolder.frozen, "n560.dta"))[c("studyid")]

sages_apoe            <- dplyr::semi_join(sages_apoe            , n560, by = "studyid")
sages_del_assessment  <- dplyr::semi_join(sages_del_assessment  , n560, by = "studyid")
sages_mr              <- dplyr::semi_join(sages_mr              , n560, by = "studyid")
sages_proxy_interview <- dplyr::semi_join(sages_proxy_interview , n560, by = "studyid")
sages_slope_36M       <- dplyr::semi_join(sages_slope_36M       , n560, by = "studyid")
sages_slope_48M       <- dplyr::semi_join(sages_slope_48M       , n560, by = "studyid")
sages_subject         <- dplyr::semi_join(sages_subject         , n560, by = "studyid")
sages_rnj             <- dplyr::semi_join(sages_rnj             , n560, by = "studyid")

### Save the R objects
saveRDS(sages_apoe,            file=fs::path(r_objects_folder, "010_sages_apoe.rds"))
saveRDS(sages_del_assessment,  file=fs::path(r_objects_folder, "010_sages_del_assessment.rds"))
saveRDS(sages_mr,              file=fs::path(r_objects_folder, "010_sages_mr.rds"))
saveRDS(sages_proxy_interview, file=fs::path(r_objects_folder, "010_sages_proxy_iterview.rds"))
saveRDS(sages_slope_36M,       file=fs::path(r_objects_folder, "010_sages_slopes_36M.rds"))
saveRDS(sages_slope_48M,       file=fs::path(r_objects_folder, "010_sages_slopes_48M.rds"))
saveRDS(sages_subject,         file=fs::path(r_objects_folder, "010_sages_subject.rds"))
saveRDS(sages_rnj,         file=fs::path(r_objects_folder, "010_sages_rnj.rds"))


