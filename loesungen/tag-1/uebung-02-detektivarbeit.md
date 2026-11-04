# Lösung Übung 2 – Detektivarbeit (40 Min · 👥 GRUPPE im Breakout: Driver · Navigator · Reviewer)
> 👤 **SELBST** = allein im eigenen Container · 👥 **GEMEINSAM** = zusammen, eine Person teilt den Bildschirm. Commit-Hashes sind Beispiele – bei Ihnen sehen sie anders aus.


## Schritt 1 – Übungsrepository erzeugen
```bash
cd ~/seminar && bash $SEMINAR/tag-1/uebung-02-detektivarbeit/setup.sh && cd sandbox
git lg
# * 8ca67af (HEAD -> main) feat: Rezept Kuchen
# * 75db800 docs: Portionen im README
# * 5bde64b feat: Rezept Suppe
# * 3132d02 refactor: Formatierung
# * b918fb6 feat: Rezept Salat
# * 39c27ec feat: Rezept Curry
# * d98aa56 feat: Rezept Pfannkuchen
# * 2ac43a8 docs: README
```
Neu starten? `cd ~/seminar && rm -rf sandbox` und das Setup erneut ausführen.

## Schritt 2 – Wann kam „Suppe“ dazu?
```bash
git log -p rezepte.md        # durchblättern mit Leertaste, q beendet
git log -S "Suppe" --oneline
# 5bde64b feat: Rezept Suppe
git show 5bde64b
# +## Suppe
# +Kartoffeln, Lauch, Brühe
```
**Warum:** `-S` sucht Commits, in denen sich die **Anzahl** der Vorkommen des Textes ändert, also wo er dazukam oder verschwand.

## Schritt 3 – „Kurry“-Commit mit bisect finden

**Manuell (so sollten alle es einmal machen):**
```bash
git bisect start
git bisect bad                 # HEAD hat den Fehler
git bisect good HEAD~5         # HEAD~5 = 39c27ec „feat: Rezept Curry“ – noch korrekt
# Bisecting: 2 revisions left to test after this (roughly 1 step)
# [3132d02…] refactor: Formatierung

grep Kurry rezepte.md          # ## Kurry  → Treffer
git bisect bad
# [b918fb6…] feat: Rezept Salat

grep Kurry rezepte.md          # kein Treffer
git bisect good
# 3132d02… is the first bad commit
# refactor: Formatierung

git bisect reset               # zurück auf main
```

**Vollautomatisch (Profi):**
```bash
git bisect start HEAD HEAD~5                          # bad, good
git bisect run sh -c '! grep -q Kurry rezepte.md'
# 3132d02… is the first bad commit
# bisect found first bad commit
git bisect reset
```
**Keine Ausgabe?** `git bisect run` ohne vorheriges `git bisect start` mit *bad* und *good* bricht still ab. Immer zuerst die Suche starten.
**Wie entscheidet `run`?** Exit-Code 0 = *good*, 1–127 = *bad* (125 = überspringen). `grep -q` liefert 0 bei Treffer. Das `!` dreht es um: „good, solange KEIN Kurry drinsteht“.

## Schritt 4 – Korrigieren mit revert
```bash
git revert --no-edit 3132d02
# [main 3095bf2] Revert "refactor: Formatierung"
#  1 file changed, 3 insertions(+), 3 deletions(-)
grep Curry rezepte.md
# ## Curry
# Reis, Gemüse, Curry-Paste
git lg | head -2
# * 3095bf2 (HEAD -> main) Revert "refactor: Formatierung"
# * 8ca67af feat: Rezept Kuchen
```
**Frage „Warum revert und nicht reset?“ – Antwort:**
- `revert` erzeugt einen **neuen** Gegen-Commit. Die Historie bleibt erhalten, alle späteren Commits (Suppe, Portionen, Kuchen) bleiben unangetastet. Das ist sicher, auch wenn der Fehler schon gepusht ist.
- `reset --hard 3132d02~1` würde **alle vier** späteren Commits mitlöschen und die Historie umschreiben. Bei gepushten Commits bekämen alle Kolleg:innen Probleme.
- Nebenwirkung zum Ansprechen: Der Revert macht auch die Formatierung bei Pfannkuchen rückgängig (`Mehl · Milch · Eier` → `Mehl, Milch, Eier`), denn ein Revert nimmt immer den **ganzen** Commit zurück. Darum: ein Commit = eine Sache.

## Schritt 5 – Stagen und zurücknehmen
```bash
echo "Neue Zeile" >> README.md
git add README.md
git status --short
# M  README.md            ← grünes M links = gestaged
git restore --staged README.md
git status --short
#  M README.md            ← rotes M rechts = nur geändert
git restore README.md
git status
# nothing to commit, working tree clean
```

**Typische Stolpersteine**
| Problem | Lösung |
|---|---|
| `bisect run` zeigt nichts | `git bisect start HEAD HEAD~5` vergessen |
| „You are in 'detached HEAD' state“ | `git bisect reset` |
| Bei `git revert` öffnet sich nano | `--no-edit` vergessen: einfach `Strg+X` |
| Revert meldet Konflikt | falscher Hash (z. B. Suppe statt Formatierung) → `git revert --abort` |

---
[Alle Lösungen](../README.md) · [Übung](../../tag-1/uebung-02-detektivarbeit/README.md)
