## Copyright (C) 2018 Vincent Goulet
##
## Ce fichier fait partie du projet «Méthodes numériques en actuariat»
## http://github.com/vigou3/methodes-numeriques-en-actuariat
##
## Cette création est mise à disposition selon le contrat
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## http://creativecommons.org/licenses/by-sa/4.0/

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
