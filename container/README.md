# Seminar-Container
Eine fertige Linux-Umgebung mit allen Werkzeugen für beide Seminartage. Sie läuft auf Windows, macOS (Intel und Apple-Chip) und Linux.

| Datei | Zweck |
|---|---|
| `seminar-start.sh` / `seminar-start.ps1` | Container starten (baut beim ersten Mal automatisch). Optionen: `--docker` / `-Docker` (Docker-Zugriff für Übung 9), `--neu-bauen` / `-NeuBauen` |
| `Dockerfile` | Bauplan des Containers (Basis: Ubuntu 24.04) |
| `files/` | Befehle `seminar-einrichten`, `seminar-check`, `seminar-hilfe` und Voreinstellungen für Git und die Shell |
| `../.devcontainer/devcontainer.json` | dieselbe Umgebung für GitHub Codespaces und VS Code Dev Containers |

**Was bleibt erhalten?** Alles in `/home/seminar` (Docker-Volume `git-seminar-home`): Ihre Übungsprojekte, SSH-Schlüssel, Git-Konfiguration.
**Die Unterlagen** (dieses Repository) liegen im Container unter `$SEMINAR` (nur lesend).
**Komplett zurücksetzen:** `docker volume rm git-seminar-home` (löscht Ihre Übungsdaten!).

**Enthalten:** git · Python 3 mit pytest, pytest-cov, ruff · jq · curl · OpenSSH · nano, neovim, tig, lazygit · Node.js 22 mit gitlab-ci-local · Docker-Client
