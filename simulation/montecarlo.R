### Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-
##
## Copyright (C) 2018 Vincent Goulet
##
## Ce fichier fait partie du projet «Méthodes numériques en actuariat»
## http://github.com/vigou3/methodes-numeriques-en-actuariat
##
## Cette création est mise à disposition selon le contrat
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## http://creativecommons.org/licenses/by-sa/4.0/

###
### EXEMPLE 3.1
###

## Estimations successives de l'intégrale par la méthode Monte
## Carlo avec des échantillons de plus en plus grands.
f <- function(x) x^2.2 * exp(-x/10)
x <- runif(1e2, 2, 5)
3 * mean(f(x))
x <- runif(1e3, 2, 5)
3 * mean(f(x))
x <- runif(1e4, 2, 5)
3 * mean(f(x))
x <- runif(1e5, 2, 5)
3 * mean(f(x))
x <- runif(1e6, 2, 5)
3 * mean(f(x))

## On trace des graphiques de la vraie fonction à intégrer et
## de trois évaluations par la méthode Monte Carlo.
op <- par(mfrow = c(2, 2)) # 4 graphiques en grille 2 x 2
curve(f(x), xlim = c(2, 5), lwd = 2, main = "Vraie fonction")

x <- runif(1e2, 2, 5)
plot(x, f(x), main = "n = 100",
     pch = 21, bg = "lightblue")

x <- runif(1e3, 2, 5)
plot(x, f(x), main = "n = 1000",
     pch = 21, bg = "lightblue")

x <- runif(1e4, 2, 5)
plot(x, f(x), main = "n = 10 000",
     pch = 21, bg = "lightblue")

par(op)                    # revenir aux paramètres par défaut

###
### EXEMPLE 3.2
###

## Estimations successives de l'intégrale double par la
## méthode Monte Carlo avec des échantillons de plus en plus
## grands.
u <- runif(1e2, 0, 1.25)
v <- runif(1e2, 0, 1.25)
mean(sqrt(4 - u^2 - v^2)) * 1.25^2
u <- runif(1e3, 0, 1.25)
v <- runif(1e3, 0, 1.25)
mean(sqrt(4 - u^2 - v^2)) * 1.25^2
u <- runif(1e4, 0, 1.25)
v <- runif(1e4, 0, 1.25)
mean(sqrt(4 - u^2 - v^2)) * 1.25^2

## Graphiques de la vraie fonction et des points où celle-ci
## est évaluée avec la méthode Monte Carlo. Pour faire un
## graphique en trois dimensions, on peut utiliser la fonction
## 'persp'.
op <- par(mfrow = c(2, 2), mar = c(1, 1, 2, 1))
f <- function(x, y) sqrt(4 - x^2 - y^2)
x <- seq(0, 1.25, length = 25)
y <- seq(0, 1.25, length = 25)
persp(x, y, outer(x, y, f), main = "Vraie fonction",
      zlim = c(0, 2), theta = 120, phi = 30, col = "lightblue",
      zlab = "z", ticktype = "detailed")

## Pour faire les trois autres graphiques, nous allons d'abord
## créer des graphiques en trois dimensions vides, puis y
## ajouter des points avec la fonction 'points'. La fonction
## 'trans3d' sert à convertir les coordonnées des points dans
## la projection utilisée par 'persp'.
u <- runif(1e2, 0, 1.25)
v <- runif(1e2, 0, 1.25)
res <- persp(x, y, matrix(NA, length(x), length(y)),
             main = "n = 100",
             zlim = c(0, 2), theta = 120, phi = 30,
             zlab = "z", ticktype = "detailed")
points(trans3d(u, v, f(u, v), pm = res),
       pch = 21, bg = "lightblue")

u <- runif(1e3, 0, 1.25)
v <- runif(1e3, 0, 1.25)
res <- persp(x, y, matrix(NA, length(x), length(y)),
             main = "n = 1000",
             zlim = c(0, 2), theta = 120, phi = 30,
             zlab = "z", ticktype = "detailed")
points(trans3d(u, v, f(u, v), pm = res),
       pch = 21, bg = "lightblue")

u <- runif(1e4, 0, 1.25)
v <- runif(1e4, 0, 1.25)
res <- persp(x, y, matrix(NA, length(x), length(y)),
             main = "n = 10 000",
             zlim = c(0, 2), theta = 120, phi = 30,
             zlab = "z", ticktype = "detailed")
points(trans3d(u, v, f(u, v), pm = res),
       pch = 21, bg = "lightblue")

par(op)                    # revenir aux paramètres par défaut
