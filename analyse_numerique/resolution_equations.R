## Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-

###
### MÉTHODE DE BISSECTION
###

## Fonction pour trouver la solution de FUN(x) = 0 par la
## méthode de bissection, où FUN est une fonction continue sur
## l'intervalle [lower, upper].
bissection <- function(FUN, lower, upper, TOL = 1E-6,
                       MAX.ITER = 100, echo = FALSE)
{
    ## Cas triviaux où une borne est la solution
    if (identical(FUN(lower), 0))
        return(lower)
    if (identical(FUN(upper), 0))
        return(upper)

    ## Bornes de départ inadéquates
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

## EXEMPLE 11.3
##
## La fonction dont on cherche la racine
f <- function(x) x^3 + 4*x^2 - 10

## Un graphique de la fonction permet de vérifier qu'elle ne
## possède qu'une seule racine sur un intervalle donné ainsi
## que des valeurs de départ pour l'algorithme.
curve(f(x), xlim = c(0, 3), lwd = 2) # graphique sur [0, 3]
abline(h = 0)                        # axe des abscisses

## Résolution. Nous utilisons a = 1 et b = 2 comme valeurs de
## départ. Nous pourrions choisir des valeurs de départ plus
## près de la racine, ce qui accélèrerait la résolution.
bissection(f, lower = 1, upper = 2, TOL = 1E-5, echo = TRUE)

## EXEMPLE 11.4
##
## La fonction dont on cherche la racine
f <- function(x) (1 - (1 + x)^(-10))/x - 8.2218

## Graphique de la fonction sur un intervalle "raisonnable"
## dans lequel on peut pressentir que se trouvera la réponse.
## Ici, on y va pour un taux d'intérêt se trouvant entre 1 %
## et 10 %.
curve(f(x), xlim = c(0.01, 0.10), lwd = 2)
abline(h = 0)

## Le graphique permet de déterminer à l'oeil que la racine se
## trouve entre 3 % et 4 %. Résolution avec la fonction
## 'bissection'.
bissection(f, lower = 0.03, upper = 0.04)

###
### MÉTHODE DU POINT FIXE
###

## Fonction pour trouver la solution de FUN(x) = x par la
## méthode du point fixe à partir d'un essai initial start.
pointfixe <- function(FUN, start, TOL = 1E-6, MAX.ITER = 100,
                      echo = FALSE)
{
    x <- start

    if (echo)
        expr <- expression(print(xt <- x))
    else
        expr <- expression(xt <- x)

    i <- 0

    repeat
    {
        eval(expr)

        x <- FUN(xt)

        if (abs(x - xt)/abs(x) < TOL)
            break

        if (MAX.ITER < (i <- i + 1))
            stop('Maximum number of iterations reached without convergence')
    }
    list(fixed.point = x, nb.iter = i)
}

## EXEMPLE 11.5
##
## La fonction dont on cherche le point fixe.
g <- function(x) (1 - (1 + x)^(-10))/8.2218

## Un graphique de la fonction permet de vérifier que les
## conditions pour qu'il existe un point fixe unique dans
## l'intervalle [0,035, 0,040] sont satisfaites. Cependant, la
## forme de la courbe (pente près de 1) nous indique que la
## convergence sera relativement lente.
f <- function(x) x         # pour tracer la droite y = x
lim <- c(0.035, 0.040)     # intervalle [a, b]
curve(g, xlim = lim, ylim = lim, lwd = 2,
      xlab = "i", ylab = "g(i)")
curve(f, add = TRUE)
polygon(rep(lim, each = 2), c(lim, rev(lim)),
        lty = "dashed", border = "blue")

## Résolution avec la fonction 'pointfixe'.
pointfixe(g, start = 0.0375, echo = TRUE)

## EXEMPLE 11.6
##
## On cherche la racine de f(x) = x^3 + 4 * x^2 - 10 en
## exprimant le problème sous forme de point fixe. Les cinq
## fonctions ci-dessous sont toutes algébriquement
## équivalentes, c'est-à-dire que g(x) = x lorsque f(x) = 0.
g1 <- function(x) x - x^3 - 4 * x^2 + 10
g2 <- function(x) sqrt(10/x - 4*x)
g3 <- function(x) sqrt(10 - x^3)/2
g4 <- function(x) sqrt(10/(4 + x))
g5 <- function(x) x - (x^3 + 4*x^2 - 10)/(3*x^2 + 8*x)

## Si les fonctions sont algébriquement équivalentes, elles ne
## le sont pas numériquement devant la méthode du point fixe.
## Ainsi, avec la fonction 'g1', la procédure diverge.
## (Remarque: la fonction 'poinfixe' ne prévoit pas de message
## d'erreur pour ce cas. Qu'ajouteriez-vous à la fonction?)
pointfixe(g1, 1.5)
pointfixe(g1, 1.5, echo = TRUE) # plus évident ainsi

## Avec la fonction 'g2', la procédure s'arrête lorsqu'il faut
## calculer la racine carrée d'un nombre négatif.
pointfixe(g2, 1.5)

## Avec les trois autres fonctions, la méthode du point fixe
## est extrêmement rapide et précise. Une rapide analyse des
## graphiques fournis dans les notes de cours nous aurait
## permis de déterminer avec quelle fonction la convergence
## serait la plus rapide. En effet, c'est la fonction 'g5' qui
## a la pente la plus faible près de son point fixe.
pointfixe(g3, 1.5)
pointfixe(g4, 1.5)
pointfixe(g5, 1.5)
