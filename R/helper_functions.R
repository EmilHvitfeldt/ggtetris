#' Expands unit-squares on points.
#'
#' @param X A data.frame with two columns, named x and y respectively.
#' @return Takes a set of gridpoints and returns the the vertices of the unit
#'     square it the points as its center.
#' @examples
#' X <- data.frame(x = c(1, 1, 1),
#'                 y = c(1, 2, 3))
#' square_it_mat(X)
#' @export
square_it_mat <- function(X) {
  mat_X <- as.matrix(X)
  x_mat <- y_mat <- matrix(0, NROW(mat_X), NCOL(mat_X))
  x_mat[, 1] <- 0.5
  y_mat[, 2] <- 0.5
  rbind(
    mat_X + x_mat + y_mat,
    mat_X + x_mat - y_mat,
    mat_X - x_mat + y_mat,
    mat_X - x_mat - y_mat
  )
}

#' Dertermine grid point positions to insure groups are connected
#'
#' @param total Integer, total number of grid points needed.
#' @param width Integer, width of the chart.
#' @return tibble with total number of rows and 2 column named x and y
#'     respectively.
#' @examples
#' block_pos(100, 10)
#' block_pos(111, 8)
#' @export
block_pos <- function(total, width) {
  height <- ceiling(total / width)

  y_coord <- rep(1:height, each = width, length.out = total)
  x_coord <- rep(1:width, times = height)
  for (i in 1:height) {
    if(i %% 2) {
      section <- 1:width + (i - 1) * width
      x_coord[section] <- rev(x_coord[section])
    }
  }
  tibble::tibble(x = x_coord[1:total],
                 y = y_coord)
}

#' Checks if there is a point at given location
#'
#' This function checks if one of the rows in X is equal to the sum
#' of the i-1'th edge and vec.
#'
#' @param X A data.frame with two columns, named x and y respectively.
#' @param i Numerical. current index.
#' @param edges A data.frame with two columns, named x and y respectively.
#' @param vec A vector of length 2.
#' @return Logical.
#' @examples
#' edges <- data.frame(x = c(1, 1, 1),
#'                     y = c(1, 2, 3))
#' i <- 3
#' X <- data.frame(x = c(1, 1, 1),
#'                 y = c(1, 2, 3))
#'
#' vec <- c(0, 1)
#'
#' direction_check(X, i, edges, vec)
#' @export
direction_check <- function(X, i, edges, vec) {
  temp <- logical(nrow(X))
  for (j in 1:nrow(X)) {
    temp[j] <- all(as.matrix(X)[j, ] == (edges[i - 1, ] + vec))
  }
  any(temp)
}

#' Repeating of indexes
#'
#' @param x Numerical, vector.
#' @return Numerical.
#' @examples
#' break_help(c(1, 2, 3))
#' break_help(c(6, 8, 23, 50))
#' @export
break_help <- function(x) {
  purrr::map2(x, 1:length(x), ~ rep(.y, .x)) %>% unlist()
}

#' Remove redundant points
#'
#' @param points A matrix with two columns, named x and y respectively.
#'  Corresponding to the vertices points.
#' @return A matrix with two columns, named x and y respectively.
#'  Corresponding to the vertices points.
#' @examples
#' X <- data.frame(x = c(1, 1, 1, 2, 3),
#'                 y = c(1, 2, 3, 2, 2))
#' points <- tetris(X)
#' reduce_matrix(points)
#' @export
reduce_matrix <- function(points) {
  len_points <- NROW(points)
  index <- logical(len_points)
  index[1] <- TRUE

  for(i in 2:(len_points - 1)) {
    index[i] <- (points[i - 1, "y"] - points[i, "y"]) *
      (points[i - 1, "x"] - points[i + 1, "x"]) !=
      (points[i - 1, "y"] - points[i + 1, "y"]) *
      (points[i - 1, "x"] - points[i, "x"])
  }

  points[index, ]
}
