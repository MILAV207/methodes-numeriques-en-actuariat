nr <- function(FUN, FUNp, start, TOL = 1E-6, MAX.ITER = 100, echo = FALSE)
{
    if (echo)
        expr <- expression(print(start <- x))
    else
        expr <- expression(start <- x)

    i <- 0

    repeat
    {
        x <- start - FUN(start)/FUNp(start)

        if (abs(x - start)/abs(start) < TOL)
            break

        if (MAX.ITER < (i <- i + 1))
            stop('Maximum number of iterations reached without convergence')

        eval(expr)
    }
    list(root = x, nb.iter = i)
}
