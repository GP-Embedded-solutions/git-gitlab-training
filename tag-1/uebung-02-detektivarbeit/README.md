# Übung 2 – Detektivarbeit
**Tag 1 · 40 Minuten · 👥 GRUPPE im Breakout-Raum: Driver · Navigator · Reviewer**

🎯 **Ziel:** Historie lesen, einen Fehler-Commit mit `bisect` finden und ihn sicher korrigieren.

> **Rollen:** Der *Driver* teilt den Bildschirm und tippt, der *Navigator* sagt an, was zu tun ist, der *Reviewer* prüft jede Antwort im Spickzettel. Nach jedem Schritt wechseln die Rollen. Der neue Driver holt die bisherigen Schritte in seinem Container kurz nach (Schritt 1 genügt meist).
> Zu zweit? Dann übernimmt der Navigator auch das Prüfen. Allein? Einfach alle Schritte nacheinander.

## Aufgaben
1. **Übungsrepository erzeugen:**
   ```bash
   cd ~/seminar && bash $SEMINAR/tag-1/uebung-02-detektivarbeit/setup.sh && cd sandbox
   git lg                                  # 8 Commits von „Kim Koch“
   ```

2. **Historie lesen:** Welcher Commit fügte „Suppe“ hinzu?
   ```bash
   git log -p rezepte.md                   # alle Änderungen an der Datei, Commit für Commit
   git show <sha>                          # einen einzelnen Commit genau ansehen
   git log -S "Suppe" --oneline            # Profi: direkt nach dem Text suchen
   ```

3. **Fehler-Commit mit `git bisect` finden.** In `rezepte.md` steht „Kurry“ statt „Curry“.
   Bisect braucht **zwei Startpunkte**: einen Commit mit Fehler (*bad*) und einen ohne (*good*).
   ```bash
   git bisect start                        # 1. Suche beginnen
   git bisect bad                          # 2. der aktuelle Stand (HEAD) hat den Fehler
   git bisect good HEAD~5                  # 3. HEAD~5 = „feat: Rezept Curry“ – dort war es noch richtig
   ```
   Git springt jetzt in die Mitte. Bei **jedem** Schritt prüfen Sie selbst und urteilen:
   ```bash
   grep Kurry rezepte.md                   # Treffer?  → git bisect bad
                                           # kein Treffer? → git bisect good
   ```
   Nach wenigen Schritten meldet Git: `<sha> is the first bad commit`. Notieren Sie Hash und Nachricht, dann:
   ```bash
   git bisect reset                        # zurück auf main (sonst „detached HEAD“)
   ```

   **Profi-Variante, vollautomatisch:** Statt selbst zu urteilen, entscheidet ein Befehl (Exit-Code 0 = good, sonst bad).
   `git bisect run` funktioniert **nur nach** `git bisect start` mit *bad* und *good*, sonst passiert nichts:
   ```bash
   git bisect start HEAD HEAD~5            # bad = HEAD, good = HEAD~5 in einem Befehl
   git bisect run sh -c '! grep -q Kurry rezepte.md'   # „good“, solange KEIN Kurry drinsteht
   git bisect reset
   ```

4. **Sicher korrigieren mit `revert`:**
   ```bash
   git revert --no-edit <sha-aus-schritt-3>
   grep Curry rezepte.md                   # „## Curry“ ist wieder da
   git lg                                  # neuer Commit „Revert …“ obendrauf – nichts wurde gelöscht
   ```
   **Frage:** Warum `revert` und nicht `reset`? (Tipp: Denken Sie an die Leitfrage „Ist es schon gepusht?“)

5. **Änderung stagen und wieder zurücknehmen:**
   ```bash
   echo "Neue Zeile" >> README.md
   git add README.md && git status         # README.md ist grün (gestaged)
   git restore --staged README.md          # aus dem Karton nehmen → wieder rot
   git restore README.md                   # Änderung verwerfen → git status ist sauber
   ```

✅ **Geschafft, wenn:** Sie den Fehler-Commit benennen können, „Curry“ per `revert` wieder korrekt ist und `git status` sauber ist.

<details><summary>💡 Hinweis</summary>

`git bisect run` gibt keine Ausgabe? Dann fehlt `git bisect start` mit *bad* und *good*.
Nach `git bisect` immer `git bisect reset`, sonst stehen Sie im „detached HEAD“.
</details>

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
