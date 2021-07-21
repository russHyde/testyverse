
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

<!---
# Test syntax
# An example passing test
# An example failing test
# How do you structure your test files
# Can you run test files individually
# Integration of testing with R CMD check
# Integration of testing with RStudio
-->

### {testthat}

### {RUnit}

Features: - Provides test-success and coverage report.

### {testit}

Features: - Nope. It just tests your stuff.

Tests look like this:

``` r
testit::assert("{testit} has the least to learn", {
  # All statements in parentheses should evaluate TRUE
  (TRUE)
  (123 > 0)
})
```

``` r
# Non-passing tests throw an error

testit::assert("{testit} tells you the least", {
  summer <- function(x, y) x + y
  (summer(1, 1) == 3)
})
#> assertion failed: {testit} tells you the least
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

Tests look very similar to {testthat} syntax (although you can use RUnit
syntax in test files, we won’t cover that here).

``` r
# {tinytest} uses `expect_*` syntax
# the functions are name::spaced to avoid confusion with the {testthat} equivalents

tinytest::expect_equal(
  current = 1 + 1,
  target = 2,
  info = "Maths still works"
)
#> ----- PASSED      : <-->
#>  call| tinytest::expect_equal(current = 1 + 1, target = 2, info = "Maths still works")
#>  info| Maths still works

tinytest::expect_equivalent(
  current = tibble::tibble(x = 1),
  target = data.frame(x = 1)
)
#> ----- PASSED      : <-->
#>  call| tinytest::expect_equivalent(current = tibble::tibble(x = 1), 
#>  call| target = data.frame(x = 1))

# Failing tests do not raise an error
tinytest::expect_true(FALSE)
#> ----- FAILED[data]: <-->
#>  call| tinytest::expect_true(FALSE)
#>  diff| Expected TRUE, got FALSE
```

The directory structure for {tinytest} tests looks like this:

    ./inst
    └── tinytest
        └── test-vectors.R
    ./tests
    └── tinytest.R

The test runner looks like this:

    # ./tests/tinytest.R
    if (requireNamespace("tinytest", quietly = TRUE)) {
      tinytest::test_package("myPackage")
    }

NO! That can’t be right. `R CMD check` ran from RStudio, tinytest.R is
ran, but a failing test in ./inst/tinytest/test-vectors.R does not lead
to `R CMD check failing`
<!-- If a file doesn't exist then run_test_file("not-a-file.R") returns without error / warning -->

Features:

-   `tinytest::setup_tinytest("myPackage")`
