# Glossar
| Begriff | Bedeutung |
|---|---|
| **Approve** | Zustimmung im Code-Review eines Merge Requests |
| **Artifact** | Ergebnis eines Pipeline-Jobs (z. B. Test-Report), garantiert an spätere Jobs übergeben |
| **bisect** | Binäre Suche nach dem Commit, der einen Fehler eingeführt hat |
| **Branch** | Beweglicher Zeiger auf einen Commit |
| **Cache** | Zwischenspeicher zwischen Pipeline-Läufen, beschleunigt, aber nicht garantiert |
| **Commit** | Gespeicherter Snapshot mit Autor, Zeit, Nachricht und Eltern-Commit |
| **Conventional Commits** | Konvention für Commit-Nachrichten: `feat:`, `fix:`, `docs:` … |
| **Deploy Key** | SSH-Schlüssel mit Zugriff auf genau ein Projekt, meist nur lesend |
| **Deploy Token** | Benutzername + Token für Server, gehört zum Projekt, nicht zu einer Person |
| **detached HEAD** | HEAD zeigt direkt auf einen Commit statt auf einen Branch |
| **docker:dind** | „Docker in Docker“: Service, mit dem ein Job Images bauen kann |
| **Draft-MR** | Merge Request „in Arbeit“, kann noch nicht gemergt werden (*Mark as ready*) |
| **Epic** | Großes Thema über mehrere Issues und Sprints (Premium) |
| **Fast-Forward** | Merge ohne Merge-Commit: der Zeiger rückt einfach vor |
| **fetch** | Holt neue Commits vom Remote, ändert nichts an der eigenen Arbeit |
| **HEAD** | Zeiger auf den aktuellen Branch bzw. Commit |
| **Index / Staging Area** | Bereich für den nächsten Commit (der „Karton“) |
| **Issue** | Arbeitspaket in GitLab mit Ziel, Verantwortlichen, Termin |
| **Iteration / Burndown** | Sprint-Zeitfenster / Diagramm der verbleibenden Arbeit (Premium) |
| **Job** | Ein Skript in einem Container auf einem Runner |
| **Maintainer** | GitLab-Rolle, die geschützte Branches mergen und Einstellungen ändern darf |
| **Merge Request (MR)** | Antrag, einen Branch in einen anderen zu übernehmen, mit Review und Pipeline |
| **Milestone** | Ziel mit Datum, sammelt Issues und MRs |
| **Mitglied (Member)** | Person mit einer Rolle in Gruppe oder Projekt; Rechte vererben sich von Gruppen auf Projekte |
| **Namespace** | URL-Pfad einer Gruppe oder eines Benutzers in GitLab |
| **origin** | Standardname des Remotes, von dem geklont wurde |
| **Pipeline** | Alle Jobs eines Laufs, gegliedert in Stages |
| **Protected Branch** | Branch, auf den nur bestimmte Rollen pushen oder mergen dürfen |
| **pull** | fetch + integrieren (Merge oder mit `pull.rebase=true` Rebase) |
| **Rebase** | Eigene Commits auf eine neue Basis setzen, erzeugt neue Hashes |
| **reflog** | Lokales Tagebuch jeder HEAD-Bewegung, Rettungsanker |
| **Remote** | Entferntes Repository, z. B. auf gitlab.com |
| **revert** | Neuer Commit, der einen alten aufhebt, sicher nach dem Push |
| **Runner** | Agent, der Pipeline-Jobs abholt und ausführt |
| **Service-Container** | Begleitcontainer eines Jobs (z. B. Datenbank), erreichbar über seinen `alias` |
| **Stage** | Station einer Pipeline; Stages laufen nacheinander, Jobs einer Stage parallel |
| **Tag** | Fester Name für einen Commit, z. B. ein Release |
| **Task** | Unteraufgabe/Checkliste in einem Issue |
| **Workflow** | Team-Vereinbarung über Branches, z. B. GitHub Flow, GitLab Flow, Trunk-Based, Git Flow |
