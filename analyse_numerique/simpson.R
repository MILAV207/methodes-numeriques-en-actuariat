simpson <- function(FUN, lower, upper, subdivisions = 1000)
{
    if (upper <= lower)
        stop("upper should be larger than lower")
    if (identical(all.equal(lower, upper), TRUE))
        return(0)

    h <- (upper - lower) / (2 * subdivisions)

    x1 <- seq(from = lower + h, to = upper - h,
              by = 2 * h)
    x2 <- head(x1, -1) + h

    h * sum(c(FUN(c(lower, upper)),
              4 * FUN(x1),
              2 * FUN(x2)))/3
}
