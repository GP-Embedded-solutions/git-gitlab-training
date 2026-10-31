# FAQ & Troubleshooting

## Container & Einrichtung
**`seminar-check` meldet ❌ bei SSH.**
`Permission denied (publickey)`: öffentlichen Schlüssel (`cat ~/.ssh/id_ed25519.pub`) vollständig auf gitlab.com hinterlegen. Mit Passphrase: einmal `ssh-add`. Keine Verbindung: Port 22 gesperrt → `seminar-einrichten` erneut, es nutzt dann Port 443.

**`$GRUPPE` ist leer.** `seminar-einrichten` ausführen und ein neues Terminal öffnen (oder `source ~/.seminar-env`).

**„Permission denied“ beim Schreiben unter `$SEMINAR`.** Die Unterlagen sind nur lesbar. Gearbeitet wird in `~/seminar`. Kopieren: `cp -r $SEMINAR/starter/calc-service ~/seminar/`

## Git lokal
**Ich stehe im „detached HEAD“.** Meist nach `git bisect` oder `git switch <sha>`. Zurück: `git bisect reset` bzw. `git switch main`. Neue Commits retten: `git switch -c rettung`.

**Der Editor öffnet sich und ich komme nicht raus.** nano: Strg+O, Enter, Strg+X. vim: `Esc`, dann `:wq` und Enter.

**`git log` hängt.** Das ist der Pager: Taste `q`.

**Ich habe eine Datei versehentlich committet (`__pycache__`).** `git rm -r --cached __pycache__`, in `.gitignore` eintragen, committen.

**Rebase mit Konflikt, ich will zurück.** `git rebase --abort` stellt den Zustand vor dem Rebase her.

## Remote & GitLab
**`! [rejected] … (fetch first)`.** Auf dem Server liegen Commits, die Sie nicht haben: `git pull`, ggf. Konflikt lösen, `git push`.

**„You are not allowed to push code to this project.“** Ihre Rolle reicht nicht (Reporter). Maintainer um Developer-Rolle bitten.

**„You are not allowed to push code to protected branches.“** Gewollt! Arbeiten Sie auf einem Branch und stellen Sie einen Merge Request.

**Merge Request: „Merge blocked: merge conflicts must be resolved“.** Lokal: `git fetch && git rebase origin/main` → Konflikte lösen → `git add` → `git rebase --continue` → `git push --force-with-lease`.

**Merge-Button fehlt oder ist grau.** MR ist noch *Draft* (→ *Mark as ready*), die Pipeline ist nicht grün oder Ihre Rolle darf nicht in `main` mergen.

**`git push --force-with-lease` wird abgelehnt.** Jemand hat inzwischen auf Ihren Branch gepusht. Erst `git fetch`, ansehen, integrieren, dann erneut.

## CI/CD
**Pipeline bleibt „pending“.** Kein passender Runner: Tags prüfen, Instance Runner aktiviert? Auf gitlab.com evtl. Identitätsprüfung nötig.

**„This GitLab CI configuration is invalid“.** YAML-Einrückung (nur Leerzeichen!) und Anführungszeichen um Zeilen mit `: ` prüfen. Vorab lokal: `gitlab-ci-local --list`.

**Masked-Variable lässt sich nicht speichern.** Maskierte Werte brauchen mindestens 8 Zeichen und dürfen nur bestimmte Zeichen enthalten.

**Job `db-check` wartet lange.** Der Service-Container braucht ein paar Sekunden zum Starten, deshalb fragt das Skript mehrfach mit `pg_isready`. Hostname ist der `alias` (`db`).

**Cache wirkt nicht.** Cache ist pro Runner und nicht garantiert. Schlüssel (`key`) prüfen; bei Instance Runnern kann ein anderer Runner den Job bekommen.
