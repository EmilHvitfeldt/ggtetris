#' Scales using original Tetris colors as scales
#'
#' Allows to set scales to the colors used in an array of different Tetris
#' games. See \url{https://en.wikipedia.org/wiki/Tetris#Tetromino_colors}
#' for more information of names and color. Name of color scale are
#' "Vadim Gerasimov", "Microsoft", "Sega", "The New Tetris",
#' "The Tetris Company", "Atari", "The Soviet Mind Game", "Tetris DX",
#' "Super Tetris 3", "Tetris Plus" and "The Next Tetris". Defaults to
#' "Vadim Gerasimov". Will pad with white if after 7 colors are used.
#'
#' @param ... Other arguments passed on to [discrete_scale()] to control name, limits,
#'     breaks, labels and so forth.
#' @param palette Character. Name of color scale. Pick between "Vadim Gerasimov",
#'     "Microsoft", "Sega", "The New Tetris", "The Tetris Company", "Atari",
#'     "The Soviet Mind Game", "Tetris DX", "Super Tetris 3", "Tetris Plus"
#'     and "The Next Tetris". Defaults to "Vadim Gerasimov".
#'
#' @examples
#' dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
#' (d <- ggplot(dsamp, aes(carat, price)) +
#'   geom_point(aes(colour = color)))
#'   d + scale_colour_tetris()
#' @name scale_tetris
#' @aliases NULL
NULL

#' @rdname scale_tetris
#' @export
scale_colour_tetris <- function (..., palette = "Vadim Gerasimov") {
  pal <- function(n) {
    c(tetris_color(palette = palette), rep("#FFFFFF", max(n - 7, 0)))
  }
  discrete_scale(aesthetics = "colour", "manual", pal, ...)
}

#' @rdname scale_tetris
#' @export
scale_color_tetris <- function (..., palette = "Vadim Gerasimov") {
  pal <- function(n) {
    c(tetris_color(palette = palette), rep("#FFFFFF", max(n - 7, 0)))
  }
  discrete_scale(aesthetics = "color", "manual", pal, ...)
}

#' @rdname scale_tetris
#' @export
scale_fill_tetris <- function (..., palette = "Vadim Gerasimov") {
  pal <- function(n) {
    c(tetris_color(palette = palette), rep("#FFFFFF", max(n - 7, 0)))
  }
  discrete_scale(aesthetics = "fill", "manual", pal, ...)
}
