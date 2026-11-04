# Übung 8 – Pipeline & Team-Merge-Requests
**Tag 2 · 50 Minuten · 👥 GEMEINSAM – Teil A als Staffellauf (wer dran ist, teilt den Bildschirm), Teil B im Team mit verteilten Rollen**

🎯 **Ziel:** gemeinsam eine CI-Pipeline aufbauen und Merge Requests mit echten Reviews, roter Pipeline und echtem Konflikt bis nach `main` bringen.

## Teil A – Pipeline als Staffellauf (ca. 7 Minuten pro Stufe)
Alle arbeiten auf dem Branch von Issue #1 (z. B. `1-ci-pipeline-einrichten`). Wer dran ist, teilt den Bildschirm. **Übergabe per Git:** fertig → `commit` + `push`; die nächste Person → `git fetch && git switch 1-ci-pipeline-einrichten && git pull`.

1. **Stufe 1 (Maintainer):** `cp $SEMINAR/ci-vorlagen/stufe1-hello.gitlab-ci.yml .gitlab-ci.yml` → commit → push → *Build → Pipelines*: Was steht im Job-Log?
2. **Stufe 2 (Dev A):** Datei durch `stufe2-test.gitlab-ci.yml` ersetzen → push → grün?
3. **Variablen (Maintainer, Browser):** *Settings → CI/CD → Variables → Add variable*:
   - `APP_ENV` = `staging`, Sichtbarkeit **Visible**
   - `DEMO_TOKEN` = `geheim-12345678`, Sichtbarkeit **Masked**
   - ⚠️ Bei **beiden** das Häkchen **„Protect variable“ entfernen** (es ist standardmäßig gesetzt). Geschützte Variablen gibt es nur auf geschützten Branches wie `main` – auf dem Branch `1-ci-pipeline-einrichten` stünde sonst „nicht gesetzt“ im Log.
4. **Stufe 3 (Dev B):** Datei durch `stufe3-lint-test.gitlab-ci.yml` ersetzen, `requirements.txt` auf `pytest`, `pytest-cov`, `ruff` erweitern.
   - **Vor dem Push** prüfen: `gitlab-ci-local --list` (Schema-Prüfung, geplante Jobs). Dann commit (`… (Closes #1)`) und push.
   - Wie viele Jobs laufen? Was gibt der Job `info` aus und wie erscheint `DEMO_TOKEN` im Log?
   - Wie lange braucht `test` beim ersten und beim zweiten Lauf? (Cache)
5. **Review:** Der Maintainer setzt den MR von *Draft* auf **Ready** (*Mark as ready*). Dev A kommentiert eine Zeile der `.gitlab-ci.yml` und klickt **Approve**. Der Maintainer merged.

## Teil B – Feature-MRs mit Review (Dev A und Dev B)
6. Zurück auf den eigenen Branch und die Pipeline übernehmen:
   ```bash
   git switch 2-funktion-multiply        # Dev B: 3-funktion-power
   git fetch && git rebase origin/main && git push --force-with-lease
   ```
7. **Dev B:** zuerst absichtlich einen falschen Test pushen (`assert power(2, 10) == 1000`). Pipeline rot → im MR das Test-Widget ansehen → korrigieren → push → grün.
8. Beide setzen ihre MRs auf **Ready**. **Review über Kreuz:** Dev B reviewt den MR von Dev A (Kommentar + Approve) → der Maintainer merged.
9. Jetzt meldet der MR von Dev B einen **Konflikt** (beide haben ans Dateiende geschrieben). Dev B löst ihn lokal:
   ```bash
   git fetch && git rebase origin/main      # CONFLICT in src/calc.py und tests/test_calc.py
   # beide Funktionen bzw. Tests behalten, Konfliktmarker entfernen
   # Achtung Import-Zeile im Test: daraus wird  from src.calc import add, multiply, power
   git add src/calc.py tests/test_calc.py && git rebase --continue
   python -m pytest && git push --force-with-lease
   ```
10. Dev A reviewt den MR von Dev B → der Maintainer merged. Die Issues #1, #2, #3 schließen sich automatisch.

✅ **Geschafft, wenn:** `main` `multiply()` und `power()` enthält, die Pipeline auf `main` grün ist und die Issues #1–#3 geschlossen sind.

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
