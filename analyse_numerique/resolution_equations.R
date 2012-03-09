## Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-

###
### MÉTHODE DE BISSECTION
###

## Fonction pour trouver la solution de 'FUN'(x) = 0 par la
## méthode de bissection, où 'FUN' est une fonction continue
## sur l'intervalle ['lower', 'upper'].
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

## Fonction pour trouver la solution de 'FUN'(x) = x par la
## méthode du point fixe à partir d'un essai initial 'start'.
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

###
### MÉTHODE DE NEWTON-RAPHSON
###

## Fonction pour trouver la solution de 'FUN'(x) = x par la
## méthode de Newton-Raphson à partir de sa dérivée 'FUNp' et
## d'un essai initial 'start'.
nr <- function(FUN, FUNp, start, TOL = 1E-6,
               MAX.ITER = 100, echo = FALSE)
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

        x <- xt - FUN(xt)/FUNp(xt)

        if (abs(x - xt)/abs(xt) < TOL)
            break

        if (MAX.ITER < (i <- i + 1))
            stop('Maximum number of iterations reached without convergence')
    }
    list(root = x, nb.iter = i)
}

## EXEMPLE 11.7
##
## On répète l'exemple 11.5 avec la méthode de Newton-Raphson.
## La convergence devrait être plus rapide qu'avec la méthode
## du point fixe parce que la fonction g(i) = i - f(i)/f'(i)
## est plus plate que celle utilisée à l'exemple 11.5.
## Premièrement, la fonction dont on cherche la racine.
f <- function(i) (1 - (1 + i)^(-10))/i - 8.2218

## Sa dérivée.
fp <- function(i) (10 * i * (1 + i)^(-11) + (1 + i)^(-10) - 1)/i^2

## Résolution avec la fonction 'nr'.
nr(f, fp, start = 0.0375, echo = TRUE)

## À noter que si la fonction g est définie adéquatement, on
## peut de manière tout aussi équivalente utiliser la fonction
## 'pointfixe' pour effectuer les itérations de la méthode de
## Newton-Raphson.
g <- function(i) i - f(i)/fp(i)
pointfixe(g, 0.0375, echo = TRUE)

## EXEMPLE 11.9
##
## Les fonctions f(x), f'(x) et g(x) définies dans le texte de
## l'exemple.
f <- function(x) ifelse(x == 2, NA, (4 * x - 7)/(x - 2))
fp <- function(x) ifelse(x == 2, NA, -1/(x - 2)^2)
g <- function(x) 4*x^2 - 14*x + 14

## On vérifie que, étant donné la forme des fonctions 'f' et
## 'g', la valeur de départ utilisée dans les méthodes de
## Newton-Raphson ou du point fixe a un impact sur la réponse
## obtenue. Avec une valeur de départ 'start' = 1,625 < 1,75,
## la convergence se fait vers la bonne racine.
nr(f, fp, 1.625, echo = TRUE)
pointfixe(g, 1.625)

## On peut vérifier sur le graphique de la fonction 'g'
## qu'avec une valeur de départ entre 1,75 et 2, la procédure
## itérative convergera aussi vers la bonne réponse.
nr(f, fp, 1.875, echo = TRUE)
pointfixe(g, 1.875, echo=TRUE)

## La tangente en x = 1,5 tracée sur le graphique de la
## fonction 'f' montre que 'start' = 1,5 constitue un mauvais
## choix car g(1,5) = 2. La procédure itérative converge donc
## vers une valeur non admissible.
nr(f, fp, 1.5)             # division par 0
pointfixe(g, 1.5)          # point fixe non admissible

## Pour toute valeur de départ supérieure à 2, la procédure
## itérative diverge. On peut vérifier ce fait dans les
## graphiques de 'f' et de 'g'.
nr(f, fp, 3, echo = TRUE)
pointfixe(g, 3, echo = TRUE)

###
### FONCTIONS D'OPTIMISATION DE R
###

## FONCTION 'uniroot'
##
## La fonction 'uniroot' recherche la racine d'une fonction
## 'f' dans un intervalle spécifié soit comme une paire de
## valeurs dans un argument 'interval', soit via des arguments
## 'lower' et 'upper'.
##
## On calcule la solution de l'équation x - 2^(-x) = 0 dans
## l'intervalle [0, 1].
f <- function(x) x - 2^(-x)      # fonction
uniroot(f, c(0, 1))              # appel simple
uniroot(f, lower = 0, upper = 1) # équivalent

## On peut aussi utiliser 'uniroot' avec une fonction anonyme.
uniroot(function(x) x - 2^(-x), lower = 0, upper = 1)

## FONCTION 'optimize'
##
## On cherche le maximum local de la densité d'une loi bêta
## dans l'intervalle (0, 1), son domaine de définition. (Ce
## problème est facile à résoudre explicitement.)
##
## Les arguments de 'optimize' sont essentiellement les mêmes
## que ceux de 'uniroot'. Ici, on utilise aussi l'argument
## '...' pour passer les paramètres de la loi bêta à 'dbeta'.
##
## Par défaut, la fonction recherche un minimum. Il faut donc
## lui indiquer de rechercher plutôt un maximum.
optimize(dbeta, interval = c(0, 1), maximum = TRUE,
         shape1 = 3, shape2 = 2)

