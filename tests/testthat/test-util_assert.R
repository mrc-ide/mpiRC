context(util_assert)

test_that("assert_scalar", {
  expect_error(assert_scalar(mtcars), "'mtcars' must be a scalar")
  expect_invisible(assert_scalar(1))
  expect_error(assert_scalar(c(1,2,3)), "'c\\(1, 2, 3)' must be a scalar")
})

test_that("assert_numeric", {
  expect_invisible(assert_numeric(1.234))
  expect_invisible(assert_numeric(c(1.234, 3.456)))
  expect_invisible(assert_numeric(c(1L, 2L, 3L)))
  expect_error(assert_numeric("1"), "'\"1\"' must be a number")
})

test_that("assert_whole", {
  expect_invisible(assert_whole(42L))
  expect_invisible(assert_whole(42.0))
  expect_error(assert_whole(2.5), "'2.5' must be integer-like")
})

test_that("assert_int_between", {
  expect_invisible(assert_int_between(0, 0, 0))
  expect_invisible(assert_int_between(1, 1, 2))
  expect_invisible(assert_int_between(2, 1, 2))
  x <- 3
  expect_error(assert_int_between(x, 1, 2),
    "'x' out of range \\(3 not in 1..2)")
})
