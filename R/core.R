#' Style
#' 
#' Generate CSS, set either `dir` or `file`.
#' 
#' @param dir Directory containing R files to scan.
#' @param file File to scan.
#' @param output Path to output CSS file.
#' @param verbose Whether to warn on classes that fail to parse.
#' 
#' @export
style <- function(dir = NULL, file = NULL, output = "style.min.css", verbose = FALSE) {
  if(is.null(dir) && is.null(file))
    stop("set `dir` or `file`")

  executable <- Sys.which("styler")

  if(executable == "")
    executable <- system.file("styler", package = "style")

  args <- sprintf("-output=%s verbose=%s", output, tolower(verbose))
  
  if(!is.null(file))
    args <- sprintf(
      "-file=%s %s",
      file,
      args
    )

  if(!is.null(dir))
    args <- sprintf(
      "-dir=%s %s",
      dir,
      args
    )

  system2(executable, args)
}
