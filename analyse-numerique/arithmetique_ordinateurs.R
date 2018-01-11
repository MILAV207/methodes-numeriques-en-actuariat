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
### EXEMPLES DE CALCULS EN APPARENCE ERRONÉS
###

## Opérateurs d'addition et de soustraction ne respectant pas les
## règles d'arithmétique de base.
1.2 + 1.4 + 2.8            # 5.4
1.2 + 1.4 + 2.8 == 5.4     # non?!?
2.8 + 1.2 + 1.4            # encore 5.4
2.8 + 1.2 + 1.4 == 5.4     # donc addition non commutative?
2.6 - 1.4 - 1.2            # devrait donner 0
2.6 - 1.5 - 1.1            # correct cette fois-ci

## Division donnant parfois des résultats erronés.
0.2/0.1 == 2               # ok
(1.2 - 1.0)/0.1 == 2       # pourtant équivalent
0.3/0.1 == 3               # fonctionnait pourtant avec 0.2

## Distance plus grande entre 3,2 et 3,15 qu'entre 3,10 et
## 3,15.
3.2 - 3.15 > 0.05          # écart supérieur à 0,05...
3.15 - 3.1 < 0.05          # et cette fois inférieur à 0,05

## Valeurs inexactes dans les suites de nombres générées avec
## 'seq', qui sont générées algébriquement (par additions ou
## soustractions successives).
(a <- seq(0.9, 0.95, by = 0.01))
a == 0.94                  # 0.94 n'est pas dans le vecteur!
(b <- c(0.90, 0.91, 0.92, 0.93, 0.94, 0.95))
b == 0.94                  # mais ici, oui!
a - b                      # remarquer le 5e élément

###
### CONVERSION DANS DES BASES GÉNÉRALES
###

## La fonction 'arrayInd', dont la syntaxe (simplifiée) est
##
##     arrayInd(ind, dim)
##
## retourne les coordonnées des éléments aux positions 'ind'
## dans un tableau de dimensions 'dim'. Par exemple, le 14e
## élément d'une matrice 4 x 5 remplie par colonne (ordre R)
## est en position (2, 4).
arrayInd(14, c(4, 5))      # comparer avec l'exemple 10.7

## C'est toujours un peu plus compliqué avec les tableaux. Par
## exemple, un tableau 3 x 4 x 5 doit être vu comme cinq
## matrices 3 x 4 placées les unes derrière les autres. Où se
## trouve le 'i'ème élément?
arrayInd(8, 3:5)            # élément (2, 3) de 1ère matrice
arrayInd(13, 3:5)           # élément (1, 1) de 2e matrice
arrayInd(59, 3:5)           # élément (2, 4) de 5e matrice
arrayInd(c(8, 13, 59), 3:5) # en un seul appel
