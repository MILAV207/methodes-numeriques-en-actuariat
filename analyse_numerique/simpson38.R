simpson38 <- function(FUN, lower, upper, subdivisions = 1000)
{
    if (upper <= lower)
        stop("upper should be larger than lower")
    if (identical(all.equal(lower, upper), TRUE))
        return(0)

    h <- (upper - lower) / (3 * subdivisions)

    x1 <- seq(from = lower + h, to = upper - h,
              by = 3 * h)
    x2 <- x1 + h
    x3 <- head(x2, -1) + h

    3 * h * sum(c(FUN(c(lower, upper)),
                3 * FUN(c(x1, x2)),
                2 * FUN(x3)))/8
}
