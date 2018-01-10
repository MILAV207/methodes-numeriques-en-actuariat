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
### EXEMPLE 7.3
###

## On définit tout d'abord une petite fonction pour calculer
## les valeurs successives d'un générateur congruentiel
## linéaire général.
rand <- function(n, a, c, m, seed)
{
    x <- numeric(n + 1)
    x[1] <- seed
    for (i in seq(n))
        x[i + 1] <- (a * x[i] + c) %% m
    x[-1]
}

## On peut toujours obtenir une période maximale de m avec un
## générateur congruentiel en posant a = c = 1, mais l'aspect
## aléatoire de la suite de nombres obtenus en prend alors
## pour son rhume...
rand(17, a = 1, c = 1, m = 16, seed = 0)

## Avec un meilleur choix de multiplicateur et d'incrément, la
## période est tout aussi longue, mais la suite davantage
## aléatoire.
rand(17, a = 5, c = 1, m = 16, seed = 0)

## Un tout petit changement et la période est beaucoup plus
## courte. Même la valeur de l'amorce a une influence sur la
## période.
rand(17, a = 5, c = 4, m = 16, seed = 0)
rand(17, a = 5, c = 4, m = 16, seed = 1)
rand(17, a = 5, c = 4, m = 16, seed = 2)

## Le générateur multiplicatif de l'exemple 7.2 ne satisfait
## pas les conditions pour que la période soit maximale (7
## n'est pas une racine primitive de 31).
rand(32, a = 7, c = 0, m = 31, seed = 19)
length(unique(rand(32, a = 7, c = 0, m = 31, seed = 19)))

## Avec a = 3, on atteint la période de 30 car 3 est une
## racine primitive de 31.
length(unique(rand(32, a = 3, c = 0, m = 31, seed = 19)))

###
### EXEMPLE 7.4
###

## Un générateur avec une période de 30. Les valeurs obtenues
## semblent assez aléatoires.
(x <- rand(30, a = 3, c = 0, m = 31, seed = 19))

## Un graphique des valeurs successives ne montre pas de
## structure particulière.
par(pch = 19)
plot(x)

## Par contre, si l'on fait un graphique des paires de valeurs
## successives (c'est-à-dire x[1] en fonction de x[2], x[2] en
## fonction de x[3], etc.), un portrait dérangeant apparaît.
plot(head(x, -1), tail(x, -1))

## Augmenter la valeur du multiplicateur améliore la
## situation. Si l'on utilise plutôt a = 12 (une racine
## primitive), alors la période est toujours de 30 et donc les
## valeurs de la suite sont les mêmes que ci-dessus, dans un
## ordre différent. Cependant, les valeurs sont mieux
## distribuées.
x <- rand(30, a = 12, c = 0, m = 31, seed = 19)
plot(head(x, -1), tail(x, -1))

## On illustre par six autres graphiques comment le
## choix des paramètres d'un générateur congruentiel
## peut avoir une importance majeure sur la qualité des
## nombres générés.
par(mfrow = c(3, 2)) # 6 graphiques sur 3 lignes, 2 colonnes

x <- rand(2048, a = 65, c = 1, m = 2048, seed = 0)
plot(tail(x, -1), head(x, -1), main = "a = 65, c = 1")

x <- rand(2048, a = 1365, c = 1, m = 2048, seed = 0)
plot(tail(x, -1), head(x, -1), main = "a = 1365, c = 1")

x <- rand(2048, a = 1229, c = 1, m = 2048, seed = 0)
plot(tail(x, -1), head(x, -1), main = "a = 1229, c = 1")

x <- rand(2048, a = 157, c = 1, m = 2048, seed = 0)
plot(tail(x, -1), head(x, -1), main = "a = 157, c = 1")

x <- rand(2048, a = 45, c = 0, m = 2048, seed = 1234)
plot(tail(x, -1), head(x, -1), main = "a = 45, c = 0")

x <- rand(2048, a = 43, c = 0, m = 2048, seed = 1234)
plot(tail(x, -1), head(x, -1), main = "a = 43, c = 0")
