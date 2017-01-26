### -*-Makefile-*- pour préparer Méthodes numériques en actuariat -
###                              Partie I Programmation en R
##
## Copyright (C) 2017 Vincent Goulet
##
## 'make pdf' (défaut) crée les fichiers .tex à partir des fichiers
## .Rnw avec Sweave, place les bonnes URL vers les vidéos dans le code
## source et compile le document maître avec XeLaTeX.
##
## 'make zip' crée les fichiers .Rout à partir des fichiers .R, puis
## les archives contenant le code source des sections d'exemples et
## les sorties.
##
## Auteur: Vincent Goulet


## Document maître, archive et fichier contenant les URL vers les
## vidéos explicatives dans la châine YouTube
MASTER = methodes_numeriques-partie_1.pdf
CODE = methodes_numeriques-partie_1-code.zip
SORTIES = methodes_numeriques-partie_1-sorties.zip
URL = URL.in

## Le document maître dépend de tous les fichiers .Rnw; de fichiers
## .tex qui n'ont pas de version .Rnw; des fichiers .R mentionnés
RNWFILES = $(wildcard *.Rnw)
TEXFILES = ../share/preamble.tex \
	frontispice.tex \
	notices.tex \
	introduction.tex \
	emacs+ess.tex \
	rstudio.tex \
	packages.tex \
	reponses.tex
RFILES = \
	presentation.R \
	bases.R \
	operateurs.R \
	fonctions.R \
	avance.R
ROUTFILES := $(RFILES:.R=.Rout)

## Liste des fichiers dans lesquels il y a des url vers des vidéos à traiter
## (liste extraite du fichier ${URL})
URLFILES = $(shell awk '/^[^\#]/ && !seen[$$1]++ { print $$1 }' ${URL})

## Outils de travail
SWEAVE = R CMD SWEAVE --encoding="utf-8"
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RBATCH = R CMD BATCH --no-timing
RM = rm -rf


.PHONY: tex pdf zip clean

pdf: $(MASTER)

tex: $(RNWFILES:.Rnw=.tex)

%.tex: %.Rnw
	$(SWEAVE) $<

%.Rout: %.R
	echo "options(error=expression(NULL))" | cat - $< > $<.tmp
	$(RBATCH) $<.tmp $@
	$(RM) $<.tmp

$(MASTER): $(MASTER:.pdf=.tex) $(RNWFILES:.Rnw=.tex) $(TEXFILES) $(RFILES)
	for file in $(filter ${URLFILES},$?); do \
	  if [ -e tmpfile.tex ]; then rm tmpfile.tex; fi ; \
	  awk -v pattern=$$file \
	      'NR==FNR && /^[^#]/ && $$1 ~ pattern \
	       { a[NR] = sprintf("youtu.be\/(%s|%s)", $$2, substr($$4,18,11)); \
	         b[NR] = sprintf("youtu.be/%s", substr($$3,18,11)); \
	         next }  \
	       NR>FNR \
	       { for (i in a) gsub(a[i], b[i]); print }' \
	    ${URL} $$file > tmpfile.tex ; \
	  mv tmpfile.tex $$file; \
	done
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

zip: $(RFILES) $(ROUTFILES)
	zip --filesync -j $(CODE) ${RFILES}
	zip --filesync -j $(SORTIES) ${ROUTFILES}

clean:
	$(RM) $(RNWFILES:.Rnw=.tex) \
	*-[0-9][0-9][0-9].eps \
	*-[0-9][0-9][0-9].pdf \
	*.aux *.log  *.blg *.bbl *.out *.rel *~ Rplots.ps
