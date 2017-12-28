#' Tetris colors
#'
#' Returns a vector of colors that match the colors of the Tetromino pieces
#' in a range of different Tetris editions. See
#' \url{https://en.wikipedia.org/wiki/Tetris#Tetromino_colors}
#' for more information of names and color. Name of color palettes are
#' "Vadim Gerasimov", "Microsoft", "Sega", "The New Tetris",
#' "The Tetris Company", "Atari", "The Soviet Mind Game", "Tetris DX",
#' "Super Tetris 3", "Tetris Plus" and "The Next Tetris". Defaults to
#' "Vadim Gerasimov". Will pad with white if after 7 colors are used.
#'
#' @param palette Character. Name of color scale. Pick between "Vadim Gerasimov",
#'     "Microsoft", "Sega", "The New Tetris", "The Tetris Company", "Atari",
#'     "The Soviet Mind Game", "Tetris DX", "Super Tetris 3", "Tetris Plus"
#'     and "The Next Tetris". Defaults to "Vadim Gerasimov".
#' @param n Integer. Number of colors. Maximum of 7 available. Defaults to 7.
#' @return Numerical.
#' @examples
#' tetris_color(7)
#' tetris_color("Microsoft", n = 4)
#' @export
tetris_color <- function(palette = "Vadim Gerasimov", n = 7) {
  if(n > 7) {
    stop("Only 7 colors available, please pick another scale.")
  }
  tetris_colors[palette, 1:n]
}
