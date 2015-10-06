#' Contour w/ Labels
#'
#' geom_contour() + labels
#'
#' @name labeled_contour
#' @param digits this parameter is passed to \code{signif()}, but usually this doesn't matter since
#' the levels of contours are rounded already
#' @seealso The arguments are the same as \link[ggplot2]{geom_contour}, except for \code{digits}
#'
#' @examples
#' library(ggplot2)
#' N <- 60
#' x <- seq(0, 100, length=N)
#' d.cont <- data.frame(x=rep(x,N), y=rep(x,each=N))
#' d.cont <- transform(d.cont, z.diff = x-y)
#'
#' ggplot(d.cont, aes(x, y, z = z.diff)) +
#'   geom_contour() +
#'   geom_contour_label()
#'
#' # shortcut
#' ggplot(d.cont, aes(x, y, z = z.diff)) +
#'   geom_labeled_contour()
#'
#' @format NULL
#' @export
StatContourLabel <- ggplot2::ggproto(
  "StatContourLabel",
  ggplot2::Stat,
  default_aes = aes(label = ..level..),
  compute_group = function(..., digits = 3) {
    ggplot2::StatContour$compute_group(...) %>%
      dplyr::group_by(level) %>%
      dplyr::summarise(x = nth(x, round(n() / 2)),
                       y = nth(y, round(n() / 2))) %>%
      dplyr::mutate(level = signif(level, digits = digits))
  }
)

#' @rdname labeled_contour
#' @export
geom_contour_label <- function(mapping = NULL, data = NULL,
                               position = "identity", na.rm = FALSE, show.legend = NA,
                               inherit.aes = TRUE, digits = 3, ...) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = StatContourLabel,
    geom = "text",
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm  = na.rm,
      digits = digits,
      ...
    )
  )
}

#' @rdname labeled_contour
#' @export
geom_labeled_contour <-
  function(mapping = NULL, data = NULL, stat = "contour", position = "identity",
           lineend = "butt", linejoin = "round", linemitre = 1, na.rm = FALSE,
           show.legend = NA, inherit.aes = TRUE, digits = 3, ...) {
    list(
      ggplot2::geom_contour(
        mapping, data, stat, position,
        lineend, linejoin, linemitre, na.rm,
        show.legend, inherit.aes, ...
      ),
      geom_contour_label(
        mapping, data,
        position, na.rm, show.legend,
        inherit.aes, digits, ...
      )
    )
  }
