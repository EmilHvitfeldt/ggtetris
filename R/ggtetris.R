#' Creates a tetris visualization using ggplot2
#'
#' This function creates a chart where the number in each group is represented
#' by a collection of connected squares proportional to the number in that
#' group. In this function the group counts are supplied as input.
#'
#' @param data Numerical vector of counts, named or otherwise or data.frame
#'     with a name column and a count column.
#' @param colunms Numeric. Number of colunms.
#' @param xlab text for below the chart.
#' @param colors Same number of colors as values in \code{data}.
#'     If omitted, Color Brewer "Set3" colors are used.
#' @param line_color Color of the outline of the polygons in the chart.
#'     Defaults to grey.
#' @param title Character. chart title.
#' @return ggplot objects.
#' @examples
#' nums <- c(25, 13, 12, 7, 43)
#' ggtetris(data = nums)
#'
#' ggtetris(rep(6, 12), colunms = 8)
#'
#' ggtetris(c('AA' = 30, 'BB' = 23, 'CC' = 10))
#'
#' ggtetris(
#'   data.frame(
#'     names = LETTERS[1:4],
#'     vals = c(80, 30, 20, 10)
#'     ), colunms = 8
#'  )
#'
#'  raw_data <- rpois(100, lambda = 1)
#'  counts <- table(raw_data)
#'  ggtetris(counts)
#' @export
ggtetris <- function(data, colunms = 10, xlab = NULL, colors = NA,
                     line_color = NA, title = NULL) {

  if (inherits(data, "data.frame")) {
    data <- stats::setNames(unlist(data[, 2], use.names = FALSE),
                            unlist(data[, 1], use.names = FALSE))
  }

  # fill in any missing names
  data_names <- names(data)
  if (length(data_names) < length(data)) {
    data_names <- c(data_names, LETTERS[1:length(data) - length(data_names)])
  }

  names(data) <- data_names

  # Set colors if not otherwise specified
  if (all(is.na(colors))) {
    colors <- suppressWarnings(brewer.pal(length(data), "Set3"))
  }

  # Set line color if not otherwise specified
  if (is.na(line_color)) {
    line_color <- "grey"
  }

  step_1 <- block_pos(sum(data), width = colunms) %>%
    dplyr::mutate(id = break_help(data))

  plot_data <- purrr::map_df(1:length(data), ~ step_1 %>%
                 dplyr::filter(id == .x) %>%
                 dplyr::select(-id) %>%
                 as.matrix() %>%
                 tetris() %>%
                 reduce_matrix() %>%
                 tibble::as.tibble() %>%
                 dplyr::mutate(group = names(data)[.x]))

  plot_data %>%
    ggplot(aes(plot_data$x, plot_data$y,
               group = plot_data$group,
               fill = as.factor(plot_data$group))) +
    geom_polygon(color = line_color) +
    theme_minimal() +
    coord_fixed() +
    labs(x = xlab, y = NULL, fill = NULL, title = title) +
    scale_x_continuous(breaks = seq(1, colunms, 1)) +
    theme(panel.grid = element_blank()) +
    theme(axis.ticks = element_line()) +
    scale_fill_manual(values = colors, guide = guide_legend(reverse = TRUE))
}
