analysisfolder         <- here::here()
projectfolder          <- fs::path(fs::path_home(), "documents", "dwork", "SAGES")
datafolder             <- fs::path(projectfolder, "posted", "data")
sagesdatafolder        <- fs::path(projectfolder, "posted", "data")
# sagesdatafolder.frozen <- fs::path(datafolder, "derived", "CLEAN", "frozenfiles", "freeze_2019-02-28")
sagesdatafolder.frozen <- fs::path(datafolder, "derived", "CLEAN", "adhoc_2023-12-18")

r_objects_folder <- here::here("R_objects")

if (Sys.getenv("USER") == "rnj") {
  projectfolder          <- fs::path(fs::path_home(), "dwork", "data_management", "SAGES-I")
  datafolder             <- fs::path(projectfolder, "data")
  # I DON"T EVEN HAVE A FREEZE 2019-02-28
  sagesdatafolder        <- fs::path(datafolder, "SOURCE", "CLEAN","FROZENFILES", "freeze_2019-04-23")
  sagesdatafolder.frozen <- fs::path(datafolder, "SOURCE", "CLEAN","FROZENFILES","adhoc_2023-12-18") # "frozenfiles", "freeze_2019-02-28")
}

#dir(projectfolder)
#dir(sagesdatafolder.frozen)
#dir(sagesdatafolder)
