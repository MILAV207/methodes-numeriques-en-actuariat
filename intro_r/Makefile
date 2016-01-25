# Les cibles de cette Makefile sont: tex, links, pdf, zip et clean.
#
# La cible par défaut est "pdf".
#
# Pour créer les fichiers .tex à partir des fichiers .Rnw, faire "make
# tex". Cela va également placer les bonnes URL des capsules vidéo
# dans le code source.
#
# Pour compiler le fichier PDF avec texi2dvi, faire "make pdf" ou
# seulement "make".
#
# La cible zip crée les fichiers .Rout à partir des fichiers .R et
# crée les archives des fichiers de code source et des fichiers de
# sortie.
#
# Basé sur Makefile de Rouben Rostmaian avec ajustements de Nicholas Lewin-koh

# Correspondances url des capsules sur YouTube.
#
#  TITRE ABRÉGÉ  	  CHAPITRE	ACT-2002			INTRO R
#  Présentation		  presentation	https://youtu.be/fs0LHQ7sDpI	https://youtu.be/PSQIKSKw_ys
#  Indiçage		  bases		https://youtu.be/sMd1IyTg-ic	https://youtu.be/cQUjdwgTyz4
#  Fonction order	  operateurs	https://youtu.be/pPLxbuEZmkA	https://youtu.be/uC-zkzwsCVY
#  Fonction outer	  operateurs	https://youtu.be/Ht04UiHnU_0	https://youtu.be/cyPUAnieWHw
#  Fonction apply	  avance	https://youtu.be/EN-a8bTefNk	https://youtu.be/8UQN6RRnsFA
#  Anatomie		  emacs+ess	https://youtu.be/xiNnHegDau8	https://youtu.be/KtmFDm2AKM4
#  Fichiers configuration emacs+ess	https://youtu.be/IsyQn7d2Ao0	https://youtu.be/jdtjBBkfhO0
#  Installation packages  packages	https://youtu.be/DL48oi2RKjM	https://youtu.be/mL6iNzjHMKE

# Document maître et archives
MASTER = methodes_numeriques-partie_1.pdf
CODE = code-partie_1.zip
SORTIES = code-partie_1-sorties.zip

# Le document maître dépend de tous les fichiers .tex et des fichiers
# .R mentionnés
RNWFILES = $(wildcard *.Rnw)
TEXFILES = $(wildcard *.tex)
RFILES   = presentation.R bases.R operateurs.R fonctions.R avance.R
ROUTFILES := $(RFILES:.R=.Rout)

# Outils de travail
SWEAVE = R CMD SWEAVE --encoding="utf-8"
TEXI2DVI = LATEX=xelatex TEXINDY=makeindex texi2dvi -b
RBATCH = R CMD BATCH --no-timing
RM = rm -rf


.PHONY: tex pdf zip clean

pdf: $(MASTER)
tex: $(RNWFILES:.Rnw=.tex)

%.tex: %.Rnw
	$(SWEAVE) '$<'
	sed -i ""                           \
	    -e "/^\\\\item L'\\\\autoref/s/^/%/" \
	    -e "/^  stratégies ---/s/^/%/"  \
	    -e "/^  --- pour la/s/^/%/"  \
	    avance.tex
	sed -E -i "" \
	    -e "s:youtu.be/(presentation|PSQIKSKw_ys):youtu.be/fs0LHQ7sDpI:" \
	    presentation.tex
	sed -E -i "" \
	    -e "s:youtu.be/(indicage|cQUjdwgTyz4):youtu.be/sMd1IyTg-ic:" \
	    bases.tex
	sed -E -i "" \
	    -e "s:youtu.be/(order|uC-zkzwsCVY):youtu.be/pPLxbuEZmkA:" \
	    -e "s:youtu.be/(outer|cyPUAnieWHw):youtu.be/Ht04UiHnU_0:" \
	    operateurs.tex
	sed -E -i "" \
	    -e "s:youtu.be/(apply|8UQN6RRnsFA):youtu.be/EN-a8bTefNk:" \
	    avance.tex
	sed -E -i "" \
	    -e "s:youtu.be/(anatomie|KtmFDm2AKM4):youtu.be/xiNnHegDau8:" \
	    -e "s:youtu.be/(configuration|jdtjBBkfhO0):youtu.be/IsyQn7d2Ao0:" \
	    emacs+ess.tex
	sed -E -i "" \
	    -e "s:youtu.be/(packages|mL6iNzjHMKE):youtu.be/DL48oi2RKjM:" \
	    packages.tex

$(MASTER): $(RNWFILES) $(RFILES) $(TEXFILES)
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

%.Rout: %.R
	echo "options(error=expression(NULL))" | cat - $< > $<.tmp
	$(RBATCH) $<.tmp $@
	$(RM) $<.tmp

zip: $(RFILES) $(ROUTFILES)
	zip -j $(CODE) ${RFILES}
	zip -j $(SORTIES) ${ROUTFILES}

clean:
	$(RM) $(RNWFILES:.Rnw=.tex) \
	*-[0-9][0-9][0-9].eps \
	*-[0-9][0-9][0-9].pdf \
	*.aux *.log  *.blg *.bbl *.out *.rel *~ Rplots.ps
