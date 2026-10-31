# CI-Vorlagen
Die Pipeline von `calc-service` in vier Ausbaustufen (Übungen 8 und 9). Kopieren Sie die jeweilige Stufe als `.gitlab-ci.yml` in Ihr Projekt.

| Datei | Stufe | Neu in dieser Stufe |
|---|---|---|
| `stufe1-hello.gitlab-ci.yml` | 1 | erster Job, vordefinierte Variablen |
| `stufe2-test.gitlab-ci.yml` | 2 | Tests bei jedem Push |
| `stufe3-lint-test.gitlab-ci.yml` | 3 | Lint, Matrix-Tests, Coverage, Test-Report, Cache, eigene Variablen, workflow-rules |
| `stufe4-container.gitlab-ci.yml` | 4 | Integrationstest mit PostgreSQL-Service, Docker-Image bauen (nur main und Tags) |
| `Dockerfile` | – | Image für `calc-service` (Übung 9) |

💡 Vor dem Push prüfen: `gitlab-ci-local --list` validiert gegen das offizielle GitLab-Schema und zeigt die geplanten Jobs.
