


# load-packages -----------------------------------------------------------

# load the packages
packages_to_load <- intersect(readLines("config/0-packages.txt"),
                                rownames(installed.packages()))
invisible(sapply(packages_to_load, library, character.only = TRUE))

# load the personal library
files_to_source <- list.files("lib",
                              full.names = TRUE,
                              recursive = TRUE,
                              pattern = "[.]R$")
invisible(sapply(files_to_source, source))



# load-parameters ---------------------------------------------------------

par <- jsonlite::fromJSON("config/1-parameters.json")



# define-data-sources -----------------------------------------------------

xdf <- list(
  raw = file.path(par$folder_data_processed, par$xdf_raw),
  cleaned = file.path(par$folder_data_processed, par$xdf_cleaned)
) %>% lapply(RxXdfData)



