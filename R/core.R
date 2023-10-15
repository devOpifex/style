#' Style
#' 
#' Generate CSS
#' 
#' @param dir Directory containing R files to scan.
#' @param out Path to output CSS file.
#' @param verbose Whether to warn on classes that fail to parse.
#' 
#' @export
style <- function(dir, out, verbose = FALSE) {
  if(missing(dir))
    stop("missing `dir`")

  if(missing(out))
    stop("missing `out`")

  executable <- Sys.which("styler")

  if(executable == "")
    executable <- system.file("styler", package = "style")

  args <- c(dir = dir, out = out, verbose = verbose)
  system2(executable, args)
}
