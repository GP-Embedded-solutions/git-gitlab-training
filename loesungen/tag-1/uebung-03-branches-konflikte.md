# Lösung Übung 3 – Branches & Konflikte (40 Min · Teil A 👤 SELBST, Teil B 👥 ZU ZWEIT)
> 👤 **SELBST** = allein im eigenen Container · 👥 **GEMEINSAM** = zusammen, eine Person teilt den Bildschirm. Commit-Hashes sind Beispiele – bei Ihnen sehen sie anders aus.


## Teil A – Feature im calc-service
```bash
cd ~/seminar/calc-service
git switch -c feature/divide
# Switched to a new branch 'feature/divide'
```
`src/calc.py` am Ende ergänzen:
```python


def divide(a: float, b: float) -> float:
    if b == 0:
        raise ValueError("Division durch 0")
    return a / b
```
`tests/test_calc.py` komplett:
```python
import pytest

from src.calc import add, divide


def test_add():
    assert add(2, 3) == 5


def test_divide():
    assert divide(10, 4) == 2.5


def test_divide_durch_null():
    with pytest.raises(ValueError):
        divide(1, 0)
```
```bash
python -m pytest
# 3 passed
git add -A
git commit -m "feat: divide() mit Schutz vor Division durch 0"

git switch main
git merge feature/divide
# Updating 6f9661f..a54db25
# Fast-forward
```
**Warum Fast-Forward?** `main` hat sich seit dem Abzweigen nicht bewegt. Git schiebt den Zeiger `main` einfach nach vorne, ein Merge-Commit ist nicht nötig.
```bash
git branch -d feature/divide
# Deleted branch feature/divide (was a54db25).
git tag -a v0.1.0 -m "Release 0.1.0"
git lg
# * a54db25 (HEAD -> main, tag: v0.1.0) feat: divide() mit Schutz vor Division durch 0
# * 6f9661f feat: add() mit Test
# * 71313ef chore: gitignore
git tag -n
# v0.1.0          Release 0.1.0
```
**Warum v0.1.0?** Neue Funktion, nichts kaputt → MINOR. Vor 1.0.0 gilt das Projekt als „noch nicht stabil“.

## Teil B – Konflikt per Merge
```bash
cd ~/seminar && bash $SEMINAR/tag-1/uebung-03-branches-konflikte/setup.sh && cd konflikt
git lg
# * a9ef9ee (feature/perf) perf: Cache aktivieren
# * 731ad16 perf: schneller abbrechen (timeout 10)
# | * f95facf (HEAD -> main) fix: langsame Netze brauchen mehr Zeit (timeout 60)
# |/
# * e8928cd chore: Grundkonfiguration

git merge feature/perf
# CONFLICT (content): Merge conflict in config.ini
# Recorded preimage for 'config.ini'
cat config.ini
# <<<<<<< HEAD
# timeout = 60
# =======
# timeout = 10
# >>>>>>> feature/perf
# retries = 3
# log_level = info
git status --short
# A  cache.ini            ← ohne Konflikt schon übernommen
# UU config.ini           ← both modified
```
**Die richtige Lösung:** Fachlich widersprechen sich die beiden Commits (main: 60 s für langsame Netze, feature: 10 s für schnelles Abbrechen). Das Team entscheidet sich für den **Kompromiss `timeout = 30`**. Konfliktmarker komplett löschen, die Datei sieht danach so aus:
```ini
timeout = 30
retries = 3
log_level = info
```
```bash
nano config.ini                  # oder: printf 'timeout = 30\nretries = 3\nlog_level = info\n' > config.ini
git add config.ini
git commit --no-edit
# Recorded resolution for 'config.ini'.
git lg
# *   983a9b5 (HEAD -> main) Merge branch 'feature/perf'
# |\
# | * a9ef9ee (feature/perf) perf: Cache aktivieren
# | * 731ad16 perf: schneller abbrechen (timeout 10)
# * | f95facf fix: langsame Netze brauchen mehr Zeit (timeout 60)
# |/
# * e8928cd chore: Grundkonfiguration
```
→ **Raute** mit Merge-Commit (zwei Eltern).

## Teil B – derselbe Konflikt per Rebase
```bash
git reset --hard HEAD~1          # Merge-Commit verwerfen (erlaubt: nichts gepusht)
git switch feature/perf
git rebase main
# CONFLICT (content): Merge conflict in config.ini
# Resolved 'config.ini' using previous resolution.
```
ℹ️ **Gut zu wissen:** Im Container ist `rerere.enabled=true`. Git hat sich die Lösung aus dem Merge gemerkt und trägt `timeout = 30` **automatisch** ein (`Resolved … using previous resolution`). Sie sehen dann keine Konfliktmarker. Das ist kein Fehler, sondern der rerere-Bonus in Aktion. Die Datei ist trotzdem noch als Konflikt markiert:
```bash
cat config.ini                   # timeout = 30 – schon gelöst
git status --short               # UU config.ini
git add config.ini
git rebase --continue            # Editor: einfach speichern/schließen
# Successfully rebased and updated refs/heads/feature/perf.
git lg
# * 601edc1 (HEAD -> feature/perf) perf: Cache aktivieren
# * 9ed1978 perf: schneller abbrechen (timeout 10)
# * f95facf (main) fix: langsame Netze brauchen mehr Zeit (timeout 60)
# * e8928cd chore: Grundkonfiguration
```
→ **Linie**, neue Hashes für die zwei perf-Commits.
Wer die Marker beim Rebase selbst sehen möchte: `git rebase --abort`, dann `git -c rerere.enabled=false rebase main`.
**Achtung beim Rebase:** Der obere Block (`HEAD`) ist jetzt **main**, der untere sind Ihre eigenen Commits, also umgekehrt wie beim Merge.

**Antwort auf die Vergleichsfrage:** Merge = ehrliche Geschichte mit Raute. Rebase = gerade Linie, leichter zu lesen. Für den **eigenen** Branch ist Rebase angenehm, für gemeinsame Branches nie.

## Bonus – rebase -i
```bash
git switch -c bonus
for i in 1 2 3; do echo "zeile $i" >> notiz.txt; git add notiz.txt; git commit -qm "wip $i"; done
git rebase -i HEAD~3
# im Editor: erste Zeile „pick“ lassen, Zeilen 2 und 3 auf „squash“ ändern → speichern → Nachricht anpassen
git lg | head -2                 # nur noch ein Commit
```

**Typische Stolpersteine:** `setup.sh` aus `calc-service` heraus gestartet · `import pytest` vergessen · Merge auf dem falschen Branch · Tag ohne `-a` · Marker nicht vollständig gelöscht (`git diff --check` findet sie) · beim Rebase `git commit` statt `git rebase --continue`. Notbremse: `git merge --abort` bzw. `git rebase --abort`.

---
[Alle Lösungen](../README.md) · [Übung](../../tag-1/uebung-03-branches-konflikte/README.md)
