## Emacs: -*- coding: utf-8; fill-column: 62; comment-column: 27; -*-

###
### EXEMPLE 8.1
###

## Simulation un échantillon aléatoire d'une distribution
## exponentielle par la méthode de l'inverse.
lambda <- 5
x <- -log(runif(1000))/lambda

## Pour faire une petite vérification, on va tracer
## l'histogramme de l'échantillon et y superposer la véritable
## densité d'une exponentielle de paramètre lambda. Les deux
## graphiques devraient concorder.

## Tracé de l'histogramme. Il faut spécifier l'option 'prob =
## TRUE' pour que l'axe des ordonnées soit gradué en
## probabilités plutôt qu'en nombre de données. Sinon, le
## graphique de la densité que l'on va ajouter dans un moment
## n'apparaîtra pas sur le graphique.
hist(x, prob = TRUE) # histogramme gradué en probabilités

## Pour ajouter la densité, on a la très utile fonction
## curve() pour tracer une fonction f(x) quelconque. Avec
## l'option 'add = TRUE', le graphique est ajouté au graphique
## existant.
curve(dexp(x, rate = lambda), add = TRUE)

###
### EXEMPLE 8.4
###

## On trouvera ci-dessous une mise en oeuvre de l'algorithme
## d'acceptation-rejet pour simuler des observations d'une
## distribution Bêta(3, 2). La procédure est intrinsèquement
## itérative, alors nous devons utiliser une boucle. Il y a
## diverses manières de faire, j'ai ici utilisé une boucle
## 'repeat'; une autre mise en oeuvre est présentée dans les
## exercices.
##
## On remarque que le vecteur contenant les résultats est
## initialisé au début de la fonction pour éviter l'écueil de
## la «boîte à biscuits» expliqué à la section 4.5 du document
## de référence de la partie I.
rbeta.ar <- function(n)
{
    x <- numeric(n)        # initialisation du contenant
    g <- function(x)       # fonction enveloppante
        ifelse(x < 0.8, 2.5 * x, 10 - 10 * x)
    Ginv <- function(x)    # l'inverse de son intégrale
        ifelse(x < 0.8, sqrt(0.8 * x), 1 - sqrt(0.2 - 0.2 * x))

    i <- 0                 # initialisation du compteur
    repeat
    {
        y <- Ginv(runif(1))
        if (1.2 * g(y) * runif(1) <= dbeta(y, 3, 2))
            x[i <- i + 1] <- y # assignation et incrément
        if (i > n)
            break          # sortir de la boucle repeat
    }
    x                      # retourner x
}

## Vérification empirique pour voir si ça marche.
x <- rbeta.ar(1000)
hist(x, prob = TRUE)
curve(dbeta(x, 3, 2), add = TRUE)

###
### FONCTIONS DE SIMULATION DANS R
###

## La fonction de base pour simuler des nombres uniformes est
## 'runif'.
runif(10)                  # sur (0, 1) par défaut
runif(10, 2, 5)            # sur un autre intervalle
2 + 3 * runif(10)          # équivalent, moins lisible

## R est livré avec plusieurs générateurs de nombres
## aléatoires. On peut en changer avec la fonction 'RNGkind'.
RNGkind("Wichmann-Hill")   # générateur de Excel
runif(10)                  # rien de particulier à voir
RNGkind("default")         # retour au générateur par défaut

## La fonction 'set.seed' est très utile pour spécifier
## l'amorce d'un générateur. Si deux simulations sont
## effectuées avec la même amorce, on obtiendra exactement les
## mêmes nombres aléatoires et, donc, les mêmes résultats.
## Très utile pour répéter une simulation à l'identique.
set.seed(1)                # valeur sans importance
runif(5)                   # 5 nombres aléatoires
runif(5)                   # 5 autres nombres
set.seed(1)                # réinitialisation de l'amorce
runif(5)                   # les mêmes 5 nombres que ci-dessus

## Plutôt que de devoir utiliser la méthode de l'inverse ou un
## autre algorithme de simulation pour obtenir des nombres
## aléatoires d'une loi de probabilité non uniforme, R fournit
## des fonctions de simulation pour bon nombre de lois. Toutes
## ces fonctions sont vectorielles. Ci-dessous, P == Poisson
## et G == Gamma pour économiser sur la notation.
n <- 10                    # taille des échantillons
rbinom(n, 5, 0.3)          # Binomiale(5, 0,3)
rbinom(n, 1, 0.3)          # Bernoulli(0,3)
rnorm(n)                   # Normale(0, 1)
rnorm(n, 2, 5)             # Normale(2, 25)
rpois(n, c(2, 5))          # P(2), P(5), P(2), ..., P(5)
rgamma(n, 3, 2:11)         # G(3, 2), G(3, 3), ..., G(3, 11)
rgamma(n, 11:2, 2:11)      # G(11, 2), G(10, 3), ..., G(2, 11)

