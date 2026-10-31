# Tag 2 – GitLab, Projektorganisation und CI/CD
**Live online · 09:00–16:00 Uhr · alle Übungen auf gitlab.com in Ihrer Seminar-Gruppe `$GRUPPE`**

| Zeit | Block | Übung |
|---|---|---|
| 09:00 | Warm-up-Quiz & Rückblick | |
| 09:15 | **Block 5** – GitLab, Gruppen, Rollen, SSH, Projekteinstellungen | [Ü5 Team-Projekt aufsetzen](uebung-05-gitlab-team-projekt/README.md) |
| 10:30 | ☕ Pause | |
| 10:45 | **Block 6** – Projekte, Sichtbarkeit, Tokens, Keys | [Ü6 Tokens & Keys](uebung-06-tokens-keys/README.md) |
| 11:30 | **Block 7** – Planung: Issues bis Roadmap | [Ü7 Sprint-Planung](uebung-07-sprint-planung/README.md) |
| 12:15 | 🍽 Mittagspause | |
| 13:00 | **Block 8** – Merge Requests & CI/CD | [Ü8 Pipeline & Team-MRs](uebung-08-pipeline-team-mrs/README.md) |
| 14:15 | ☕ Pause | |
| 14:30 | **Block 9** – Docker, podman, Services, Testing | [Ü9 Container & Services](uebung-09-container-services/README.md) |
| 15:15 | **Block 10** – Runner | |
| 15:30 | Team-Release & Abschluss | [Ü10 Team-Release v1.0.0](uebung-10-team-release/README.md) |

**Lernziele:** GitLab-Projekte strukturiert aufsetzen · Zugriffe nachvollziehbar regeln · Arbeit mit Issues und Milestones planen · einfache CI/CD-Pipelines für Build und Test planen

## Ihre Rollen im Team-Projekt
Heute arbeiten Sie gemeinsam an **einem** Projekt `$GRUPPE/backend/calc-service`. Die Übungen sprechen Rollen an, nicht Personen:

| Rolle | Startet als | Sprint-Issues | Finale (Ü10) |
|---|---|---|---|
| **Maintainer** | Maintainer der Subgruppe `backend` | #1 CI-Pipeline, #4 Docker & Service-Test | Review & Merge |
| **Dev A** | Developer | #2 `multiply()` | #5 `modulo()` |
| **Dev B** | Reporter → in Ü5 Developer | #3 `power()` | **Release-Manager:in** (v1.0.0) |

Wer welche Rolle übernimmt, legt der Trainer zu Beginn fest. Je nach Gruppengröße:

| Teilnehmende | Verteilung |
|---|---|
| 1 | Sie sind Maintainer, der Trainer spielt Dev A und Dev B |
| 2 | Maintainer + Dev A, der Trainer spielt Dev B (oder Dev A übernimmt Dev B mit) |
| 3 | je eine Rolle |
| 4–5 | zusätzliche Personen werden **Dev C/D**: Reviews, Pair Programming mit Dev A/B, Issue #4 gemeinsam mit dem Maintainer |
| 6+ | zwei Teams mit eigenem Projekt (`backend/calc-service-team-1`, `…-team-2`), Rollen je Team |

**Spielregeln:** Status per Reaktion oder im Chat (🟢 🟡 🔴) · wer gerade handelt, teilt den Bildschirm · **Tokens nur per Direktnachricht, nie im Gruppenchat**

Lösungen: am Abend auf dem Branch `loesungen`.
