# Übung 4 – Team-Sync
**Tag 1 · 35 Minuten · 👥 GEMEINSAM – alle zusammen im Hauptraum, ein Repository auf gitlab.com, der Trainer gibt den Takt vor**

> **So funktioniert die Übung:** Alle klonen dasselbe Projekt `team-sync`. Jede/r arbeitet im **eigenen** Container, aber alle pushen auf **dasselbe** Remote. Der Trainer zählt im Chat herunter („3 – 2 – 1 – PUSH!“), damit alle gleichzeitig pushen: Nur der erste Push geht durch, alle anderen erleben die Ablehnung und lösen sie mit `git pull` + `git push`. Teil C wiederholt das mit einem echten Konflikt.

🎯 **Ziel:** Zusammenarbeit über ein Remote erleben: abgelehnte Pushes, `pull --rebase`, echte Konflikte und Remote Branches.

> **Im Seminar:** Das Projekt `team-sync` liegt in Ihrer Seminar-Gruppe auf gitlab.com, Sie sind alle Developer.
> **Allein nachüben:** `bash $SEMINAR/tag-1/uebung-04-team-sync/team-simulator.sh init ~/seminar` legt ein lokales Remote an. Ihre Kollegin „Anna“ steuern Sie mit demselben Skript (siehe ⏩ in den Schritten).

## Teil A – Klonen & orientieren
```bash
cd ~/seminar
git clone git@gitlab.com:$GRUPPE/team-sync.git      # allein: git clone ~/seminar/team-sync.git
cd team-sync
git remote -v
git branch -a
git lg
```

## Teil B – Abgelehnter Push (verschiedene Dateien)
1. Jede/r legt `mitglieder/<vorname>.md` an (Rolle, Lieblings-Editor) und committet. **Gepusht wird erst auf den Countdown im Chat: 3 – 2 – 1 – PUSH!**
   ⏩ allein: vor Ihrem Push `bash $SEMINAR/tag-1/uebung-04-team-sync/team-simulator.sh mitglied ~/seminar/team-sync.git`
2. Nur der/die Erste kommt durch. Die anderen lesen die Fehlermeldung **laut vor**: Was sagt Git?
3. Lösung: `git pull` (mit `pull.rebase=true` ein Rebase) → `git push`
4. `git lg`: Die Historie ist linear, alle Mitglieder sind drin.

## Teil C – Echter Konflikt (gleiche Zeile)
1. Jede/r ändert in `regeln.md` die Zeile `Lieblings-Git-Befehl des Teams:` auf **den eigenen** Favoriten, committet und pusht wieder auf den Countdown.
   ⏩ allein: vorher `bash $SEMINAR/tag-1/uebung-04-team-sync/team-simulator.sh befehl ~/seminar/team-sync.git`
2. Wer abgelehnt wird: `git pull` → **CONFLICT**. Einigen Sie sich im Team auf eine Lösung (z. B. alle Befehle in einer Zeile).
3. Datei bereinigen → `git add regeln.md` → `git rebase --continue` → `git push`

## Teil D – Remote Branches
1. Jede/r: `git switch -c feature/<vorname>-idee`, eine Datei `ideen/<vorname>.md` mit einer Verbesserungsidee für Ihr echtes Team anlegen, committen, `git push -u origin feature/<vorname>-idee`
   ⏩ allein: `bash $SEMINAR/tag-1/uebung-04-team-sync/team-simulator.sh branch ~/seminar/team-sync.git`
2. `git fetch` → `git branch -r`: Sehen Sie die Branches der anderen?
3. Idee einer anderen Person ansehen, ohne zu wechseln: `git log origin/feature/<name>-idee` und `git diff main origin/feature/<name>-idee`
4. Zu diesem Branch wechseln: `git switch feature/<name>-idee` (Git legt automatisch einen Tracking-Branch an)
5. Aufräumen: Jede/r löscht **den eigenen** Remote-Branch (`git push origin --delete feature/<vorname>-idee`), danach alle: `git fetch --prune` und `git branch -r`
   ⏩ allein: `bash $SEMINAR/tag-1/uebung-04-team-sync/team-simulator.sh aufraeumen ~/seminar/team-sync.git`

✅ **Geschafft, wenn:** `regeln.md` eine gemeinsame Lösung enthält, alle Mitglieder-Dateien in `main` sind und keine Feature-Branches mehr auf dem Remote existieren.

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
