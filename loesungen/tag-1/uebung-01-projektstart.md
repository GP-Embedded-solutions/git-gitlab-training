# Lösung Übung 1 – Projektstart (20 Min · 👤 SELBST)
> 👤 **SELBST** = allein im eigenen Container · 👥 **GEMEINSAM** = zusammen, eine Person teilt den Bildschirm. Commit-Hashes sind Beispiele – bei Ihnen sehen sie anders aus.


## Schritt 1 – Konfiguration prüfen
```bash
git config --global user.name
# Max Muster
git config --global user.email
# max.muster@firma.de
git config --list --show-origin
# file:/etc/gitconfig              init.defaultbranch=main
# file:/etc/gitconfig              pull.rebase=true
# file:/etc/gitconfig              alias.lg=log --oneline --graph --decorate --all
# file:/home/seminar/.gitconfig    user.name=Max Muster
# file:/home/seminar/.gitconfig    user.email=max.muster@firma.de
```
**Warum:** `--show-origin` zeigt die drei Ebenen: `/etc/gitconfig` (system, vom Container), `~/.gitconfig` (global, von `seminar-einrichten`) und später `.git/config` (pro Repository). Die spätere Ebene gewinnt.
**Fehlt etwas?** → `seminar-einrichten` erneut ausführen.

## Schritt 2 – Startprojekt kopieren
```bash
cp -r $SEMINAR/starter/calc-service ~/seminar/ && cd ~/seminar/calc-service
ls
# README.md  requirements.txt  src  tests
```

## Schritt 3 – Repository anlegen
```bash
git init
# Initialized empty Git repository in /home/seminar/seminar/calc-service/.git/
git status
# On branch main
# No commits yet
# Untracked files:
#     README.md
#     requirements.txt
#     src/
#     tests/
```
**Warum:** Git kennt die Dateien noch nicht (*untracked*). Der Branch heißt `main`, weil `init.defaultBranch=main` gesetzt ist.

## Schritt 4 – Tests ausführen und `__pycache__` sichtbar machen
```bash
python -m pytest
# 1 passed
git status -u
#     src/__pycache__/__init__.cpython-312.pyc
#     src/__pycache__/calc.cpython-312.pyc
#     tests/__pycache__/test_calc.cpython-312-pytest-8.x.pyc
#     …
```
**Warum `-u`?** Ohne `-u` fasst Git ungetrackte Ordner zusammen und zeigt nur `src/` und `tests/`, dann sieht man den Müll nicht. `.pytest_cache/` taucht übrigens nie auf: pytest legt darin selbst eine eigene `.gitignore` ab.

## Schritt 5 – `.gitignore` anlegen
```bash
cat > .gitignore <<'EOF'
__pycache__/
*.pyc
.pytest_cache/
.ruff_cache/
.venv/
.env
report.xml
.cache/
EOF
git status -u
# ?? .gitignore
# ?? README.md
# ?? requirements.txt
# ?? src/__init__.py
# ?? src/calc.py
# ?? tests/__init__.py
# ?? tests/test_calc.py
```
**Warum:** Die `.pyc`-Dateien sind verschwunden. `.env` steht drin, damit Passwörter nie versehentlich im Repository landen.

## Schritt 6 – Erster Commit: nur `.gitignore`
```bash
git add .gitignore
git status
# Changes to be committed:
#     new file:   .gitignore
git commit -m "chore: gitignore"
# [main (root-commit) 71313ef] chore: gitignore
```

## Schritt 7 – Zweiter Commit: der Rest
```bash
git add .
git status --short
# A  README.md
# A  requirements.txt
# A  src/__init__.py
# A  src/calc.py
# A  tests/__init__.py
# A  tests/test_calc.py
git commit -m "feat: add() mit Test"
```

## Ergebnis prüfen
```bash
git lg
# * 6f9661f (HEAD -> main) feat: add() mit Test
# * 71313ef chore: gitignore
git status
# nothing to commit, working tree clean
```

**Typische Stolpersteine**
| Problem | Lösung |
|---|---|
| `__pycache__` wurde mitcommittet | `git rm -r --cached src/__pycache__ tests/__pycache__` → `git commit -m "chore: __pycache__ entfernen"` |
| `git commit` öffnet nano | `-m "…"` vergessen. Nachricht eintippen, `Strg+O`, `Enter`, `Strg+X` |
| `python: command not found` | Container zu alt → `./container/seminar-start.sh --neu-bauen` (neues Image enthält `python-is-python3`) |
| `git lg` unbekannt | Container zu alt oder ohne `/etc/gitconfig` → `git log --oneline --graph --all` |

---
[Alle Lösungen](../README.md) · [Übung](../../tag-1/uebung-01-projektstart/README.md)
