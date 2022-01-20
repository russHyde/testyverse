# Notes on testing in R

## 2021-07-06 - UseR 2021 videos

### Unit Testing Shiny App Reactivity (Jonathan Sidi)

"Cascading reactivity": when reactive components trigger each other in an unintended way

{reactor} package adds reactivity expectations to unit testing

`remotes::install_github("yonicd/reactor")`

Other tools for testing in shiny:

- {shinyjster} (for javascript testing)
- {shinytest} (for inputs and UI behaviour)
- {shiny}::testServer (verifies reactive outputs are as expected)

These don't test if reactivity is creating problems with app integrity

```
library(reactor)
obj <- init_reactor() # R6 class
```

The reactor object expects an:

- application (background process that hosts the shiny app)
- driver (webdriver that will interact with the app in the background process; selenium or
  puppeteer)

Uses {processx} to make shiny application calls

Set up:

```
obj <- obj |>
  set_runapp_args(appDir = "PATH_TO_APP/app.R") # standard shiny app
obj <- obj |>
  set_golem_args(package_name = "mypackage") # golem app

obj <- obj |>
  set_chrome_driver() # or `set_firefox_driver()`
```

Headless mode can be turned off with `... opts = firefox_options(headless = FALSE)`

Once specified:

```
# starts app and driver in background processes
# use {RSelenium} commands or {reactor} functions to control the app
obj |> start_reactor()
```

Interacting with the app

```
set_id_value()       # set a shiny input
execute()            # run a JS call
query_input_names()  # names of the shiny inputs
query_input_id()     # values of shiny inputs by id
query_output_names() # names of shiny output ids
query_output_id()    # values of shiny outputs by id
query()              # returns value from a JS call
```

Pipelines are possible since each function returns the reactor object
And you test reactivity within the pipeline

```
init_reactor() |>
  set_runapp_args(blah) |>
  set_chrome_driver() |>
  start_reactor() |>
  set_id_value(x = y) |>
  # test how many times an element updates
  expect_reactivity("hist", 1) |>
  set_id_value(z = 2) |>
  # test how long an interaction event takes
  expect_busy_time(0.1) |>
  kill_app()
```

{testthat} integration

```
testthat::describe("good reactivity", {
  it("affects the histogram", {
    obj |>
      start_reactor() |>
      set_id_value("n", 500) |>
      expect_reactivity(tag = "hist", count = 2) |>
      kill_app()
  })
})
```

Directory structure for {reactor} tests is the same as for {testthat}

- but use ./tests/testthat/reactor-{test-name}.R
- these aren't ran by {covr}
- use `reactor::test_app()`

GitHub Actions using googledriver and geckdriver

- [https://github.com/yonicd/reactor/blob/master/.github/workflows/R-reactor.yml]

GHA with separate unit tests and deployment to Heroku

- [https://github.com/yonicd/puzzlemath/blob/main/.github/workflows/R-reactor.yml]

### RcppDeepState - a simple way to fuzz test R packages (Akhila Chowdary Kolla)

Fuzzing:

- Generation of invalid, unexpected or random data as inputs to a computer program
- .. that are expected to make it crash, fail or generate errors
- C++ already has a lot of fuzzing engines (Angr, AFL, HonggFuzz...)

DeepState:

- way to run unit tests with a lot of fuzzers

RcppDeepState:

- Used for memory debugging and leak detection
- Uses C++ test harnesses in R libraries
- Easy interface to fuzzers like AFL etc

List of R unit test frameworks:

- RUnit, testthat, tinytest, unitizer

### `autotest` (Mark Padgham)

Analyses all inputs of all functions, and modifies them, then looks at output of the function

Examines the documentation of functions

Ensures classes / types are as in the examples for each function

Workflow:

- Make a package
- Add a function
- Add roxygen
- document()
- `library(autotest); a <- autotest_package(path, test = TRUE)`

`autotest` then gives you some suggestions as to how to improve the documentation, and some
assertions you might add (eg, using `checkmate::assertInt`)

With `test = FALSE` it will detail the tests that it would run.

For real examples, the output can be huge, so use `DT(a)` for interactive table

[Compare to R CMD check and python::doctest; these just check that the doc examples work as stated]

### tinytest

Dependency free unit test framework

Syntax is very similar to testthat

----

Blog idea:

1) tdd for shiny app
1) analyse dependencies of the testing tools
1) show how to structure an app: pull everything you can into functions, pull everything else into
modules
1) show to test functions with testthat, and with tinytest
1) show how to use examples rox to add tests as documentation
1) show how to test modules with shinytest
1) show that shinytest doesn't capture reactivity issues
1) show how to use reactor
1) can we elbow in autotest, mockery, mutant, hedgehog, covr, (?unitizer)
1) Non-R testing stuff that relates to shiny dev? puppeteer / selenium
1) Using tests in CI & R CMD check

Tools:

CRAN

- testthat, tinytest, shinytest, mockery, hedgehog, covr

Non-CRAN

- autotest, reactor, mutant

Non-R

- puppeteer, selenium