## La fonction 'sample' sert pour simuler d'une distribution
## discrète quelconque. Le premier argument est le support de
## la distribution et le second, la taille de l'échantillon
## désirée. Par défaut, l'échantillonnage se fait avec remise
## et avec des probabilités égales sur tout le support.
sample(1:49, 7)            # numéros pour le 7/49
sample(1:10, 10)           # mélange des nombres de 1 à 10

## On peut échantillonner avec remise.
sample(1:10, 10, replace = TRUE)

## On peut aussi spécifier une distribution de probabilités
## non uniforme.
x <- sample(c(0, 2, 5), 1000, replace = TRUE,
            prob = c(0.2, 0.5, 0.3))
table(x)                   # tableau de fréquences

###
### AUTRES TECHNIQUES DE SIMULATION
###

## MÉLANGES CONTINUS

## Un mélange continu de deux variables aléatoires est créé
## lorsque l'on suppose qu'un paramètre d'une distribution f
## est une réalisation d'une autre variable aléatoire avec
## densité u, comme ceci:
##
## X|Theta = theta ~ f(x|theta)
##           Theta ~ u(theta)
##
## Ce genre de modèle est fréquent en analyse bayesienne et
## souvent utilisé en actuariat. Certaines lois de probabilité
## sont aussi uniquement définies en tant que mélanges.
##
## L'intérêt, ici, est d'obtenir des observations de la
## variable aléatoire non conditionnelle X. L'algorithme de
## simulation est simple:
##
## 1. Simuler un nombre theta de la distribution de Theta.
## 2. Simuler une valeur x de la distribution de
##    X|Theta = theta.
##
## Ce qu'il importe de remarquer dans l'algorithme ci-dessus,
## c'est que le paramètre de mélange (theta) change pour
## chaque observation simulée. Autrement il n'y a juste pas de
## mélange, on obtient simplement un échantillon de la
## distribution f(x|theta).
##
## Les mélanges continus sont simples à faire en R puisque les
## fonctions de simulation sont vectorielles. Par exemple,
## simulons 1000 observations du mélange
##
## X|Theta = theta ~ Poisson(theta)
##           Theta ~ Gamma(5, 4)
theta <- rgamma(1000, 5, 4) # 1000 paramètres de mélange...
x <- rpois(1000, theta)     # ... pour 1000 Poisson différentes

## On peut écrire le tout en une seule expression.
x <- rpois(1000, rgamma(1000, 5, 4))

## On peut démontrer que la distribution non conditionnelle de
## X est une binomiale négative de paramètres 5 et 4/(4 + 1) =
## 0,8. Faisons une vérification empirique. On calcule d'abord
## le tableau de fréquences des observations de l'échantillon
## avec la fonction 'table'. Il existe une méthode de 'plot'
## pour les tableaux de fréquences.
(p <- table(x))            # tableau de fréquences
plot(p/length(x))          # graphique

## On ajoute au graphique les masses de probabilités théoriques.
(xu <- unique(x))          # valeurs distinctes de x
points(xu, dnbinom(xu, 5, 0.8), pch = 21, bg = "red3")

## MÉLANGES DISCRETS

## Le mélange discret est un cas limite du mélange continu
## lorsque la distribution de Theta est une Bernoulli de
## paramètre p, c'est-à-dire que Pr[Theta = 1] = p. Le
## résultat du mélange est une distribution avec densité de la
## forme
##
## f(x) = p f1(x) + (1 - p) f2(x),
##
## où f1 et f2 sont deux densités quelconques. Les mélanges
## discrets sont très souvent utilisés pour créer de nouvelles
## distributions aux caractéristiques particulières que l'on
## ne retrouve pas chez les distributions d'usage courant.
##
## Par exemple, le mélange suivant de deux distributions
## log-normales résulte en une fonction de densité de
## probabilité bimodale, mais ayant néanmoins une queue
## similaire à celle d'une log-normale. Graphiquement:
op <- par(mfrow = c(3, 1)) # trois graphiques superposés
curve(dlnorm(x, 3.575, 0.637),
      xlim = c(0, 250),  ylab = "f(x)",
      main = expression(paste("Log-normale(",
          mu, " = 3,575, ", sigma, " = 0,637)")))
