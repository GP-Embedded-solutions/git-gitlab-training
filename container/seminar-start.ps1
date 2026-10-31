# Startet den Seminar-Container unter Windows. Optionen: -Docker (Docker-Zugriff, Übung 9) · -NeuBauen
param([switch]$Docker, [switch]$NeuBauen)
$ErrorActionPreference = "Continue"
$Hier = $PSScriptRoot; $Repo = (Resolve-Path "$Hier\..").Path; $Image = "git-seminar"
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) { Write-Host "Docker nicht gefunden. Docker Desktop installieren und starten (oder Codespaces nutzen)." -ForegroundColor Red; exit 1 }
docker info *> $null
if ($LASTEXITCODE -ne 0) { Write-Host "Docker laeuft nicht. Bitte Docker Desktop starten." -ForegroundColor Red; exit 1 }
docker image inspect $Image *> $null
if ($NeuBauen -or $LASTEXITCODE -ne 0) {
  Write-Host "Baue den Seminar-Container (beim ersten Mal 3-5 Minuten) ..."
  docker build -t $Image $Hier
  if ($LASTEXITCODE -ne 0) { exit 1 }
}
$args2 = @("run","-it","--rm","--name","git-seminar","--hostname","seminar","-v","git-seminar-home:/home/seminar","-v","${Repo}:/unterlagen:ro")
if ($Docker) { $args2 += @("-v","/var/run/docker.sock:/var/run/docker.sock") }
$args2 += $Image
docker @args2
