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
# Der Container laeuft dauerhaft im Hintergrund (sleep infinity) - exit oder ein geschlossenes Fenster beendet
# nur die Shell, nicht den Container. Jedes Fenster schaltet sich mit "docker exec" dazu.
$Name = "git-seminar"
docker container inspect $Name *> $null; $existiert = ($LASTEXITCODE -eq 0)
if ($existiert -and ($NeuBauen -or ($Docker -and -not ((docker container inspect -f '{{range .Mounts}}{{.Destination}} {{end}}' $Name) -match "docker.sock")))) {
  docker rm -f $Name *> $null; $existiert = $false     # neu anlegen - Ihre Dateien bleiben im Volume
}
if (-not $existiert) {
  $args2 = @("run","-d","--init","--name",$Name,"--hostname","seminar","--restart","unless-stopped","-v","git-seminar-home:/home/seminar","-v","${Repo}:/unterlagen:ro")
  if ($Docker) { $args2 += @("-v","/var/run/docker.sock:/var/run/docker.sock") }
  $args2 += @($Image,"sleep","infinity")
  docker @args2 *> $null
} elseif ((docker container inspect -f '{{.State.Running}}' $Name) -ne "true") {
  docker start $Name *> $null
}
docker exec -it $Name bash -l
