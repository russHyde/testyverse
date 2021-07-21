assert("appending vectors", {
  x <- letters[1:5]
  y <- LETTERS[1:4]
  z <- c(x, y)
  assert(length(z) == length(x) + length(y))
})
