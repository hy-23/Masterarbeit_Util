# LaTeX-Vorlage zu Abschlussarbeiten am LfB

Die aktuellste Version findet sich auf dem GitLab-Server unter:
https://git.lfb.rwth-aachen.de/jacobsmuehlen/abschlussarbeit-latex

Ein Archiv der Quellen liegt auch auf dem Dokumenteserver:
- Windows: `U:\Vorlagen\LaTeX`
- Linux: `\\home\Dokumente`
- HTTP: http://dokumente/Vorlagen/LaTeX/

## Verwendung
Das Hauptdokument ist `ausarbeitung.tex`, dieses kann mit einem (LaTeX-)Editor
der Wahl bearbeitet werden und enthält in den Kapiteln Beispiele für die
meisten verwendeten Elemente.

## Titelseite
In `ausarbeitung.tex` lässt sich das Titellayout ändern:

- LfB-Titelseite *ohne* RWTH-Logo:
  `\usepackage{lfbbama}`

- LfB-Titelseite MIT RWTH-Logo (erfordert unterschriebene
  Einverständniserklärung auf dem Bogen vom ZPA)
  `\usepackage{lfbbamarwth}`

## Fehler/Änderungswünsche
Fehler/Änderungswünsche bitte als Issue im Repository einfügen (alternativ
auch gerne als Merge Request):
https://git.lfb.rwth-aachen.de/jacobsmuehlen/abschlussarbeit-latex/issues
