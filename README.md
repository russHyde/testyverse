
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

### {testit}

GPL3

    ./tests/testit/test-some_file.R

    # ./tests/test-all.R
    library(testit)
    testit::test_pkg("myPackage")

``` r
assert("testit has the least to learn", {
  # All statements in parentheses should evaluate TRUE
  (TRUE)
  (123 > 0)
})
```

### {tinytest}
