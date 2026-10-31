#!/usr/bin/env bash
# Startet den Seminar-Container. Optionen: --docker (Docker-Zugriff, Übung 9) · --neu-bauen
set -euo pipefail
HIER="$(cd "$(dirname "$0")" && pwd)"; REPO="$(cd "$HIER/.." && pwd)"
IMAGE=git-seminar; DOCKER_ARGS=(); BAUEN=0
for a in "$@"; do
  case "$a" in
    --docker)   DOCKER_ARGS=(-v /var/run/docker.sock:/var/run/docker.sock) ;;
    --neu-bauen) BAUEN=1 ;;
    -h|--help)  echo "Usage: $0 [--docker] [--neu-bauen]"; exit 0 ;;
    *) echo "Unbekannte Option: $a"; exit 1 ;;
  esac
done
command -v docker >/dev/null || { echo "❌ Docker nicht gefunden. Docker Desktop installieren und starten (oder Codespaces nutzen)."; exit 1; }
docker info >/dev/null 2>&1 || { echo "❌ Docker läuft nicht. Bitte Docker Desktop starten."; exit 1; }
if [ $BAUEN = 1 ] || ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
  echo "🔨 Baue den Seminar-Container (beim ersten Mal 3–5 Minuten) …"
  docker build -t "$IMAGE" "$HIER"
fi
exec docker run -it --rm --name git-seminar --hostname seminar \
  -v git-seminar-home:/home/seminar \
  -v "$REPO":/unterlagen:ro \
  "${DOCKER_ARGS[@]}" "$IMAGE"
