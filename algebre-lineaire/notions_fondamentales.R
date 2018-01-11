### Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-
##
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

###
### MATRICES ET VECTEURS
###

## La fonction 'diag' a plusieurs usages. Un premier consiste
## à extraire la diagonale d'une matrice carrée.
(a <- matrix(1:9, nrow = 3))
diag(a)

## Si la matrice passée en argument est rectangulaire 'm x n',
## 'diag' retourne la liste des éléments a[i, i], i = 1, ...,
## min(m, n).
(a <- matrix(1:12, nrow = 4))
diag(a)

## Lorsque l'on passe un vecteur à la fonction 'diag', le
## résultat est une matrice diagonale formée du vecteur.
diag(1:3)

## Enfin, lorsque l'argument de 'diag' est un scalaire 'n', le
## résultat est la matrice identité 'n x n'.
diag(3)

## La fonction 'lower.tri' (respectivement 'upper.tri')
## retourne une matrice de la même dimension que celle passée
## en argument avec des valeurs TRUE (FALSE) aux positions des
## éléments sous la diagonale et FALSE (TRUE) aux positions
## au-dessus de la diagonale. La diagonale sera dans le
## premier ou dans le second groupe selon que l'argument
## 'diag' est TRUE ou FALSE.
(a <- matrix(1:9, nrow = 3))
lower.tri(a)
upper.tri(a, diag = TRUE)

## On utilise les fonctions 'lower.tri' et 'upper.tri'
## principalement pour extraire les éléments au-dessus ou
## au-dessous de la diagonale d'une matrice carrée.
a[lower.tri(a)]
a[upper.tri(a)]

## Bien que rarement nécessaires en R, on peut créer des
## vecteurs ligne ou colonne avec les fonctions 'rbind' et
## 'cbind', dans l'ordre.
rbind(1:3)
dim(rbind(1:3))
cbind(1:3)

###
### ARITHMÉTIQUE MATRICIELLE
###

## Le produit matriciel s'effectue en R avec l'opérateur
## '%*%', et non avec '*', qui fait le produit élément par
## élément (une opération qui n'est pas définie en
## arithmétique matricielle usuelle, mais qui l'est dans R).
(a1 <- matrix(c(1, 2, 2, 6, 4, 0), nrow = 2))
(a2 <- matrix(c(4, 0, 2, 1, -1, 7, 4, 3, 5, 3, 1, 2), nrow = 3))
a1 %*% a2

## Il n'y a pas d'opérateur pour calculer la trace d'une
## matrice carrée. Il suffit de sommer les éléments de la
## diagonale.
a
sum(diag(a))

## La transposée est obtenue avec la fonction 't'.
t(a)

###
### DÉTERMINANT ET INVERSE
###

## Le déterminant d'une matrice est obtenu avec la fonction
## 'det'.
A <- matrix(c(1, 2, 1, 2, 5, 0, 3, 3, 8), nrow = 3)
det(A)

## Avec pour seul argument une matrice carrée, la fonction
## 'solve' calcule l'inverse de cette matrice.
solve(A)

## Avec deux arguments, une matrice 'A' et un vecteur 'b',
## 'solve' calcule la solution du système d'équations 'Ax =
## b', c'est-à-dire 'A^{-1} b'.
b <- 1:3
solve(A, b)

## À noter qu'il est *beaucoup* plus rapide de calculer
## directement la solution du système d'équations avec
## 'solve(A, b)' que d'inverser la matrice et calculer la
## solution par la suite avec 'solve(A) %*% b'. Pour en faire
## la démonstration, on doit utiliser de grands objets.
A <- matrix(rnorm(500^2), nrow = 500)
b <- rnorm(500)
system.time(solve(A) %*% b)
system.time(solve(A, b))
