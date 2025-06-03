## code to prepare `full_index_plot` dataset goes here

library(TWTE)
library(tidyverse)
library(TraMineR)

colvec <- c("#4c5760","#ff8811","#48a9a6")

as <-
  TWTE::activity_sequences %>%
  left_join(TWTE:::tw_status(), by = c("uid", "date")) %>%
  filter(tw_location %in% c("home", "office")) %>%
  select(uid, date, wfh, tw = tw_location, everything()) %>%
  mutate(tw = factor(tw, levels = c("office", "home")))

w <-
  as %>%
  left_join(weights$weights, by = "uid") %>%
  pull(weight)

create_as_bin <- function(as, weight, cat, lab, cpal = NULL) {
  as_ <-
    as %>%
    select(-uid, -date, -wfh, -tw)
  as_[as_ != cat] <- paste0("non-", cat)
  as <-
    as %>%
    select(uid, date, wfh, tw) %>%
    cbind(as_)

  act.seq <- seqdef(as, 5:148, xtstep = 6, cpal = cpal, labels = lab,
                    weights = weight)

  act.seq
}

act.lab <- c("Chores/Errands", "Leisure", "Other", "Self-care", "Sleep",
             "Travel", "Work")
act.seq <- seqdef(as, 5:148, xtstep = 6, labels = act.lab,
                  weights = NULL)  # no weights
alphabet(act.seq)  # ensure that order of alphabet aligns with labels!
asw <- create_as_bin(as, NULL, "working", c("Non-work", "Work"))
ast <- create_as_bin(as, NULL, "travel", c("Non-travel", "Travel"))

get_freq_mat <- function(act.seq, indices, fun = seqstatd) {
  data <- by(act.seq, indices, fun)
  sapply(data, function(x) x$Frequencies[2, ])
}

mat_freq_w <- get_freq_mat(asw, as$tw)
mat_freq_t <- get_freq_mat(ast, as$tw)

get_index_data <- function(act.seq, indices) {
  by(act.seq, indices, function(x) x)
}

idx_dat <- get_index_data(act.seq, as$tw)
idx_dat_w <- get_index_data(asw, as$tw)
idx_dat_t <- get_index_data(ast, as$tw)

plot_idx <- function(idx_dat, labs = list(), main = NULL, cpal = NULL, cs = 1, xl = 2.5, ...) {
  n <- length(idx_dat)
  if (!is.null(main)) {
    plot.new()
    mtext(text = main, side = 3, line = 1, cex = cs * par("cex"), ...)
    par(new = TRUE)
  }
  for (i in 1:n) {
    seqIplot(idx_dat[[i]], with.legend = FALSE, ylab = labs[i], yaxis = FALSE, xaxis = i == n,
             cpal = cpal, yaxs = "i")
    box()
  }
  mtext("Hour of the day", side = 1, line = xl, cex = cs * par("cex"))
}

plot.it <- function() {
  file <- "./vignettes/figures/full_index_plot.png"
  png(file, height = 8, width = 11, units = "in", res = 2 * 144)
  op <- par(no.readonly = TRUE)
  on.exit(par(op))
  par(mfcol = c(2, 2), mar = c(1, 2, 1, 1), oma = c(3, 2, 2, 2),  #c(5.1, 4.1, 4.1, 2.1)
      cex = 1.25)  # !
  plot_idx(idx_dat_w, labs = c("Office", "Telework"), cpal = c("grey20", colvec[2]), main = "Work")
  par(mar = c(1, 1, 1, 1))
  plot_idx(idx_dat_t, cpal = c("grey20", colvec[3]), main = "Travel")
  dev.off()
  file
}

full_index_plot <- plot.it()

usethis::use_data(full_index_plot, overwrite = TRUE)
