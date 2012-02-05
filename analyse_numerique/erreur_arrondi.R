### ACT-21416
### Méthodes numériques en actuariat
###
### Vincent Goulet
### École d'actuariat, Université Laval
###
### Exemples d'erreurs d'arrondi du début du chapitre 4

## Opérateurs d'addition et de soustraction ne respectant pas les
## règles d'arithmétique de base.
1.2 + 1.4 + 2.8
1.2 + 1.4 + 2.8 == 5.4
2.8 + 1.2 + 1.4
2.8 + 1.2 + 1.4 == 5.4
2.6 - 1.4 - 1.2
2.6 - 1.5 - 1.1

## Division donnant parfois des résultats erronés.
0.2/0.1 == 2
(1.2 - 1.0)/0.1 == 2
0.3/0.1 == 3

## Distance plus grande entre 3,2 et 3,15 qu'entre 3,10 et 3,15.
3.2 - 3.15 > 0.05
3.15 - 3.1 < 0.05

## Valeurs inexactes dans les suites de nombres générées avec 'seq'.
( a <- seq(0.9, 0.95, by = 0.01) )
a == 0.94
( b <- c(0.90, 0.91, 0.92, 0.93, 0.94, 0.95) )
b == 0.94
a - b

## Multiplication et division qui ne sont pas des réciproques l'une de
## l'autre.
(1:10)/100
((1:10)/100) * 100
diff(((1:10)/100) * 100)
diff(((1:10)/100) * 100) == 1
