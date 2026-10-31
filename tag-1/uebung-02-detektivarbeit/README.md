# Übung 2 – Detektivarbeit
**Tag 1 · 40 Minuten · im Breakout-Raum: Driver · Navigator · Reviewer**

🎯 **Ziel:** Historie lesen, einen Fehler-Commit mit `bisect` finden, ihn sicher korrigieren und „verlorene“ Commits retten.

> **Rollen:** Der *Driver* teilt den Bildschirm und tippt, der *Navigator* sagt an, was zu tun ist, der *Reviewer* prüft jede Antwort im Spickzettel. Nach jedem Schritt wechseln die Rollen. Der neue Driver holt die bisherigen Schritte in seinem Container kurz nach (Schritt 1 genügt meist).
> Zu zweit? Dann übernimmt der Navigator auch das Prüfen. Allein? Einfach alle Schritte nacheinander.

## Aufgaben
1. Übungsrepository erzeugen:
   ```bash
   cd ~/seminar && bash $SEMINAR/tag-1/uebung-02-detektivarbeit/setup.sh && cd sandbox
   ```
2. Mit `git lg`, `git show` und `git log -p` herausfinden: Welcher Commit fügte „Suppe“ hinzu? (Profi: `git log -S "Suppe"`)
3. In `rezepte.md` steht „Kurry“ statt „Curry“. Finden Sie mit `git bisect` den verursachenden Commit.
   Profi-Variante, vollautomatisch: `git bisect run sh -c '! grep -q Kurry rezepte.md'`
4. `git bisect reset`, dann den Fehler mit `git revert <sha>` korrigieren. Warum `revert` und nicht `reset`?
5. `README.md` ändern, stagen, wieder aus dem Staging nehmen (`git restore --staged`) und die Änderung verwerfen (`git restore`).
6. **Mutprobe:** `git reset --hard HEAD~3`. Prüfen Sie mit `git lg`, dass die Commits „weg“ sind. Retten Sie alles mit `git reflog`.

✅ **Geschafft, wenn:** „Curry“ wieder korrekt ist (per revert) und nach der Rettung alle Commits wieder da sind.

<details><summary>💡 Hinweis</summary>

Nach `git bisect` immer `git bisect reset`, sonst stehen Sie im „detached HEAD“. Im reflog suchen Sie den Eintrag **vor** dem `reset`.
</details>

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
