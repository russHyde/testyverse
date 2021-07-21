
<!-- README.md is generated from README.Rmd. Please edit that file -->

# testyverse

<!-- badges: start -->
<!-- badges: end -->

The goal of testyverse is to …

## Installation

You can install the released version of testyverse from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("testyverse")
```

# `testyverse` - an analysis and tutorial on the R software testing universe

TODO: testing is ace

TODO: don’t be an evangelical arse about anything

TODO: Do most CRAN packages use a testing library?

TODO: For those that do, which one do they use?

TODO: And what of ancillary testing tools: hedgehog, covr, mutant,
autotest, mockery, shinytest, unitizer

TODO: Any package-package correlations between testing tools

## Testing packages

For unit testing there are several main tools available in R:

-   testthat
-   RUnit
-   testit
-   tinytest

TODO: similarities and differences between the packages

### {testthat}

### {RUnit}

Features: - Provides test-success and coverage report.

### {testit}

Features: - Nope. It just tests your stuff.

Tests look like this:

``` r
testit::assert("testit has the least to learn", {
  # All statements in parentheses should evaluate TRUE
  (TRUE)
  (123 > 0)
})
```

``` r
testit::assert("testit tells you the least", {
  summer <- function(x, y) x + y
  (summer(1, 1) == 3)
})
#> assertion failed: testit tells you the least
#> Error: (summer(1, 1) == 3) is not TRUE
```

<!--- That's quite a nice example of non-standard evaluation; consider for tidyeval course? -->

Test directory looks like this:

    ./tests
    ├── test-all.R
    └── testit
        └── test-vectors.R

The test runner looks like this:

    # ./tests/test-all.R
    library(testit)
    testit::test_pkg("myPackage")

Tests are automatically ran during `R CMD check` with no further
changes. No integration with `devtools::test()`

GPL3

### {tinytest}