curve(dlnorm(x, 4.555, 0.265),
      xlim = c(0, 250), ylab = "f(x)",
      main = expression(paste("Log-normale(",
          mu, " = 4,555, ", sigma, " = 0,265)")))
curve(0.554 * dlnorm(x, 3.575, 0.637) +
      0.446 * dlnorm(x, 4.555, 0.265),
      xlim = c(0, 250),  ylab = "f(x)",
      main = expression(paste("Mélange (p = 0,554)")))
par(op)                    # revenir aux paramètres par défaut

## L'algorithme de simulation d'un mélange discret est
##
## 1. Simuler un nombre u uniforme sur (0, 1).
## 2. Si u <= p, simuler un nombre de f1(x), sinon simuler de
##    f2(x).
##
## La clé pour simuler facilement d'un mélange discret en R:
## réaliser que l'ordre des observations est sans importance
## et, donc, que l'on peut simuler toutes les observations de
## la première loi, puis toutes celles de la seconde loi. La
## seule chose dont il reste à tenir compte: le nombre
## d'observations qui provient de chaque loi; pour chaque
## observation, la probabilité qu'elle provienne de la
## première loi est p.
##
## Ici, on veut simuler des observations d'un mélange discret
## de deux lois log-normales, l'une de paramètres 3,575 et
## 0,637, l'autre de paramètres 4,555 et 0,265. Le paramètre
## de mélange est p = 0,554.
n <- 1000                  # taille de l'échantillon
n1 <- rbinom(1, n, 0.554)  # quantité provenant de la loi 1
x <- c(rlnorm(n1, 3.575, 0.637),     # observations de loi 1
       rlnorm(n - n1, 4.555, 0.265)) # observations de loi 2
hist(x, prob = TRUE)                 # histogramme
curve(0.554 * dlnorm(x, 3.575, 0.637) +
      0.446 * dlnorm(x, 4.555, 0.265),
      add = TRUE, lwd = 2, col = "red3") # densité théorique

## CONVOLUTIONS

## Une convolution est la somme de deux variables aléatoires
## indépendantes. De manière générale, une convolution est
## très compliquée à évaluer, même numériquement. Certaines
## convolutions sont toutefois bien connues:
##
## 1. une somme de Bernoulli est une binomiale;
## 2. une somme de géométriques est une binomiale négative;
## 3. une somme d'exponentielles est une gamma;
## 4. une somme de Poisson est une Poisson;
## 5. une somme de normales est une normale, etc.
##
## On peut utiliser ces résultats pour simuler des
## observations de certaines lois.
##
## Par exemple, pour simuler une observation d'une
## distribution Gamma(alpha, lambda), on peut sommer alpha
## observations d'une Exponentielle(lambda). Ces dernières
## sont obtenues par la méthode de l'inverse.
alpha <- 5
lambda <- 2
- sum(log(runif(alpha)))/lambda # une observation de la gamma

## Pour simuler un échantillon de taille n de la gamma, il
## faut simuler n * alpha observations de l'exponentielle. Il
## existe des algorithmes plus efficaces pour simuler d'une
## loi gamma.
n <- 1000                  # taille de l'échantillon
x <- - rowSums(matrix(log(runif(n * alpha)),
                      nrow = n))/lambda
hist(x, prob = TRUE)       # histogramme
curve(dgamma(x, alpha, lambda),
      add = TRUE, lwd = 2, col = "red3") # densité théorique

## La simulation peut aussi servir à estimer des
## caractéristiques de la distribution d'une convolution
## difficiles à calculer explicitement. Par exemple, supposons
## que l'on a
##
## X ~ Gamma(3, 4)
## Y ~ Gamma(5, 2)
##
## et que l'on souhaite calculer le 95e centile de X + Y. Il
## n'y a pas de solution explicite pour la distribution de X +
## Y puisque les deux lois gamma n'ont pas le même paramètre
## d'échelle (lambda). Procédons donc par simulation pour
## obtenir une approximation du résultat.
x <- rgamma(10000, 3, 4)   # échantillon de la première loi
y <- rgamma(10000, 5, 2)   # échantillon de la deuxième loi
quantile(x + y, 0.95)      # 95e centile de la convolution

## Il est laissé en exercice de faire le même calcul avec Excel.
