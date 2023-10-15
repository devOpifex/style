#' Style
#'
#' Switch a codebase to the development state.
#'
#' @importFrom roxygen2 roxygenize
#'
#' @name style_rd
#' @export
style_rd <- function() {
  roxygenize(roclets = "style::roclet_style", load_code = "source")
}

#' Roclets
#'
#' These functions implement [roxygen2::roclet()]s for integration
#' with the roxygen2 package.
#'
#' @importFrom roxygen2 roclet roxy_tag_warning block_get_tags roclet_output
#' @importFrom roxygen2 roclet_process roxy_tag_parse rd_section roxy_tag_rd
#'
#' @rdname roclets
#' @export
roclet_style <- function() {
  roclet("style")
}

#' @export
roclet_process.roclet_style <- function(x, blocks, env, base_path, ...) {
  results <- list()
  
  for (block in blocks) {
    tags <- block_get_tags(block, "style")

    for (tag in tags) {
      res <- list(
        file = tag$val$file,
        output = tag$val$output, 
        verbose = tag$val$verbose
      )

      results <- append(results, list(res))
    }
  }
  
  results
}

#' @export
roclet_output.roclet_style <- function(x, results, base_path, ...) {
  for (style in results) {
    res <- tryCatch(
      style::style(
        file = style$file, 
        output = style$output, 
        verbose = style$verbose
      ),
      error = \(e) e
    )

    if(inherits(res, "error"))
      cat(res$message, "\n")
  }

  invisible(NULL)
}

#' @export
roxy_tag_parse.roxy_tag_style <- function(x) {
  args <- strsplit(x$raw, " ")[[1]]

  if(length(args) > 2L)
    roxy_tag_warning("invalid @style tag") 

  verbose <- FALSE
  if(length(args) == 2)
    verbose <- args[2]

  output <- x$file |>
    basename() |>
    (\(.) gsub("(.R|.r)$", ".min.css", .))()

  if(length(args) > 0)
    output <- gsub("^inst", "", args[1])

  x$val <- list(
    file = x$file,
    output = paste0("inst/", output),
    verbose = as.logical(verbose)
  )

  return(x)
}

#' @export
roxy_tag_rd.roxy_tag_style <- function(x, base_path, env) {
  rd_section("style", x$val)
}

#' @export
format.rd_section_style <- function(x, ...) {
  paste0(
    "\\section{Style}{\n",
    "Style generated with {style} version", 
    utils::packageVersion("style") |> as.character(),
    ". File generated in ", x$value$output,
    "}\n"
  )
}

wl <- \(...){
  paste0(...) |>
    writeLines()
}

#' Generate dependency
#' 
#' @param file R file from which the CSS is generated.
#' 
#' @export
generate_dependency <- function(file) {
  file <- gsub("^R/", "", file)

  pkg <- readLines("DESCRIPTION")[1]
  pkg <- gsub("Package: ", "", pkg) |> trimws()

  wl("htmltools::htmlDependency(")
  wl('\tname="', gsub(".R$", "", file), '",')
  wl("\tversion='1.0',")
  wl("\tsrc='.',")
  wl('\tpackage="', pkg, '",')
  wl('\tstylesheet="', gsub(".R$", ".min.css", file), '"')
  wl(")")
}
