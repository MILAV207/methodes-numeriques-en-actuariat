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
