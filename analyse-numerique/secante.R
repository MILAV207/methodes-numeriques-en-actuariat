## Copyright (C) 2018 Vincent Goulet
##
## Ce fichier fait partie du projet «Méthodes numériques en actuariat»
## http://github.com/vigou3/methodes-numeriques-en-actuariat
##
## Cette création est mise à disposition selon le contrat
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## http://creativecommons.org/licenses/by-sa/4.0/

secante <- function(FUN, start0, start1, TOL = 1E-6, MAX.ITER = 100, echo = FALSE)
{
    if (echo)
        expr <- expression(print(start1 <- x))
    else
        expr <- expression(start1 <- x)

    i <- 0

    repeat
    {
        y1 <- FUN(start1)
        x <- start1 - (y1 * (start1 - start0))/(y1 - FUN(start0))

        if (abs(x - start1)/abs(x) < TOL)
            break

        if (MAX.ITER < (i <- i + 1))
            stop('Maximum number of iterations reached without convergence')

        start0 <- start1
        eval(expr)
    }
    list(root = x, nb.iter = i)
}
