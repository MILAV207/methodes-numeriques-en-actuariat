### -*-Makefile-*- pour préparer la page web de "Méthodes numériques
###                en actuariat avec R"
##
## Copyright (C) 2018 Vincent Goulet
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet "Méthodes numériques en actuariat
## avec R"
## https://github.com/vigou3/methodes-numeriques-en-actuariat


## Numéro de version extrait du préambule partagé
PREAMBLE = ../share/preamble.tex
YEAR = $(shell grep "newcommand{\\\\year" ${PREAMBLE} \
	| cut -d } -f 2 | tr -d {)
MONTH = $(shell grep "newcommand{\\\\month"  ${PREAMBLE} \
	| cut -d } -f 2 | tr -d {)
VERSION = ${YEAR}.${MONTH}

all: files commit

files:
	awk 'BEGIN { FS = "/"; OFS = "/" } \
	     /^## Édition/ { print; getline; print; getline; \
	                     gsub(/[0-9]{4}\.[0-9]{2}(-[0-9]*[a-z]*)?/, "${VERSION}") } \
	     1' \
	    index.md > tmpfile && \
	  mv tmpfile index.md
	cd _layouts && \
	  awk 'BEGIN { FS = "/"; OFS = "/" } \
	       /{{ site.github.releases_url }}/ { $$3 = "v${VERSION}" } 1' \
	       default.html > tmpfile && \
	  mv tmpfile default.html

commit:
	git commit index.md _layouts/default.html -m "Mise à jour de la page web pour la version ${VERSION}"
	git push


