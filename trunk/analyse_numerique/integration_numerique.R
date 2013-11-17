## Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-

###
### POLYNÔMES D'INTERPOLATION DE LAGRANGE
###

## La fonction 'poly.calc' du package 'polynom' permet de
## calculer le polynômes d'interpolation de Lagrange passant
## par un ensemble de points (x, y), où x et y sont des
## vecteurs de même longueur. Le package n'est pas livré avec
## R, il faut donc l'installer depuis CRAN, puis le charger en
## mémoire. [Décommenter la ligne ci-dessous pour installer
## (une seule fois!) le package.]
#install.packages("polynom", repos = "http://cran.ca.r-project.org")
library(polynom)

## EXEMPLE 12.1
##
## On va vérifier les calculs de cet exemple avec 'poly.calc'.
x <- c(2, 2.75, 4)                  # noeuds
(P1 <- poly.calc(x[1:2], 1/x[1:2])) # polynôme de degré 1
(P2 <- poly.calc(x, 1/x))           # polynôme de degré 2

## Pour calculer la valeur des polynômes en un point, il faut
## utiliser la fonction 'predict'.
predict(P1, 3)             # tel qu'obtenu dans l'exemple
predict(P2, 3)             # idem

###
### MÉTHODES D'INTÉGRATION NUMÉRIQUE
###

## Pas de démonstration en R des méthodes étudiées dans le
## chapitre. Il est laissé en exercice d'écrire des fonctions
## 'pointmilieu', 'trapeze', 'simpson' et 'simpson38'.
## Cependant, il y a dans R une fonction 'integrate' qui
## permet d'intégrer numériquement une fonction 'f' entre des
## bornes 'lower' et 'upper'.
integrate(sin, 0, 2)           # intégrale de sin(x)
f <- function(x) x^2 * exp(-x) # une autre fonction
integrate(f, 0, 1)             # intégrale sur [0, 1]

