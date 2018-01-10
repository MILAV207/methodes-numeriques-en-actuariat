### -*-Makefile-*- pour préparer la partie "Simulation stochastique"
###                de "Méthodes numériques en actuariat"
##
## Copyright (C) 2018 Vincent Goulet
##
## 'make tex' crée les fichiers .tex à partir des fichiers .Rnw avec
## Sweave.
##
## 'make pdf' ou 'make all' compile le document maître avec XeLaTeX.
##
## 'make Rout' crée les sorties des fichiers de script R.
##
## 'make install' copie les fichiers pour la préparation de l'archive
## d'une version du projet.
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet "Méthodes numériques en actuariat"
## https://github.com/vigou3/methodes-numeriques-en-actuariat

## Nom de la partie
PARTNAME = simulation

# Nom du fichier maître
MASTER = methodes-numeriques-en-actuariat_${PARTNAME}.pdf

## Le document maître dépend de tous les fichiers .Rnw et des fichiers
## .tex et .R mentionnés.
RNWFILES = $(wildcard *.Rnw)
TEXFILES = \
	../share/preamble.tex \
	../share/couverture-avant.tex \
	notices.tex \
	../share/licence.tex \
	introduction.tex \
	rappels_transformations.tex \
	solutions.tex \
	../share/colophon.tex \
	../share/couverture-arriere.tex
SCRIPTS = \
	generation.R \
	simulation.R \
	montecarlo.R

# Outils de travail
SWEAVE = R CMD SWEAVE --encoding="utf-8"
TEXI2DVI = LATEX=xelatex texi2dvi -b
RBATCH = R CMD BATCH --no-timing
RM = rm -rf

all: pdf

.PHONY: tex pdf Rout clean

pdf: $(MASTER)

tex: $(RNWFILES:.Rnw=.tex)

Rout: $(SCRIPTS:.R=.Rout)

%.tex: %.Rnw
	$(SWEAVE) '$<'

%.Rout: %.R
	echo "options(error=expression(NULL))" | cat - $< > $<.tmp
	$(RBATCH) $<.tmp $@
	$(RM) $<.tmp

$(MASTER): $(MASTER:.pdf=.tex) $(RNWFILES:.Rnw=.tex) $(TEXFILES) $(SCRIPTS)
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

## la règle 'install' ne devrait être appelée que par ../Makefile
install: pdf Rout
	cp ${MASTER} ${SCRIPTS} ${SCRIPTS:.R=.Rout} ../${TMPDIR}/${PARTNAME}

clean:
	$(RM) $(RNWFILES:.Rnw=.tex) $(SCRIPTS:.R=.Rout) \
	*-[0-9][0-9][0-9].eps \
	*-[0-9][0-9][0-9].pdf \
	*.aux *.log *.blg *.bbl *.out *.rel *~ Rplots.ps
