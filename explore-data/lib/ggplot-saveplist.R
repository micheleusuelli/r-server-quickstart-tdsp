#'
#' save a list of ggplot2 charts. If the list includes matrices or data frames, save them as CSV files.
#'
#'
#' @param  plist list of ggplot2 charts
#' @param  folder = "." folder to save the charts into
#' @param  format = "png" file format
#' @param  ... ggsave arguments
#'
#'
#' @return
#' @export


savePlist <- function(
  plist, # list of ggplot2 charts
  folder = ".", # folder to save the charts into
  format = "png", # file format
  ... # ggsave arguments
) {

  # save a ggplot list into a folder

  if(!file.exists(folder)) {
    dir.create(folder)
  }

  # browser()
  for(ip in 1:length(plist)) {

    p <- plist[[ip]]

    if("ggplot" %in% class(p)) {

      # define the chart name
      if(!is.null(p$labels$title)) {
        name_chart <- p$labels$title
      } else{
        name_chart <- paste0("chart", ip)
      }
      name_chart <- gsub("/", "", name_chart)

      # define the file name
      file_chart <- sprintf("%s/%s.%s",
                            folder,
                            name_chart,
                            format)

      # save the chart
      ggsave(filename = file_chart, plot = p, ...)

    }

    if("data.frame" %in% class(p) |
       "matrix" %in% class(p)) {

      # define the table name
      name_table <- names(plist)[ip]
      if(is.null(name_table)) {
        name_table <- paste0("table", ip)
      }

      # define the file name
      name_file <- sprintf("%s/%s.%s",
                           folder,
                           name_table,
                           "csv")

      # write the table
      write.csv(p, file = name_file)

    }

  }

}


