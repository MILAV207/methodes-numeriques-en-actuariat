### -*-Makefile-*- pour préparer "Méthodes numériques en actuariat
###                avec R"
##
## Copyright (C) 2018 Vincent Goulet
##
## 'make pdf' crée les fichiers .tex à partir des fichiers .Rnw avec
## Sweave et compile le document maître avec XeLaTeX.
##
## 'make zip' crée l'archive contenant le code source des sections
## d'exemples.
##
## 'make release' crée une nouvelle version dans GitHub, téléverse les
## fichiers PDF et .zip et modifie les liens de la page web.
##
## 'make all' est équivalent à 'make pdf' question d'éviter les
## publications accidentelles.
##
## Auteur: Vincent Goulet
##
## Ce fichier fait partie du projet
## "Méthodes numériques en actuariat avec R"
## https://github.com/vigou3/methodes-numeriques-en-actuariat


## Principaux fichiers
ARCHIVE = methodes-numeriques-en-actuariat.zip
PREAMBLE = share/preamble.tex
README = README.md
OTHER = LICENSE COLLABORATION-HOWTO.md

## Numéro de version extrait du préambule partagé
YEAR = $(shell grep "newcommand{\\\\year" ${PREAMBLE} \
	| cut -d } -f 2 | tr -d {)
MONTH = $(shell grep "newcommand{\\\\month"  ${PREAMBLE} \
	| cut -d } -f 2 | tr -d {)
VERSION = ${YEAR}.${MONTH}

## Dossier temporaire pour construire l'archive
TMPDIR = tmpdir

# Outils de travail
RM = rm -rf

## Dépôt GitHub et authentification
REPOSURL = https://api.github.com/repos/vigou3/methodes-numeriques-en-actuariat
OAUTHTOKEN = $(shell cat ~/.github/token)


all: pdf

.PHONY: pdf zip release create-release upload publish clean

pdf:
	${MAKE} pdf -C simulation
	${MAKE} pdf -C analyse-numerique
	${MAKE} pdf -C algebre-lineaire

release: zip create-release upload publish

zip: ${README} ${OTHER}
	if [ -d ${TMPDIR} ]; then ${RM} ${TMPDIR}; fi
	mkdir -p ${TMPDIR}/simulation \
	  ${TMPDIR}/analyse-numerique \
	  ${TMPDIR}/algebre-lineaire
	touch ${TMPDIR}/${README} && \
	  awk 'state==0 && /^# / { state=1 }; \
	       /^## Auteur/ { printf("## Édition\n\n%s\n\n", "${VERSION}") } \
	       state' ${README} >> ${TMPDIR}/${README}
	cp ${OTHER} ${TMPDIR}
	${MAKE} install -C simulation
	${MAKE} install -C analyse-numerique
	${MAKE} install -C algebre-lineaire
	cd ${TMPDIR} && zip --filesync -r ../${ARCHIVE} *
	${RM} ${TMPDIR}

create-release :
	@echo ----- Creating release on GitHub...
	@if [ -n "$(shell git status --porcelain | grep -v '^??')" ]; then \
	     echo "uncommitted changes in repository; not creating release"; exit 2; fi
	@if [ -n "$(shell git log origin/master..HEAD)" ]; then \
	    echo "unpushed commits in repository; pushing to origin"; \
	     git push; fi
	if [ -e relnotes.in ]; then rm relnotes.in; fi
	touch relnotes.in
	awk 'BEGIN { ORS = " "; print "{\"tag_name\": \"v${VERSION}\"," } \
	      /^$$/ { next } \
	      /^## Historique/ { state = 1; next } \
              (state == 1) && /^### / { \
		state = 2; \
		out = $$2; \
	        for(i = 3; i <= NF; i++) { out = out" "$$i }; \
	        printf "\"name\": \"Édition %s\", \"body\": \"", out; \
	        next } \
	      (state == 2) && /^### / { exit } \
	      state == 2 { printf "%s\\n", $$0 } \
	      END { print "\", \"draft\": false, \"prerelease\": false}" }' \
	      README.md >> relnotes.in
	curl --data @relnotes.in ${REPOSURL}/releases?access_token=${OAUTHTOKEN}
	rm relnotes.in
	@echo ----- Done creating the release

upload :
	@echo ----- Getting upload URL from GitHub...
	$(eval upload_url=$(shell curl -s ${REPOSURL}/releases/latest \
	 			  | awk -F '[ {]' '/^  \"upload_url\"/ \
	                                    { print substr($$4, 2, length) }'))
	@echo ${upload_url}
	@echo ----- Uploading PDF and archive to GitHub...
	curl -H 'Content-Type: application/zip' \
	     -H 'Authorization: token ${OAUTHTOKEN}' \
	     --upload-file ${ARCHIVE} \
             -i "${upload_url}?&name=${ARCHIVE}" -s
	@echo ----- Done uploading files

publish :
	@echo ----- Publishing the web page...
	${MAKE} -C docs
	@echo ----- Done publishing

clean:
	$(RM) $(RNWFILES:.Rnw=.tex) \
	      *-[0-9][0-9][0-9].pdf \
	      *.aux *.log  *.blg *.bbl *.out *.rel *~ Rplots.ps


