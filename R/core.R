#' Style
#' 
#' Generate CSS
#' 
#' @param dir Directory containing R files to scan.
#' @param file Output CSS file.
#' @param warn Whether to warn on classes that fail to parse.
#' 
#' @export
style <- function(dir, file, warn = FALSE) {
  if(missing(dir))
    stop("missing `dir`")

  if(missing(file))
    stop("missing `file`")

  executable <- Sys.which("styler")

  if(executable == "")
    executable <- system.file("styler", package = "style")

  args <- c(dir = dir, file = file)
  system2(executable, args)
}
