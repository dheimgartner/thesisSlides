## code to prepare `te_plot` dataset goes here

library(OPSR)
library(TWTE)

x <- aggregate(wfh_days ~ wfh, data = dat, FUN = mean)$wfh_days
x[1] <- 0
tw_status <- c("NTWing", "NUTWing", "UTWing")
xlabs <- paste0(tw_status, "\n(", round(x, 2), " d/week)")
cond_exp <- opsr_te(fit, type = "unlog-response")$ce.by.groups
mat <- sapply(cond_exp, function(x) {
  apply(x, 2, mean, na.rm = TRUE)
})

te_plot <- list()

te_plot$x <- x
te_plot$xlabs <- xlabs
te_plot$mat <- mat

usethis::use_data(te_plot, overwrite = TRUE)
