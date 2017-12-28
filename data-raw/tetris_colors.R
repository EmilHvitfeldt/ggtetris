library(rvest)
library(tidyverse)
library(ehlib) #EmilHvitfeldt/ehlib

first <- read_html("https://en.wikipedia.org/wiki/Tetris")

second <- first %>%
  html_nodes('table[class="wikitable"]') %>%
  html_nodes("tr") %>%
  .[-1]

third <- second %>%
  map(~ .x %>%
    html_nodes("td") %>%
    .[-1] %>%
    as.character() %>%
    str_between("background-color:", "; color:") %>%
    tibble()
  ) %>%
  bind_cols() %>%
  as.matrix()

names <- c("Vadim Gerasimov", "Microsoft", "Sega", "The New Tetris",
           "The Tetris Company", "Atari", "The Soviet Mind Game", "Tetris DX",
           "Super Tetris 3", "Tetris Plus", "The Next Tetris")

rownames(third) <- names
colnames(third) <- NULL


third %>% as.character() %>% unique()

RBG <- dplyr::case_when(third == "red" ~ "#FA1100",
                        third == "cyan" ~ "#3EFEFF",
                        third == "blue" ~ "#0000FF",
                        third == "magenta" ~ "#F900FF",
                        third == "yellow" ~ "#FFFF01",
                        third == "orange" ~ "#FCA503",
                        third == "lime" ~ "#3FFF00",
                        third == "gray" ~ "#808080",
                        third == "green" ~ "#3FFF00",
                        third == "olive" ~ "#808001",
                        third == "#ff8000" ~ "#FF8000",
                        third == "#ffc000" ~ "#FFC000",
                        TRUE ~ third)

tetris_colors <- matrix(RBG, nrow = dim(third)[1], ncol = dim(third)[2])

rownames(tetris_colors) <- rownames(third)
