# Bonus-Challenges
Für Schnelle während des Seminars oder zum Vertiefen danach. Lösungen auf dem Branch `loesungen` unter `loesungen/bonus.md`.

### B1 – Commits aufräumen
Erzeugen Sie in einem Übungsrepo 4 Commits „wip 1“ bis „wip 4“. Fassen Sie sie mit `git rebase -i` zu einem Commit „feat: …“ zusammen.

### B2 – Stash mit Namen
Parken Sie zwei verschiedene Änderungen mit Namen und holen Sie gezielt die **erste** zurück.

### B3 – Ein verlorener Branch
Löschen Sie einen nicht gemergten Branch mit `git branch -D`. Holen Sie ihn zurück.

### B4 – Wer war's?
Finden Sie in einem beliebigen Repository mit `git log` heraus, wer in den letzten 30 Tagen die meisten Commits gemacht hat.

### B5 – Eigener Alias
Bauen Sie einen Alias `git last`, der den letzten Commit mit Änderungsstatistik zeigt.

### B6 – Cherry-pick
Übernehmen Sie einen einzelnen Commit aus einem Feature-Branch nach `main`, ohne den ganzen Branch zu mergen.

### B7 – Schnellere Pipeline mit `needs`
Lassen Sie `test` nicht mehr auf die ganze Stage `lint` warten, sondern nur auf den Job `lint`. Was ändert sich in der Pipeline-Ansicht?

### B8 – Manuelle Freigabe
Ergänzen Sie einen Job `deploy`, der nur bei Tags läuft und erst nach Klick startet.
