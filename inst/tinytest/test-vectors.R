# {tinytest} test scripts are just R scripts with some expectations dotted about

x <- letters[1:5]
y <- LETTERS[1:4]
z <- c(x, y)

# Note that you have to use `expect_equal` not `tinytest::expect_equal`
# Test results won't be registered if you use the latter syntax

expect_equal(
  current = length(z),
  target = length(x) + length(y)
)
