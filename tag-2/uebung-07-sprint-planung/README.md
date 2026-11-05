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

## Teil B – Board & Branches
5. *Plan → Issue boards*: Liste für Label `status::doing` anlegen.
6. Jede/r zieht das **eigene** Issue (#1, #2, #3) auf „doing“ und klickt im Issue auf **Create merge request**.
7. Lokal (Dev A/B im `team-calc`, Maintainer im eigenen `calc-service`):
   ```bash
   git fetch && git switch <branch-name-aus-gitlab>      # z. B. 2-funktion-multiply
   ```
8. Dev A implementiert `multiply()`, Dev B `power()`, jeweils mit Test, `python -m pytest` grün, Commit (`feat: …`) und push. **Noch nicht mergen.**
    Der Maintainer wartet mit #1, denn die Pipeline bauen wir nach dem Mittag gemeinsam.
9. Zeit buchen: im eigenen Issue `/spend 20m`

✅ **Geschafft, wenn:** fünf geschätzte Issues im Milestone `v1.0` stehen und die MRs zu #2 und #3 (Draft) mit Code existieren.

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
