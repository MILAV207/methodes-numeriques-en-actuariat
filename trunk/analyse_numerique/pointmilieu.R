pointmilieu <- function(FUN, lower, upper, subdivisions = 1000)
{
    if (upper <= lower)
        stop("upper should be larger than lower")
    if (identical(all.equal(lower, upper), TRUE))
        return(0)

    h <- (upper - lower) / (2 * subdivisions)

    x <- seq(from = lower + h, to = upper - h,
             by = 2 * h)

    2 * h * sum(FUN(x))
}
