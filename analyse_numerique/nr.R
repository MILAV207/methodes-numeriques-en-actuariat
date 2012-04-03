nr <- function(FUN, FUNp, start, TOL = 1E-6, MAX.ITER = 100, echo = FALSE, ...)
{
    x <- start

    if (echo)
        expr <- expression(print(xt <- x))
    else
        expr <- expression(xt <- x)

    i <- 0

    repeat
    {
        eval(expr)

        x <- xt - FUN(xt, ...)/FUNp(xt, ...)

        if (abs(x - xt)/abs(xt) < TOL)
            break

        if (MAX.ITER < (i <- i + 1))
            stop('Maximum number of iterations reached without convergence')
    }
    list(root = x, nb.iter = i)
}
