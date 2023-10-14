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

## Example

``` r
# file in app/ directory
library(shiny)

ui <- fluidPage(
    div(
        class = "border-radius-2 border-red-400 border-width-1 sh-lg p-x-2 p-y-4",
        h1("Hello, style!", class = "text-size-8")
    )
)

server <-  \(...){}

shinyApp(ui, server)
```

Then run

```r
style::style(dir = "app", file = "www/style.min.css")
```

Read more on [styler](https://github.com/devOpifex/styler)
