#!/usr/bin/env bash
# Erzeugt ./konflikt: main und feature/perf ändern dieselbe Zeile in config.ini.
set -euo pipefail
[ -e konflikt ] && { echo "Ordner 'konflikt' existiert bereits. Zum Neustart: rm -rf konflikt"; exit 1; }
mkdir konflikt && cd konflikt && git init -q -b main
c() { git add -A; git -c user.name="Sam Server" -c user.email="sam@betrieb.example" commit -qm "$1"; }
printf 'timeout = 30\nretries = 3\nlog_level = info\n' > config.ini; c "chore: Grundkonfiguration"
git switch -q -c feature/perf
sed -i.bak 's/^timeout = 30/timeout = 10/' config.ini && rm -f config.ini.bak; c "perf: schneller abbrechen (timeout 10)"
printf 'cache = on\n' > cache.ini;                                             c "perf: Cache aktivieren"
git switch -q main
sed -i.bak 's/^timeout = 30/timeout = 60/' config.ini && rm -f config.ini.bak; c "fix: langsame Netze brauchen mehr Zeit (timeout 60)"
echo "✅ Übungsrepository 'konflikt' angelegt. Weiter: cd konflikt && git lg"
