
# For the creation of the variable selection report
quarto::quarto_render(here::here("R", "000-Master-Variable_selection.qmd"), output_format = "html")
fs::file_move(here::here("R", "000-Master-Variable_selection.html"), here::here("Reports", str_c("Variable_selection_report_", Sys.Date(), ".html")))

quarto::quarto_render(here::here("R", "000-Master-Variable_selection.qmd"), output_format = "docx", pandoc_args = "--reference-doc=../Reports/Report_2024-02-01_Reference.docx")
fs::file_move(here::here("R", "000-Master-Variable_selection.docx"), here::here("Reports", str_c("Variable_selection_report_", Sys.Date(), ".docx")))

