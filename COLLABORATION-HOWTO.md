<!-- Emacs: -*- coding: utf-8; eval: (auto-fill-mode -1); eval: (visual-line-mode t) -*- -->

# Collaborer au projet *Méthodes numériques en actuariat avec R*

> Seuls les étudiants de l'Université Laval inscrits au cours ACT-2002 disposent des droits en écriture requis pour effectuer la procédure décrite ci-dessous.

La version de développement du projet [Méthodes numériques en actuariat avec R](https://vigou3.github.io/methodes-numeriques-en-actuariat) est hébergée dans un [dépôt Git public](https://projets.fsg.ulaval.ca/git/scm/vg/methodes-numeriques-en-actuariat-develop) de la Faculté des sciences et de génie de l'Université Laval.

Le dépôt utilise l'interface [Atlassian BitBucket Server](https://www.atlassian.com/software/bitbucket/server).

La branche `master` du dépôt est réservée en écriture au gestionnaire du projet.

Pour collaborer au projet, vous devez publier vos modifications dans une nouvelle branche et effectuer une demande de tirage (*pull request*) vers la branche `master`. La procédure à suivre à partir d'une invite de commande (Git Bash sous Windows ou Terminal sous macOS) est la suivante.

1. Si  vous travaillez sur le code source pour la première fois, déplacez-vous (avec la commande `cd` à la ligne de commande) dans le répertoire dans lequel vous voulez enregistrer le code source du projet (le répertoire `methodes-numeriques-en-actuariat-develop` sera créé automatiquement), clonez le dépôt et déplacez-vous ensuite dans le dossier du code source:

```
git clone https://projets.fsg.ulaval.ca/git/scm/vg/methodes-numeriques-en-actuariat-develop.git
cd methodes-numeriques-en-actuariat-develop
```

**OU**

1. Si vous avez déjà cloné le dépôt dans le passé et que vous voulez reprendre le travail sur le code source, déplacez-vous (avec la commande `cd` à la ligne de commande) dans le répertoire du code source, puis mettez à jour votre copie locale du dépôt depuis la branche `master`:

```
git checkout master
git pull
```

2. Créez une branche (locale) pour vos modifications:

```
git checkout -b <nom_de_branche>
```
	
3. Effectuez maintenant vos modifications. Il y a un fichier par chapitre et son nom, avec une extension `.tex` ou `.Rnw`, a un lien évident avec le titre du chapitre. Le code de la section d'exemples du chapitre se trouve dans un fichier du même nom avec une extension `.R`. On ne fait des modifications que dans un seul fichier à la fois! Une fois les modifications terminées, publiez le fichier modifié dans votre dépôt local avec un commentaire utile, mais bref, sur la nature des modifications:
    
```
git status
git add <fichier>
git commit -m "<commentaire>"
```
	
4. Publiez ensuite la branche avec les modifications dans le dépôt BitBucket:

```
git push -u origin <nom_de_branche>
```
	
5. Finalement, connectez-vous à l'interface graphique de BitBucket à l'adresse <https://projets.fsg.ulaval.ca/git/login> avec votre IDUL/NIP et faites une demande de tirage (*pull request*) vers la branche `master` en sélectionnant l'option correspondante dans la barre latérale.

Pour des instructions plus détaillées, consultez les [excellents tutoriels](https://www.atlassian.com/git/tutorials) de Atlassian, en particulier celui sur le processus de collaboration [*Gitflow Workflow*](https://www.atlassian.com/git/tutorials/comparing-workflows#gitflow-workflow).
