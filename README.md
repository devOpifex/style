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

## Example

``` r
# file in app/ directory
library(shiny)

ui <- fluidPage(
    div(
        class = "b-r-2 b-c-red-400 b-s-5 sh-lg p-x-2 p-y-4",
        h1("Hello, style!", class = "t-s-8")
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
