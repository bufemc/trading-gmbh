#!/bin/bash
# apt install pandoc texlive-latex-extra texlive-xetex texlive-fonts-extra texlive-lang-german

# Aktuelles Datum in index.md eintragen:
sed -i -e "s/^date: .*/date: $(date +%Y-%m-%d)/g" index.md

cp index.md index2.md
cp todo.md todo2.md

# Keine Links auf die einzelnen Kapitel notwendig:
sed -i -e '/^Übersicht$/,$d' index2.md

# Der letzte "title" zählt:
sed -i -e "s/^title: .*/title: Trading-GmbH/g" todo2.md

# Alle Infos in eine Datei:
cat index2.md gründung.md gmbh.md steuern.md buchungen.md todo2.md > Trading-GmbH.md
#arbeitszimmer.md

rm -f index2.md todo2.md

# Festes Leerzeichen einfügen, an dem kein Zeilenumbruch erfolgt:
sed -i -e 's/ %/\\ %/g' -e 's/ €/\\ €/g' -e 's/§ /§\\ /g' Trading-GmbH.md

#sed -i -e 's/≤/<=/g' buchungen.md

# Download eisvogel from https://github.com/Wandmalfarbe/pandoc-latex-template:
pandoc -o Trading-GmbH.pdf -f markdown -t latex --template eisvogel \
    --top-level-division=chapter --pdf-engine=xelatex Trading-GmbH.md

rm -f Trading-GmbH.md

