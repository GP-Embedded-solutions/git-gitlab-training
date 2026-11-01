#!/usr/bin/env bash
# Startet den Seminar-Container. Optionen: --docker (Docker-Zugriff, Übung 9) · --neu-bauen
# Baut automatisch neu, wenn sich Dockerfile oder files/ geändert haben.
set -euo pipefail
HIER="$(cd "$(dirname "$0")" && pwd)"; REPO="$(cd "$HIER/.." && pwd)"
IMAGE=git-seminar; DOCKER_ARGS=(); BAUEN=0
for a in "$@"; do
  case "$a" in
    --docker)    DOCKER_ARGS=(-v /var/run/docker.sock:/var/run/docker.sock) ;;
    --neu-bauen) BAUEN=1 ;;
    -h|--help)   echo "Usage: $0 [--docker] [--neu-bauen]"; exit 0 ;;
    *) echo "Unbekannte Option: $a"; exit 1 ;;
  esac
done
command -v docker >/dev/null || { echo "❌ Docker nicht gefunden. Docker Desktop installieren und starten (oder Codespaces nutzen)."; exit 1; }
docker info >/dev/null 2>&1 || { echo "❌ Docker läuft nicht. Bitte Docker Desktop starten."; exit 1; }

# Fingerabdruck der Bauanleitung (Linux: sha256sum, macOS: shasum)
STAND=$(cat "$HIER/Dockerfile" "$HIER"/files/* | { sha256sum 2>/dev/null || shasum -a 256; } | cut -c1-12)
AKTUELL=$(docker image inspect -f '{{ index .Config.Labels "seminar.stand" }}' "$IMAGE" 2>/dev/null || true)
if [ $BAUEN = 1 ] || [ "$AKTUELL" != "$STAND" ]; then
  [ -n "$AKTUELL" ] && echo "🔄 Unterlagen wurden aktualisiert – baue den Container neu …" \
                    || echo "🔨 Baue den Seminar-Container (beim ersten Mal 3–5 Minuten) …"
  docker build --label "seminar.stand=$STAND" -t "$IMAGE" "$HIER"
fi

# ${arr[@]+…}: leeres Array ist mit set -u auch in macOS-Bash 3.2 erlaubt
exec docker run -it --rm --name git-seminar --hostname seminar \
  -v git-seminar-home:/home/seminar \
  -v "$REPO":/unterlagen:ro \
  ${DOCKER_ARGS[@]+"${DOCKER_ARGS[@]}"} "$IMAGE"
