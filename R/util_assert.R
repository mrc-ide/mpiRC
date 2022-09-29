assert_scalar <- function(x, name = deparse(substitute(x))) {
  if (length(x) != 1) {
    stop(sprintf("'%s' must be a scalar", name), call. = FALSE)
  }
}

assert_numeric <- function(x, name = deparse(substitute(x))) {
  if (!is.numeric(x)) {
    stop(sprintf("'%s' must be a number", name), call. = FALSE)
  }
}

assert_whole <- function(x, name = deparse(substitute(x))) {
  assert_numeric(x, name)
  tol <- .Machine$double.eps ^ 0.5
  if (abs(x - round(x)) > tol) {
    stop(sprintf("'%s' must be integer-like", name), call. = FALSE)
  }
}

assert_int_between <- function(x, xmin, xmax) {
  if ((x < xmin) || (x > xmax)) {
    stop(sprintf("'%s' out of range (%d not in %d..%d)", name, x, xmin, xmax))
  }
}

check_root_node <- function(root) {
  assert_whole(root)
  root <- as.integer(root)
  assert_int_between(root, 0, mpirc_MPI_Comm_size() - 1)
  invisible()
}
