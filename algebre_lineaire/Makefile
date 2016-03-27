# Les cibles de cette Makefile sont: tex, pdf, zip et clean.
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
# La cible zip crée l'archive des fichiers de code source.
#
# Basé sur Makefile de Rouben Rostmaian avec ajustements de Nicholas Lewin-koh

# Document maître et archive
MASTER = methodes_numeriques-partie_4.pdf
CODE = code-partie_4.zip

# Le document maître dépend de tous les fichiers .tex et des fichiers
# .R mentionnés
RNWFILES = $(wildcard *.Rnw)
TEXFILES = $(wildcard *.tex)
RFILES   = revision_algebre_lineaire.R valeurs_propres.R

# Outils de travail
SWEAVE = R CMD SWEAVE --encoding="utf-8"
TEXI2DVI = LATEX=xelatex texi2dvi -b
RM = rm -rf

.PHONY: tex pdf zip clean

pdf: $(MASTER)
tex: $(RNWFILES:.Rnw=.tex)

%.tex: %.Rnw
	$(SWEAVE) '$<'
	sed -i "" \
	    -e "s:youtu.be/google:youtu.be/VM4IRctyjOk:" \
	    valeurs_propres.tex

$(MASTER): $(RNWFILES) $(TEXFILES)
	$(TEXI2DVI) $(MASTER:.pdf=.tex)

zip: $(RFILES)
	zip --filesync -j $(CODE) ${RFILES}

clean:
	$(RM) $(RNWFILES:.Rnw=.tex) \
	*-[0-9][0-9][0-9].eps \
	*-[0-9][0-9][0-9].pdf \
	*.aux *.log  *.blg *.bbl *.out *.rel *~ Rplots.ps
