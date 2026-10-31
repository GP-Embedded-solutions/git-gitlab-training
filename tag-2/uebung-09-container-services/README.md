# Übung 9 – Container, Services & Tests
**Tag 2 · 25 Minuten · Teil A alle mit Docker, Teil B Maintainer teilt den Bildschirm**

🎯 **Ziel:** das Projekt als Container bauen und die Pipeline um einen Service-Container (Datenbank) und den Image-Build erweitern.

## Teil A – Lokal bauen (wer den Container mit `--docker` gestartet hat)
`seminar-check` zeigt „Docker verfügbar“? Dann mitmachen. Sonst bei einer anderen Person zuschauen, die Pipeline in Teil B baut das Image trotzdem.
1. Im Team-Klon auf den neuesten Stand: `git switch main && git pull`
2. Image bauen und starten (mit podman: `docker` durch `podman` ersetzen):
   ```bash
   cp $SEMINAR/ci-vorlagen/Dockerfile .
   docker build -t calc-service:lokal .
   docker run --rm calc-service:lokal          # → calc-service ok: 5 1024
   ```
   Fragen: Wie groß ist das Image (`docker images calc-service`)? Was landet im Image, was nicht?
3. Die Datei wieder entfernen (`rm Dockerfile`), denn der Maintainer bringt sie gleich per MR ins Projekt.

## Teil B – Pipeline erweitern (Issue #4)
4. Maintainer: Issue #4 → *Create merge request* → `git fetch && git switch <branch>`
5. `cp $SEMINAR/ci-vorlagen/stufe4-container.gitlab-ci.yml .gitlab-ci.yml && cp $SEMINAR/ci-vorlagen/Dockerfile .` → commit `ci: Service-Test und Image-Build (Closes #4)` → push
6. Im MR die Pipeline ansehen (alle):
   - Job **`db-check`**: Wo kommt die Datenbank her? Was bedeutet `alias: db`?
   - Job **`build-image`** fehlt. Warum? (Tipp: `rules`)
   - **Test-Report:** Wo sehen Sie im MR die Anzahl der Tests und die Coverage?
7. Review durch Dev B (Approve) → Merge durch den Maintainer → Pipeline auf `main`: Jetzt läuft `build-image`. Log ansehen.

## Teil C – Auto DevOps einordnen (Gespräch, 3')
*Settings → CI/CD → Auto DevOps* ansehen (**nicht** aktivieren). Was würde Auto DevOps für uns erledigen, und warum haben wir trotzdem eine eigene Pipeline?

✅ **Geschafft, wenn:** die Pipeline auf `main` mit `db-check` und `build-image` grün ist.

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
