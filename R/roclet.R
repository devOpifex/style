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
#' @importFrom roxygen2 roclet_process roxy_tag_parse
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
      results <- tryCatch(
        style::style(dir = tag$val$dir, out = tag$val$out),
        error = \(e) e
      )

      if(inherits(results, "error"))
        roxy_tag_warning(tag, "Failed to run style")
    }
  }
  
  results
}

#' @export
roclet_output.roclet_style <- function(x, results, base_path, ...) {
  for (style in names(results)) {
    cat(
      "Rendered with [style](github.com/devOpifex/style) version", 
      utils::packageVersion("style"),
      "\n"
    )
  }

  return()
}

#' @export
roxy_tag_parse.roxy_tag_style <- function(x) {
  args <- strsplit(x$raw, " ")[[1]]

  if(length(args) < 2L) {
    roxy_tag_warning(x, "Invalid @style format")
    return()
  }

  x$val <- list(
    path = args[1],
    verbose = as.logical(args[2])
  )

  return(x)
}

