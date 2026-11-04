# Lösung Übung 4 – Team-Sync (35 Min · 👥 GEMEINSAM im Hauptraum)
> 👤 **SELBST** = allein im eigenen Container · 👥 **GEMEINSAM** = zusammen, eine Person teilt den Bildschirm. Commit-Hashes sind Beispiele – bei Ihnen sehen sie anders aus.


## So funktioniert die Übung
Alle arbeiten im eigenen Container, pushen aber auf **ein gemeinsames** Projekt `team-sync`. Der Trainer gibt per Countdown den Takt vor, damit alle gleichzeitig pushen. Nur der erste Push gelingt, alle anderen erleben die Ablehnung und lösen sie.

**Allein nachüben:** Der `team-simulator.sh` spielt die Kollegin „Anna“:
```bash
bash $SEMINAR/tag-1/uebung-04-team-sync/team-simulator.sh init ~/seminar
cd ~/seminar && git clone ~/seminar/team-sync.git && cd team-sync
```

## Teil A – Klonen & orientieren
```bash
cd ~/seminar
git clone git@gitlab.com:$GRUPPE/team-sync.git
cd team-sync
git remote -v
# origin  git@gitlab.com:<gruppe>/team-sync.git (fetch)
# origin  git@gitlab.com:<gruppe>/team-sync.git (push)
git branch -a
# * main
#   remotes/origin/HEAD -> origin/main
#   remotes/origin/main
git lg
# * fe9dd16 (HEAD -> main, origin/main, origin/HEAD) chore: Team-Sync-Repository angelegt
```

## Teil B – Abgelehnter Push
```bash
printf '# Max\nRolle: Entwickler\nLieblings-Editor: VS Code\n' > mitglieder/max.md
git add mitglieder/max.md
git commit -m "docs: Max stellt sich vor"
# --- Countdown 3 – 2 – 1 – PUSH! ---
git push
#  ! [rejected]        main -> main (fetch first)
# error: failed to push some refs to 'gitlab.com:<gruppe>/team-sync.git'
# hint: Updates were rejected because the remote contains work that you do not
# hint: have locally. … use 'git pull' before pushing again.
```
**Laut vorlesen lassen. Bedeutung:** Auf dem Server liegt ein Commit, den ich noch nicht habe. Git schützt diesen Commit vor dem Überschreiben.
```bash
git pull
# Successfully rebased and updated refs/heads/main.
git push
git lg
# * 23b64ac (HEAD -> main, origin/main) docs: Max stellt sich vor
# * 25a9896 docs: Anna stellt sich vor
# * fe9dd16 chore: Team-Sync-Repository angelegt
```
**Warum gibt es keinen Konflikt?** Verschiedene Dateien. Wegen `pull.rebase=true` wird der eigene Commit obendrauf gesetzt → lineare Historie.
Bei vielen Teilnehmenden kann es mehrere Runden dauern: wer erneut abgelehnt wird, einfach nochmal `git pull` → `git push`.

## Teil C – Echter Konflikt
```bash
nano regeln.md
# Zeile ändern zu:  Lieblings-Git-Befehl des Teams: git switch
git commit -am "docs: Max Lieblingsbefehl"
# --- Countdown ---
git push                 # rejected (fetch first)
git pull
# CONFLICT (content): Merge conflict in regeln.md
# Could not apply cef4cca... docs: Max Lieblingsbefehl
cat regeln.md
# # Team-Regeln
# Daily Stand-up um: 09:30 Uhr
# Code-Review innerhalb von: 24 Stunden
# <<<<<<< HEAD
# Lieblings-Git-Befehl des Teams: git lg              ← vom Server (die anderen)
# =======
# Lieblings-Git-Befehl des Teams: git switch          ← mein eigener Commit
# >>>>>>> cef4cca (docs: Max Lieblingsbefehl)
```
**Die richtige Lösung:** Das Team einigt sich auf eine Zeile mit allen Befehlen. Marker löschen:
```text
Lieblings-Git-Befehl des Teams: git lg, git switch
```
```bash
git add regeln.md
git rebase --continue    # NICHT git commit
git push
```
Bei mehreren Personen: Wer als Nächstes abgelehnt wird, ergänzt seinen Befehl in derselben Zeile, so wächst die Liste. Am Ende steht eine Zeile mit allen Lieblingsbefehlen.

## Teil D – Remote Branches
```bash
git switch -c feature/max-idee
printf '# Idee von Max\nKleine MRs, max. 1 Tag.\n' > ideen/max.md
git add ideen/max.md
git commit -m "docs: Idee kleine MRs"
git push -u origin feature/max-idee

git fetch
git branch -r
#   origin/HEAD -> origin/main
#   origin/feature/anna-idee
#   origin/feature/max-idee
#   origin/main
git log --oneline origin/feature/anna-idee | head -1
# 62e8b3b docs: Idee Conventional Commits
git diff main origin/feature/anna-idee
# +# Idee von Anna …
git switch feature/anna-idee
# branch 'feature/anna-idee' set up to track 'origin/feature/anna-idee'.

git switch main
git push origin --delete feature/max-idee      # NUR den eigenen!
git fetch --prune
git branch -r
#   origin/HEAD -> origin/main
#   origin/main
```
**Warum `--prune`?** Ohne `--prune` behält Ihr Rechner die Lesezeichen (`origin/feature/…`) gelöschter Branches.

## Teil E – Workflows (Lösung)
| Szenario | Workflow |
|---|---|
| (a) Web-Shop, mehrere Deployments pro Tag | GitHub Flow |
| (b) On-Premise, Kunden auf v3.x und v4.x | Git Flow |
| (c) Test-, Staging-, Produktionsumgebung | GitLab Flow |
| (d) Feature Flags, sehr gute Tests | Trunk-Based |

## Geschafft, wenn
```bash
git switch main && git pull
cat regeln.md            # eine gemeinsame Zeile
ls mitglieder/           # alle Vornamen
git branch -r            # nur origin/main
```

**Typische Stolpersteine:** SSH-Klon scheitert → HTTPS-Adresse oder `ssh -T git@gitlab.com` prüfen · Datei nicht im Ordner `mitglieder/` · vor dem Push nicht committet · `git commit` statt `git rebase --continue` · fremden Remote-Branch gelöscht (wiederherstellen: Besitzer pusht erneut) · **jemand will `--force` pushen → sofort stoppen.**

---
[Alle Lösungen](../README.md) · [Übung](../../tag-1/uebung-04-team-sync/README.md)
