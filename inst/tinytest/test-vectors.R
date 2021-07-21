# {tinytest} test scripts are just R scripts with some expectations dotted about

x <- letters[1:5]
y <- LETTERS[1:4]
z <- c(x, y)

tinytest::expect_equal(
  current = length(z),
  target = length(x) + length(y) + 1
)
