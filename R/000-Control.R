
quarto::quarto_render(here::here("R", "000-Master.qmd"), output_format = "html")
fs::file_move(here::here("R", "000-Master.html"), here::here("Reports", str_c("Report_", Sys.Date(), ".html")))

quarto::quarto_render(here::here("R", "000-Master.qmd"), output_format = "docx")
fs::file_move(here::here("R", "000-Master.docx"), here::here("Reports", str_c("Report_", Sys.Date(), ".docx")))

              