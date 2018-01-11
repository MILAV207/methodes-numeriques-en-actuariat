## Copyright (C) 2018 Vincent Goulet
##
## Ce fichier fait partie du projet
## «Méthodes numériques en actuariat avec R»
## http://github.com/vigou3/methodes-numeriques-en-actuariat
##
## Cette création est mise à disposition selon le contrat
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## http://creativecommons.org/licenses/by-sa/4.0/

bissection <- function(FUN, lower, upper, TOL = 1E-6, MAX.ITER = 100, echo = FALSE)
{
    if (identical(FUN(lower), 0))
        return(lower)
    if (identical(FUN(upper), 0))
        return(upper)
    if (FUN(lower) * FUN(upper) > 0)
        stop('FUN(lower) and FUN(upper) must be of opposite signs')

    x <- lower
    i <- 1

    repeat
    {
        xt <- x
        x <- (lower + upper)/2
        fx <- FUN(x)

        if (echo)
            print(c(lower, upper, x, fx))

        if (abs(x - xt)/abs(x) < TOL)
            break

        if (MAX.ITER < (i <- i + 1))
            stop('Maximum number of iterations reached without convergence')

        if (FUN(lower) * fx > 0)
            lower <- x
        else
            upper <- x
    }
    list(root = x, nb.iter = i)
}