## On pourrait aussi avoir recours à une fonction auxiliaire.
## Moins élégant et moins flexible.
f <- function(x) dbeta(x, 3, 2)
optimize(f, lower = 0, upper = 1, maximum = TRUE)

## FONCTION 'nlm'
##
## Pour la suite, nous allons donner des exemples
## d'utilisation des fonctions d'optimisation dans un contexte
## d'estimation des paramètres d'une loi gamma par la méthode
## du maximum de vraisemblance.
##
## On commence par se donner un échantillon aléatoire de la
## loi. Évidemment, pour ce faire nous devons connaître les
## paramètres de la loi. C'est un exemple fictif.
set.seed(1)                # toujours le même échantillon
x <- rgamma(10, 5, 2)

## Les estimateurs du maximum de vraisemblance des paramètres
## 'shape' et 'rate' de la loi gamma sont les valeurs qui
## maximisent la fonction de vraisemblance
##
##     prod(dgamma(x, shape, rate))
##
## ou, de manière équivalente, qui minimisent la fonction de
## log-vraisemblance négative
##
##     -sum(log(dgamma(x, shape, rate))).
##
## On remarquera au passage que les fonctions de calcul de
## densités de lois de probabilité dans R ont un argument
## 'log' qui, lorsque TRUE, retourne la valeur du logarithme
## (naturel) de la densité de manière plus précise qu'en
## prenant le logarithme après coup. Ainsi, pour faire le
## calcul ci-dessus, on optera plutôt, pour l'expression
##
##     -sum(dgamma(x, shape, rate, log = TRUE))
##
## La fonction 'nlm' suppose que la fonction à optimiser
## passée en premier argument a elle-même comme premier
## argument le vecteur 'p' des paramètres à optimiser. Le
## second argument de 'nlm' est un vecteur de valeurs de
## départ, une pour chaque paramètre.
##
## Ainsi, pour trouver les estimateurs du maximum de
## vraisemblance avec la fonction 'nlm' pour l'échantillon
## ci-dessus, on doit d'abord définir une fonction auxiliaire
## conforme aux attentes de 'nlm' pour calculer la fonction de
## log-vraisemblance (à un signe près).
f <- function(p, x) -sum(dgamma(x, p[1], p[2], log = TRUE))

## L'appel de 'nlm' est ensuite tout simple. Remarquer comment
## on passe notre échantillon aléatoire (contenu dans l'objet
## 'x') comme second argument à 'f' via l'argument '...' de
## 'nlm'. Le fait que l'argument de 'f' et l'objet contenant
## les valeurs portent le même nom est sans importance. R sait
## faire la différence entre l'un et l'autre.
nlm(f, c(1, 1), x = x)

## L'optimisation ci-dessus a généré des avertissements? C'est
## parce que la fonction d'optimisation s'est égarée dans les
## valeurs négatives, alors que les paramètres d'une gamma
## sont strictement positifs. Cela arrive souvent.
##
## On peut pallier à ce problème avec le truc suivant: plutôt
## que d'estimer les paramètres eux-mêmes, on estime leurs
## logarithmes. Ceux-ci demeurent alors valides sur tout l'axe
## des réels.
f2 <- function(logp, x)
{
    p <- exp(logp)         # retour aux paramètres originaux
    -sum(dgamma(x, p[1], p[2], log = TRUE))
}
nlm(f2, c(0, 0), x = x)

## Les valeurs obtenues ci-dessus sont toutefois les
## estimateurs des logarithmes des paramètres de la loi gamma.
## On retrouve les estiamteurs des paramètres en prenant
## l'exponentielle des réponses.
exp(nlm(f2, c(0, 0), x = x)$estimate)

## FONCTION 'nlminb'
##
## L'utilisation de la fonction 'nlminb' peut s'avérer
## intéressante dans notre contexte puisque l'on sait que les
## paramètres d'une loi gamma sont strictement positifs.
nlminb(c(1, 1), f, x = x, lower = 0, upper = Inf)

### FONCTION 'optim'
##
## La fonction 'optim' est très puissante, mais requiert aussi
## une bonne dose de prudence. Ses principaux arguments sont:
##
##  par: un vecteur contenant les valeurs initiales des
##       paramètres;
##   fn: la fonction à minimiser. Le premier argument de fn
##       doit être le vecteur des paramètres.
##
## Comme pour les autres fonctions étudiées ci-dessus, on peut
## passer des arguments à 'fn' (les données, par exemple) par
## le biais de l'argument '...' de 'optim'.
optim(c(1, 1), f, x = x)

## FONCTION 'polyroot'
##
## Racines du polynôme x^3 + 4 x^2 - 10. Les réponses sont
## données sous forme de nombre complexe. Utiliser les
## fonctions 'Re' et 'Im' pour extraire les parties réelles et
## imaginaires des nombres, respectivement.
polyroot(c(-10, 0, 4, 1))     # racines
Re(polyroot(c(-10, 0, 4, 1))) # parties réelles
Im(polyroot(c(-10, 0, 4, 1))) # parties imaginaires
