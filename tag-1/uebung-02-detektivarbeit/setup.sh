#!/usr/bin/env bash
# Erzeugt das Übungsrepository ./sandbox für Übung 2 (8 Commits, einer davon macht aus „Curry“ „Kurry“).
set -euo pipefail
[ -e sandbox ] && { echo "Ordner 'sandbox' existiert bereits. Zum Neustart: rm -rf sandbox"; exit 1; }
mkdir sandbox && cd sandbox && git init -q -b main
c() { # c <datum> <nachricht>
  git add -A
  GIT_AUTHOR_DATE="$1" GIT_COMMITTER_DATE="$1" git -c user.name="Kim Koch" -c user.email="kim@kantine.example" commit -qm "$2"; }
printf '# Kantinen-Rezepte\n' > README.md;                             c "2026-03-02T09:00:00" "docs: README"
printf '## Pfannkuchen\nMehl, Milch, Eier\n' > rezepte.md;             c "2026-03-03T09:00:00" "feat: Rezept Pfannkuchen"
printf '\n## Curry\nReis, Gemüse, Curry-Paste\n' >> rezepte.md;        c "2026-03-04T09:00:00" "feat: Rezept Curry"
printf '\n## Salat\nGurke, Tomate, Öl\n' >> rezepte.md;                c "2026-03-05T09:00:00" "feat: Rezept Salat"
sed -i.bak 's/^## Curry/## Kurry/; s/Curry-Paste/Kurry-Paste/' rezepte.md && rm -f rezepte.md.bak
sed -i.bak 's/^Mehl, Milch, Eier$/Mehl · Milch · Eier/' rezepte.md && rm -f rezepte.md.bak
                                                                        c "2026-03-06T09:00:00" "refactor: Formatierung"
printf '\n## Suppe\nKartoffeln, Lauch, Brühe\n' >> rezepte.md;         c "2026-03-09T09:00:00" "feat: Rezept Suppe"
printf 'Alle Rezepte für 4 Personen.\n' >> README.md;                  c "2026-03-10T09:00:00" "docs: Portionen im README"
printf '\n## Kuchen\nMehl, Zucker, Äpfel\n' >> rezepte.md;             c "2026-03-11T09:00:00" "feat: Rezept Kuchen"
echo "✅ Übungsrepository 'sandbox' mit $(git rev-list --count HEAD) Commits angelegt. Weiter: cd sandbox && git lg"
