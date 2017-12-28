#' Calculate the tetris shape outlining a set of connected points.
#'
#' @param points A data.frame or matrix with two columns, named x and y
#'  respectively.
#' @return A matrix with two columns, named x and y respectively. Corresponding
#'  to the vertices points.
#' @examples
#' X <- data.frame(x = c(1, 1, 1, 2, 3),
#'                 y = c(1, 2, 3, 2, 2))
#' tetris(X)
#' @export
tetris <- function(points) {
  data <- as.matrix(points)

  # Finding starting edge
  which_y <- which(min(data[, "y"]) == data[, "y"])
  which_x <- which(min(data[which_y, "x"]) == data[which_y, "x"])
  start_point <- data[which_y[which_x], ] + c(-0.5, -0.5)

  edges <- matrix(data = 0, nrow = NROW(data) * 5, ncol = 2)
  edges[, 1:2] <- 0
  colnames(edges) <- c("x", "y")
  edges[1, ] <- start_point

  direction <- character(1000)
  direction[1] <- "right"

  for (i in 2:(NROW(edges))) {
    if(direction[i - 1] == "right") {
      if(direction_check(points, i, edges, c(0.5, -0.5))) { #go down
        direction[i] <- "down"
        edges[i, ] <- edges[i - 1, ] + c(0, -1)

      } else if(direction_check(points, i, edges, c(0.5, 0.5))) { #go right
        direction[i] <- "right"
        edges[i, ] <- edges[i - 1, ] + c(1, 0)

      } else if(direction_check(points, i, edges, c(-0.5, 0.5))) { #go up
        direction[i] <- "up"
        edges[i, ] <- edges[i - 1, ] + c(0, 1)
      }
    } else if(direction[i - 1] == "up") {
      if(direction_check(points, i, edges, c(0.5, 0.5))) { #go right
        direction[i] <- "right"
        edges[i, ] <- edges[i - 1, ] + c(1, 0)

      } else if(direction_check(points, i, edges, c(-0.5, 0.5))) { #go up
        direction[i] <- "up"
        edges[i, ] <- edges[i - 1, ] + c(0, 1)

      } else if(direction_check(points, i, edges, c(-0.5, -0.5))) { #go left
        direction[i] <- "left"
        edges[i, ] <- edges[i - 1, ] + c(-1, 0)
      }
    } else if(direction[i - 1] == "left") {
      if(direction_check(points, i, edges, c(-0.5, 0.5))) { #go up
        direction[i] <- "up"
        edges[i, ] <- edges[i - 1, ] + c(0, 1)

      } else if(direction_check(points, i, edges, c(-0.5, -0.5))) { #go left
        direction[i] <- "left"
        edges[i, ] <- edges[i - 1, ] + c(-1, 0)

      } else if(direction_check(points, i, edges, c(0.5, -0.5))) { #go down
        direction[i] <- "down"
        edges[i, ] <- edges[i - 1, ] + c(0, -1)
      }
    } else if(direction[i - 1] == "down") {
      if(direction_check(points, i, edges, c(-0.5, -0.5))) { #go left
        direction[i] <- "left"
        edges[i, ] <- edges[i - 1, ] + c(-1, 0)

      } else if(direction_check(points, i, edges, c(0.5, -0.5))) { #go down
        direction[i] <- "down"
        edges[i, ] <- edges[i - 1, ] + c(0, -1)

      } else if(direction_check(points, i, edges, c(0.5, 0.5))) { #go right
        direction[i] <- "right"
        edges[i, ] <- edges[i - 1, ] + c(1, 0)
      }
    }
    if(all(start_point == edges[i, ])) {
      edges <- edges[1:i, ]
      direction <- direction[1:i]
      break
    }
  }
  return(edges)
}
