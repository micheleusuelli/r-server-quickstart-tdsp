
# load and clean the data

# configure ---------------------------------------------------------------

rm(list = ls())
source("0-config.R")



# parse-terminal-arguments ------------------------------------------------

# parse the terminal arguments
par_terminal <- parseArgNamed()



# import-data -------------------------------------------------------------

csv_in <- file.path(par$folder_data_raw, par$csv_in) %>% 
  RxTextData()

rxDataStep(inData = csv_in, 
           outFile = xdf$raw, 
           overwrite = TRUE)
rxGetVarInfo(xdf$raw)



# clean-data --------------------------------------------------------------

rxFactors(inData = xdf$raw, 
           outFile = xdf$cleaned, 
          factorInfo = "Species",
           overwrite = TRUE)
rxGetVarInfo(xdf$cleaned)
