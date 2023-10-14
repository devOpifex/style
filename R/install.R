#' Install
#' 
#' Install styler, requires Go.
#' 
#' @export
install <- function(){
  system2("go", c("install", "github.com/devOpifex/styler"))
}
