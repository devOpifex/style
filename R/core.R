#' Style
#' 
#' Generate CSS, set either `dir` or `file`.
#' 
#' @param dir Directory containing R files to scan.
#' @param file File to scan.
#' @param out Path to output CSS file.
#' @param verbose Whether to warn on classes that fail to parse.
#' 
#' @export
style <- function(dir = NULL, file = NULL, out = "style.min.css", verbose = FALSE) {
  if(is.null(dir) && is.null(file))
    stop("set `dir` or `file`")

  executable <- Sys.which("styler")

  if(executable == "")
    executable <- system.file("styler", package = "style")

  args <- c(dir = dir, file = file, out = out, verbose = verbose)
  system2(executable, args)
}
