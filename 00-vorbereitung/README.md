# Vorbereitung – vor dem Seminar (ca. 30–45 Minuten)
Das Seminar findet **online** statt. Damit wir beide Tage voll für Praxis nutzen können, richten Sie vorab drei Dinge ein: **Ihren Seminar-Container**, **einen gitlab.com-Account** und **Ihren SSH-Schlüssel**. Im kurzen **Vorab-Termin** (Technik-Check, ca. 30 Min.) prüfen wir das gemeinsam.

## Schritt 1 – Arbeitsumgebung wählen
| Variante | Wann? | Sie brauchen |
|---|---|---|
| **A: Seminar-Container mit Docker** (empfohlen) | Sie dürfen Docker Desktop installieren | Docker Desktop (Windows/macOS) oder Docker Engine (Linux) |

Beides liefert **dieselbe Umgebung** mit allen Werkzeugen (git, Python, pytest, ruff, jq, SSH, Editoren, lazygit, gitlab-ci-local). Sonst müssen Sie **nichts** installieren.

### Docker
1. Docker Desktop installieren und starten: Hier der Link für die Installation auf ubuntu: [https://www.docker.com/products/docker-desktop/ (unter Windows mit WSL 2)](https://docs.docker.com/engine/install/ubuntu/). Hier der Link für die Installation von Docker Desktop auf windows: https://docs.docker.com/desktop/setup/install/windows-install/. Schließlich klicken Sie hier für die Installation auf macOS: https://docs.docker.com/desktop/setup/install/mac-install/
2. Dieses Repository herunterladen (`git clone [<URL>](https://github.com/GP-Embedded-solutions/git-gitlab-training.git)` oder ZIP über den Download-Button) und den Ordner öffnen
3. Container starten (beim ersten Mal wird er gebaut, das dauert ca. 3–5 Minuten):
   ```bash
   ./container/seminar-start.sh           # macOS / Linux / Git Bash
   .\container\seminar-start.ps1          # Windows PowerShell
   ```
   Sie sehen die Begrüßung `🧰 Seminar-Container Git & GitLab`. Beenden mit `exit`. **Ihre Arbeit bleibt erhalten.**


### So ist der Container aufgebaut
| Ort | Inhalt |
|---|---|
| `~/seminar` | Ihr Arbeitsordner – **anfangs leer**, hier entstehen Ihre Übungsprojekte |
| `$SEMINAR` (= `/unterlagen`) | diese Unterlagen, nur lesend. Anschauen mit `ls $SEMINAR` |
| `seminar-einrichten`, `seminar-check`, `seminar-hilfe` | Seminar-Befehle, überall aufrufbar |

## Schritt 2 – gitlab.com-Account
1. Kostenlosen Account anlegen: https://gitlab.com/users/sign_up
2. Falls gitlab.com eine **Identitätsprüfung** anbietet (Telefon oder Kreditkarte, es wird nichts abgebucht): bitte durchführen, sonst können Ihre Pipelines an Tag 2 nicht starten.
3. Ihren **gitlab.com-Benutzernamen** an den Trainer schicken. Sie werden in die Seminar-Gruppe eingeladen.

## Schritt 3 – Einrichten im Container
Alle folgenden Befehle geben Sie **im Container** ein (Eingabezeile beginnt mit `seminar@seminar`):
```bash
seminar-einrichten
```
Das Skript fragt nach Name, E-Mail und dem **Gruppenpfad** (bekommen Sie vom Trainer), erzeugt Ihren SSH-Schlüssel (bitte eine **Passphrase** wählen) und zeigt den **öffentlichen Schlüssel** an.
→ Diesen auf gitlab.com hinterlegen: *Profilbild → Edit profile → SSH Keys → Add new key* (mit Ablaufdatum).

## Schritt 4 – Prüfen
```bash
seminar-check
```
Alles grün (`🎉 Alles bereit fürs Seminar!`)? Perfekt. Ein ❌? Die Meldung sagt, was zu tun ist. Sonst klären wir es im Vorab-Termin.

## Schritt 5 – Online-Arbeitsplatz
- [ ] **Zweiter Bildschirm** (sehr empfohlen): Videokonferenz auf dem einen, Terminal auf dem anderen
- [ ] **Headset** und stabile Internetverbindung, Kamera möglichst an
- [ ] Bildschirm teilen in der Videokonferenz einmal ausprobieren (in Übungen teilen Sie Ihr Terminal)
- [ ] Links zum Online-Whiteboard und zum Quiz kommen vom Trainer per Mail

**Firmen-Laptop?** Bitte vorab mit der IT klären: Docker Desktop erlaubt? Zugriff auf gitlab.com (HTTPS und SSH, Port 22 oder 443)? Bei Problemen ist das private Laptop stark empfohlen.
