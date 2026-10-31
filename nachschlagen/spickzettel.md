# Spickzettel – Git & GitLab Professional

### Das mentale Modell
```
Working Directory ──git add──▶ Staging (Index) ──git commit──▶ lokales Repo ──git push──▶ Remote (GitLab)
       ◀──git restore──                ◀──git restore --staged──        ◀──git pull / fetch──
```
- **Commit** = Snapshot mit Hash, Autor, Nachricht und Eltern-Commit
- **Branch** = beweglicher Zeiger auf einen Commit
- **HEAD** = wo ich gerade stehe
- **origin/main** = letzter bekannter Stand von main auf dem Server

### Seminar-Container
```bash
./container/seminar-start.sh            # starten (Windows: .\container\seminar-start.ps1)
./container/seminar-start.sh --docker   # mit Docker-Zugriff (Übung 9)
seminar-einrichten                      # Name, E-Mail, SSH-Schlüssel, Gruppe
seminar-check                           # alles bereit?
seminar-hilfe                           # Übersicht
echo $SEMINAR $GRUPPE                   # Unterlagen-Ordner und GitLab-Gruppe
```
Arbeitsordner: `~/seminar` · Editor: `nano` (Strg+O speichern, Strg+X beenden)

### Einrichtung (einmalig, im Container schon voreingestellt)
```bash
git config --global user.name  "Vorname Nachname"
git config --global user.email "name@firma.de"
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global rerere.enabled true
git config --global core.autocrlf input            # Windows: true
git config --global alias.st  "status -sb"
git config --global alias.lg  "log --oneline --graph --decorate --all"
```

### Täglicher Ablauf
```bash
git switch main && git pull               # aktuell werden
git switch -c feature/42-kurzbeschreibung # Branch fürs Issue
git status
git add -p                                # gezielt stagen
git commit -m "feat: kurzbeschreibung (Closes #42)"
git push -u origin feature/42-kurzbeschreibung
# → Merge Request in GitLab, Review, Pipeline grün, Merge
```

### Historie & Vergleich
| Befehl | Zweck |
|---|---|
| `git lg` | Graph aller Branches |
| `git log -p -- datei` | Änderungen einer Datei |
| `git log -S "text"` | Wann kam/ging ein Text? |
| `git show <sha>` | einzelnen Commit ansehen |
| `git blame datei` | Wer hat welche Zeile zuletzt geändert? |
| `git diff` / `git diff --staged` | Arbeitsstand ↔ Index / Index ↔ Commit |
| `git diff main..feature` | Unterschied zweier Branches |

### Undo – erst fragen: „Ist es schon gepusht?“
| Situation | Befehl |
|---|---|
| Änderung an Datei verwerfen | `git restore datei` |
| Datei aus Staging nehmen | `git restore --staged datei` |
| Letzten Commit ändern (nicht gepusht) | `git commit --amend` |
| Gepushten Commit zurücknehmen | `git revert <sha>` |
| Lokale Commits zurücknehmen, Änderungen behalten | `git reset --soft HEAD~1` |
| Lokale Commits komplett verwerfen | `git reset --hard HEAD~1` ⚠ |
| Arbeit kurz parken | `git stash push -m "wip"` → `git stash pop` |
| „Alles kaputt“ | `git reflog` → `git reset --hard HEAD@{n}` |
| Fehler-Commit suchen | `git bisect start` · `bad` · `good <sha>` · `reset` |

### Branches, Merge, Rebase, Tags
```bash
git switch -c feature/x        # anlegen + wechseln
git switch -                   # zurück
git branch -d feature/x        # löschen (gemergt)
git merge feature/x            # in aktuellen Branch mergen
git merge --abort              # Merge abbrechen
git rebase main                # eigenen Branch auf main aktualisieren
git rebase -i HEAD~3           # aufräumen: squash, reword, drop
git push --force-with-lease    # nach Rebase (nur eigener Branch!)
git tag -a v1.0.0 -m "Release" && git push origin v1.0.0
```
**Goldene Regel:** Niemals Commits rebasen, die andere schon haben.

**Konflikt lösen:** Datei öffnen → Bereich zwischen `<<<<<<<` und `>>>>>>>` fachlich korrekt zusammenführen → Marker löschen → `git add datei` → `git commit` (bzw. `git rebase --continue`).

### Remotes & Team
```bash
git remote add origin git@gitlab.com:gruppe/projekt.git
git push -u origin main
git fetch --prune              # Stand holen, gelöschte Remote-Branches entfernen
git pull                       # fetch + rebase (mit pull.rebase=true)
git push                       # abgelehnt? → erst git pull, dann erneut push
git rebase origin/main         # eigenen Branch auf den neuesten main setzen
git branch -r                  # Remote-Branches anzeigen
git log origin/feature/x       # Branch einer Kollegin ansehen, ohne zu wechseln
git push origin --delete feature/x
```

### GitLab – Rollen & Zugänge
| Rolle | Kann |
|---|---|
| Guest (10) | Issues sehen/anlegen |
| Reporter (20) | Code lesen, Issues verwalten |
| Developer (30) | pushen (ungeschützte Branches), MRs |
| Maintainer (40) | geschützte Branches mergen, Einstellungen |
| Owner (50) | alles inkl. löschen |

| Zugang | Wofür |
|---|---|
| SSH-Key | Ihr Rechner ↔ Git |
| Personal Access Token | Ihre Skripte / API |
| Project Access Token | Integrationen (personenunabhängig, Premium auf gitlab.com) |
| Deploy Token | Server holt Code oder Images |
| Deploy Key | Server klont per SSH (read-only) |
| CI_JOB_TOKEN | automatisch im Pipeline-Job |

```bash
ssh-keygen -t ed25519 -C "name@firma.de"   # Key erzeugen, mit Passphrase
ssh-keygen -lf ~/.ssh/id_ed25519.pub        # Fingerabdruck
ssh -T git@gitlab.com                       # Test: "Welcome to GitLab, @name!"
```
**Quick Actions** in Issues/MRs: `/assign @name` · `/label ~"type::bug"` · `/milestone %v1.0` · `/estimate 2h` · `/spend 30m` · `/close`

### GitLab CI/CD – Bausteine
```yaml
stages: [lint, test, build]          # Reihenfolge
variables:                           # eigene Variablen
  APP_ENV: test
.vorlage:                            # versteckter Job (Punkt!) zur Wiederverwendung
  image: python:3.12-slim
  before_script: [pip install -r requirements.txt]
test:
  extends: .vorlage
  stage: test
  script: [pytest --junitxml=report.xml]
  cache:   { key: { files: [requirements.txt] }, paths: [.cache/pip] }
  artifacts: { when: always, reports: { junit: report.xml } }
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
```

| Wichtige Variable | Inhalt |
|---|---|
| `CI_COMMIT_BRANCH` | Branchname (nicht bei Tags/MR) |
| `CI_COMMIT_TAG` | Tagname (nur bei Tag-Pipelines) |
| `CI_COMMIT_SHORT_SHA` | kurzer Commit-Hash |
| `CI_DEFAULT_BRANCH` | meist `main` |
| `CI_PIPELINE_SOURCE` | push, merge_request_event, schedule … |

**Cache** = beschleunigt (nicht garantiert) · **Artifact** = Ergebnis weitergeben (garantiert)
**Pipeline lokal prüfen:** `gitlab-ci-local --list` (im Container vorinstalliert)
**Pipeline „pending“?** → kein passender Runner (Tags prüfen), keiner frei oder Account nicht verifiziert.
