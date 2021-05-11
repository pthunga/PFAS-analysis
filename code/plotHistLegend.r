plotHistLegend <- function(r, twoSided = T, n = 100, log10 = TRUE, fig.title = "Histogram Legend") {
  
  # pretty ticks
  if ( log10 ) {
    log10R <- log10(r)
    at     <- pretty(log10R)
    labels <- signif(10^at, 2)
    at     <- (at - log10R[1]) / diff(log10R)
    idx    <- at > 0.1 & at < 0.9
  } else {
    at     <- pretty(r)
    labels <- at
    at     <- (at - r[1]) / diff(r)
    idx    <- at > 0.1 & at < 0.9
  }
  
  par(mar=c(4, 0.5, 0, 0.5) + 0.1, pin = c(3,1))
  plot.new()
  plot.window(xlim = c(0, 1), ylim = c(0,1), xaxs = 'i', yaxs = 'i')
  if ( twoSided ) {
    col    <- c(colorRampPalette(c('#ccccff', '#0000ff'))(n), 'white', 'white', colorRampPalette(c('#ffb300', '#fff0cc'))(n))
    breaks <- c(seq(-2.0001, -0.9999, length = n + 1), 0, seq(0.9999, 2.0001, length = n + 1))
    x      <- c(seq(0, 0.45, length = n + 1), seq(0.55, 1, length = n + 1))
    y      <- c(0, 1)
    z      <- matrix(c(seq(-2, -1, length = n), 0, seq(1, 2, length = n)))
    image(x, y, z, col = col, breaks = breaks, add = T)
    title(main = list(fig.title, cex = 0.8,
                      font = 1))
    axis(1, at = 0.5, labels = 0)
    axis(1, at = c(0, 0.45, 0.55, 1), labels = signif(c(rev(r), r), 2), lwd = 0, lwd.ticks = 1, las = 2)
    axis(1, at = 0.45 / 2, labels = 'hypo', lwd = 0, line = 1.75)
    axis(1, at = 0.45 - at[idx] * 0.45, labels = labels[idx], lwd = 0, lwd.ticks = 1, las = 2, cex.axis = 0.9)
    axis(1, at = 0.55 + 0.45 / 2, labels = 'hyper', lwd = 0, line = 1.75)
    axis(1, at = 0.55 + at[idx] * 0.45, labels = labels[idx], lwd = 0, lwd.ticks = 1, las = 2, cex.axis = 0.9)
  } else {
    col    <- colorRampPalette(c('#ff0000', '#ffdddd'))(n)
    breaks <- seq(0.9999, 2.0001, length = n + 1)
    x      <- seq(0, 1, length = n + 1)
    y      <- c(0, 1)
    z      <- matrix(seq(1, 2, length = n))
    image(x, y, z, col = col, breaks = breaks, add = T)
    title(main = list(fig.title, cex = 0.8,
                      font = 1))
    axis(1, at = c(0, 1), labels = signif(r, 2), lwd = 0, lwd.ticks = 1, las = 2)
    axis(1, at = at[idx], labels = labels[idx], lwd = 0, lwd.ticks = 1, las = 2, cex.axis = 0.9)
  }
}
