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
### VALEURS ET VECTEURS PROPRES
###

## On va illustrer le calcul des valeurs et vecteurs propres
## dans R avec la matrice de l'exemple 14.4.
(A <- matrix(c(0, 1, 1, 0, 2, 0, -2, 1, 3), nrow = 3))

## La fonction 'eigen' calcule les valeurs propres et vecteurs
## propres d'une matrice.
(e <- eigen(A))

## Les vecteurs propres sont normalisés de sorte que leur
## norme (longueur) soit toujours égale à 1. Pour vérifier les
## résultats calculés algébriquement, comparer simplement les
## valeurs relatives des coordonnées des vecteurs.
e$values[c(1, 2)]          # deux premières valeurs propres...
e$vectors[, c(1, 2)]       # ... et vecteurs correspondants
e$vectors[, 2]             # équivalent à (1, 0, -1)
e$vectors[, 2] * sqrt(2)   # avec norme de 2 plutôt que 1

e$values[3]                # troisième valeur propre
e$vectors[, 3]             # vecteur équivalent à (-2, 1, 1)
e$vectors[, 3] * sqrt(6)   # avec norme de 6 plutôt que 1
