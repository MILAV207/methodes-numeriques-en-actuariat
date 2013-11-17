trapeze <- function(FUN, lower, upper, subdivisions = 1000)
{
    if (upper <= lower)
        stop("upper should be larger than lower")
    if (identical(all.equal(lower, upper), TRUE))
        return(0)

    h <- (upper - lower) / subdivisions

    x <- seq(from = lower + h, to = upper - h,
             length.out = subdivisions - 1)

    h * sum(c(FUN(c(lower, upper)), 2 * FUN(x)))/2
}
