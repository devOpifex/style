<!-- badges: start -->
<!-- badges: end -->

# style

Calls [styler](https://github.com/devOpifex/styler) to scan
R files for instances of `class = ""` and generate the 
corresponding CSS.

This is inspired from [Tailwind](https://tailwindcss.com/)
and meant to be used when the latter cannot be used, like in
Shiny applications which already import Bootstrap.

## Installation

You can install the development version of style like so:

``` r
# install.packages("remotes")
remotes::install_github("devOpifex/style")
```

If you have [styler](https://github.com/devOpifex/styler) installed
that version is used, otherwise it falls back on the provided
executable.

If you have go installed run `style::install()` to install 
[styler](https://github.com/devOpifex/styler).
This is recommended to make sure you get the latest version.

## Example

``` r
# file in app/ directory
library(shiny)

ui <- fluidPage(
    div(
        class = "lg:border-radius-4 border-radius-2 border-red-400 border-width-1 sh-lg p-x-2 p-y-4",
        h1("Hello, style!", class = "text-size-8 hover:text-teal-600")
    )
)

server <-  \(...){}

shinyApp(ui, server)
```

Then run

```r
style::style(dir = "app", file = "www/style.min.css")
```

Read more on [styler](https://github.com/devOpifex/styler) and how it works.

## Roclet

There is a roxygen2 roclet for use in shiny applications as package,
e.g.: with [golem](https://github.com/ThinkR-open/golem).

First, add the roclet to your `DESCRIPTION`

```
Roxygen: list(markdown = TRUE, roclets = c("collate", "namespace", "rd", "style::roclet_style"))
```

Then use the `@style` tag in your files.
By default the tag will parse the file it is placed in and 
generate the CSS in a file of the same name in `inst`, e.g.:
placing `@style` in a `R/ui.R` will generate the CSS in `inst/ui.min.css`.

It accepts two arguments, first the named of the desired file to generated 
(relative to `inst/`), e.g.: `@style assets/styles.min.css`

The second argument is a boolean passed to `style()`.

__Example file__

```r
#' UI
#'
#' @style
#' 
#' @keywords internal
ui <- \(req){
    fluidPage(
        # ...
    )
}
```

You can use `generate_dependency` to generate the code to import the generated style.

```r
#> generate_dependency("ui.R")
htmltools::htmlDependency(
	name="ui",
	version='1.0',
	src='.',
	package="style",
	stylesheet="ui.min.css"
)
```

This is intended for modules so you can create individual CSS files for each module.
