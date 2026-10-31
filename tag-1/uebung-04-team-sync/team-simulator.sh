#!/usr/bin/env bash
# Simuliert Ihre Teamkollegin "Anna" für Übung 4 – zum Nachüben ohne echtes Team.
#
#   bash team-simulator.sh init ~/seminar            → legt ~/seminar/team-sync.git (Remote) an
#   bash team-simulator.sh mitglied <remote>         → Anna pusht ihre Mitglieder-Datei          (Teil B)
#   bash team-simulator.sh befehl   <remote>         → Anna ändert "Lieblings-Git-Befehl"         (Teil C)
#   bash team-simulator.sh branch   <remote>         → Anna pusht den Branch feature/anna-idee   (Teil D)
#   bash team-simulator.sh aufraeumen <remote>       → Anna löscht ihren Remote-Branch           (Teil D)
set -euo pipefail
HIER="$(cd "$(dirname "$0")" && pwd)"
cmd="${1:?Befehl fehlt (init|mitglied|befehl|branch|aufraeumen)}"; ziel="${2:?Ziel fehlt}"
anna() { git -c user.name="Anna Kollegin" -c user.email="anna@seminar.example" "$@"; }
TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
case "$cmd" in
  init)
    mkdir -p "$ziel"; R="$(cd "$ziel" && pwd)/team-sync.git"
    [ -e "$R" ] && { echo "Existiert bereits: $R"; exit 1; }
    git init -q --bare -b main "$R"
    cp -r "$HIER/vorlage" "$TMP/w" && cd "$TMP/w" && git init -q -b main && git add -A
    anna commit -qm "chore: Team-Sync-Repository angelegt" && git push -q "$R" main
    echo "Remote angelegt: $R"; echo "Weiter mit: cd ~/seminar && git clone $R" ;;
  mitglied|befehl|branch|aufraeumen)
    git clone -q "$ziel" "$TMP/anna" && cd "$TMP/anna"
    case "$cmd" in
      mitglied)   printf "# Anna\nRolle: Backend-Entwicklerin\nLieblings-Editor: neovim\n" > mitglieder/anna.md
                  git add mitglieder/anna.md && anna commit -qm "docs: Anna stellt sich vor" && git push -q origin main ;;
      befehl)     sed -i.bak 's/^Lieblings-Git-Befehl des Teams: .*/Lieblings-Git-Befehl des Teams: git reflog/' regeln.md && rm -f regeln.md.bak
                  anna commit -qam "docs: Annas Lieblingsbefehl eingetragen" && git push -q origin main ;;
      branch)     git switch -q -c feature/anna-idee && printf "# Idee von Anna\nWir führen Conventional Commits ein.\n" > ideen/anna.md
                  git add ideen/anna.md && anna commit -qm "docs: Idee Conventional Commits" && git push -q -u origin feature/anna-idee ;;
      aufraeumen) git push -q origin --delete feature/anna-idee ;;
    esac
    echo "Anna: '$cmd' erledigt" ;;
  *) echo "Unbekannter Befehl: $cmd"; exit 1 ;;
esac
