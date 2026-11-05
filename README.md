# Git & GitLab Professional – Seminarunterlagen
**Live-Online-Seminar · 2 Tage · 09:00–16:00 Uhr**

Willkommen! Hier finden Sie alles für das Seminar und alles, um die Inhalte später selbstständig zu wiederholen.

> **Unser roter Faden:** das Projekt `calc-service`. An Tag 1 baut jede/r eine eigene Version, an Tag 2 wird daraus ein gemeinsames Team-Projekt auf gitlab.com: mit Rollen, Sprint-Planung, Code-Reviews, CI/CD-Pipeline und dem Team-Release **v1.0.0** inklusive Docker-Image.

## 🚀 In 3 Schritten startklar
1. **Vorbereitung erledigen:** [`00-vorbereitung/`](00-vorbereitung/README.md) (ca. 30–45 Minuten)
2. **Seminar-Container starten:** `./container/seminar-start.sh` (Windows: `.\container\seminar-start.ps1`) oder GitHub Codespaces
3. **Im Container:** `seminar-einrichten`, danach `seminar-check` → alles grün?

## 📥 Folien und Handout
Unter **Releases** (rechte Seite der Repository-Seite) finden Sie zu jeder Version:
- `Handout_Tag1_Git.pdf` und `Handout_Tag2_GitLab.pdf` – Spickzettel, alle Übungen, Glossar, Montags-Plan
- `Folien-Tag-1.pdf` und `Folien-Tag-2.pdf`

## 📁 Wo finde ich was?
| Ordner | Inhalt | Wann? |
|---|---|---|
| [`00-vorbereitung/`](00-vorbereitung/README.md) | Container, gitlab.com-Account, SSH-Schlüssel | **vor** dem Seminar |
| [`tag-1/`](tag-1/README.md) | Tagesplan + Übungen 1–4: Git-Grundlagen, Repositories, Team-Workflows | Tag 1 |
| [`tag-2/`](tag-2/README.md) | Tagesplan + Übungen 5–10: GitLab, Planung, CI/CD | Tag 2 |
| [`starter/`](starter/calc-service/) | Startprojekt `calc-service` | Übung 1 |
| [`ci-vorlagen/`](ci-vorlagen/README.md) | `.gitlab-ci.yml` in 4 Stufen + Dockerfile | Übungen 8–9 |
| [`nachschlagen/`](nachschlagen/) | Spickzettel, Glossar, FAQ, Weiterlernen, Montags-Plan | jederzeit |
| [`bonus/`](bonus/README.md) | Bonus-Challenges zum Vertiefen | wenn Zeit ist / danach |
| [`tools/`](tools/) | Git-Grundkonfiguration für Rechner ohne Container | bei Bedarf |
| [`container/`](container/README.md) | Seminar-Container | Vorbereitung |

## ✅ Musterlösungen
Die Lösungen werden jeweils **am Abend** freigeschaltet. Probieren Sie die Übungen zuerst selbst, denn der Lerneffekt entsteht beim Knobeln.

| Wann | Befehl | Inhalt |
|---|---|---|
| Abend von Tag 1 | `git fetch && git switch loesungen-tag-1` | `loesungen/tag-1/` (Übungen 1–4) |
| Abend von Tag 2 | `git fetch && git switch loesungen` | zusätzlich `loesungen/tag-2/`, Endstand `calc-service-final/`, Bonus |

Zurück zu den Aufgaben: `git switch main`.
