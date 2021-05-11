plotHist <- function(z, r = NULL, main = '', type = NULL, log10 = TRUE, fig.title= "Histogram", y.lab = 0.2) {
  x <- dimnames(z)[[2]]
  y <- dimnames(z)[[1]]
  n <- 20
  # Setup grid and axes
  par(mar=c(5, 5, 1, 0) + 0.1, pin = c(1,3))
  plot.new()
  plot.window(xlim = 0.5 + c(0, length(x)), ylim = 0.5 + c(0, length(y)), xaxs = 'i', yaxs = 'i')
  abline(v = (1:(length(x) - 1)) + 0.5, col = 'gray80')
  abline(h = (1:(length(y) - 1)) + 0.5, col = 'gray80')
  axis(1, at = 1:length(x), labels = x, lwd = 0, lwd.ticks = 1, las = 2, cex.axis = 0.6)
  axis(2, at = length(y):1, labels = y, lwd = 0, lwd.ticks = 1, las = 2, cex.axis = y.lab) #adjust cex.axis to inlude all y labels
  # Add heatmap
  if ( !all(is.na(z)) ) {
    idx <- is.finite(z)
    if ( log10 ) z[idx] <- log10(z[idx])
    if ( is.null(r) ) {
      r <- range(z[idx])
      z[idx] <- if ( diff(r) == 0 ) 0 else 1 + (z[idx] - r[1]) / diff(r)
    } else {
      if ( log10 ) r <- log10(r)
      z[idx] <- 1 + (z[idx] - r[1]) / diff(r)
      z[is.finite(z) & z < 1] <- 1
      z[is.finite(z) & z > 2] <- 2
    }
    z[z == -Inf] <- 0.5
    z[z ==  Inf] <- 2.5
    if ( !is.null(type) ) {
      z[idx] <- z[idx] * (1 - 2*(type[idx] == 'hypo'))
      col = c('white', colorRampPalette(c('#ccccff', '#0000ff'))(n), 'white', 'white', colorRampPalette(c('#ffb300', '#fff0cc'))(n), 'white')
      breaks = c(-3, seq(-2.0001, -0.9999, length = n + 1), 0, seq(0.9999, 2.0001, length = n + 1), 3)
    } else {
      col = c('white', colorRampPalette(c('#ff0000', '#ffdddd'))(n), 'white')
      breaks = c(0, seq(0.9999, 2.0001, length = n + 1), 3)
    }
    image(1:length(x), 1:length(y), t(z[nrow(z):1, ]), add = TRUE, col = col, breaks = breaks)
    title(main = list(fig.title, cex = 0.8,
                      font = 1))
  }
}
