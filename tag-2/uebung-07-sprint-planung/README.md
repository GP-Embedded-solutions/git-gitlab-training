# Übung 7 – Sprint-Planung
**Tag 2 · 30 Minuten · alle**

🎯 **Ziel:** den Sprint „v1.0“ planen wie ein echtes Team: Labels, Milestone, Issues mit Tasks, Schätzung, Board und Zeiterfassung.

## Teil A – Grundgerüst (Maintainer teilt den Bildschirm, alle diktieren)
Diese fünf Issues plant das Team:

| # | Titel | Rolle |
|---|---|---|
| 1 | CI-Pipeline einrichten | Maintainer |
| 2 | Funktion `multiply()` | Dev A |
| 3 | Funktion `power()` | Dev B |
| 4 | Docker-Image & Service-Test | Maintainer |
| 5 | Funktion `modulo()` | Dev A |

1. *Manage → Labels*: `type::feature` (blau), `type::bug` (rot), `prio::high` (orange), `status::doing` (grün)
2. *Plan → Milestones*: `v1.0` mit Fälligkeitsdatum in 14 Tagen
3. *Plan → Issues*: die fünf Issues aus der Tabelle anlegen, alle mit Milestone `v1.0` und passendem Label
4. In Issue #1 eine **Task-Liste** in die Beschreibung schreiben:
   ```
   - [ ] Tests laufen bei jedem Push
   - [ ] Lint-Prüfung
   - [ ] Test-Report im Merge Request
   ```

~~## Teil B – Planning Poker (alle)
5. Pro Issue schätzt jede/r **verdeckt** (Poker-Link im Chat, oder Zahl in den Chat tippen und erst auf „Jetzt!“ senden; Karten 1, 2, 3, 5, 8 Viertelstunden). Bei großen Unterschieden begründen die Höchst- und die Niedrigstschätzung, dann neu schätzen.
6. Ergebnis per Quick Action ins Issue, z. B. `/estimate 45m` und `/assign @benutzername`~~

## Teil C – Board & Branches
7. *Plan → Issue boards*: Liste für Label `status::doing` anlegen.
8. Jede/r zieht das **eigene** Issue (#1, #2, #3) auf „doing“ und klickt im Issue auf **Create merge request**.
9. Lokal (Dev A/B im `team-calc`, Maintainer im eigenen `calc-service`):
   ```bash
   git fetch && git switch <branch-name-aus-gitlab>      # z. B. 2-funktion-multiply
   ```
10. Dev A implementiert `multiply()`, Dev B `power()`, jeweils mit Test, `python -m pytest` grün, Commit (`feat: …`) und push. **Noch nicht mergen.**
    Der Maintainer wartet mit #1, denn die Pipeline bauen wir nach dem Mittag gemeinsam.
11. Zeit buchen: im eigenen Issue `/spend 20m`

## Teil D – Epics, Iterations, Roadmaps (Gespräch, 5')
Ordnen Sie zu: „Neuer Checkout-Prozess über 3 Sprints“, „Sprint 47 (2 Wochen)“, „Release 2.3 am 30.11.“ → Epic, Iteration oder Milestone? (Epics, Iterations, Roadmaps und Burndown Charts sind Premium-Funktionen, siehe Folien.)

✅ **Geschafft, wenn:** fünf geschätzte Issues im Milestone `v1.0` stehen und die MRs zu #2 und #3 (Draft) mit Code existieren.

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
