#' Tidy ggtetris inputs to regular ggplot usage
#'
#' transforms (named) vector of counts or data.frames with names and counts
#' to tidy data.frames. If names are not provided for all counts in the vector,
#' will they be set to capital letters.
#'
#' @param data Numerical vector of counts, Named or otherwise or data.frame
#'     with a name column and a count column.
#' @return Tidy tibble ready to be used with \code{geom_bar()}.
#' @examples
#' vec <- rep(5, 10)
#' ggtetris_tidy(vec)
#'
#' vec_named <- c('AA' = 20, 'BB' = 10, 'CC' = 15)
#' ggtetris_tidy(vec_named)
#'
#' data <- data.frame(names = letters[1:4], vals = c(80, 30, 20, 10))
#' ggtetris_tidy(data)
#' @export
ggtetris_tidy <- function(data) {
  if (inherits(data, "data.frame")) {
    data <- stats::setNames(unlist(data[, 2], use.names = FALSE),
                            unlist(data[, 1], use.names = FALSE))
  }

  data_names <- names(data)
  if (length(data_names) < length(data)) {
    data_names <- c(data_names, LETTERS[1:length(data) - length(data_names)])
  }
  tibble::tibble(group = data_names[break_help(data)])
}
