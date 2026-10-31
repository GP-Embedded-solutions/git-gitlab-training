# Übung 10 – Team-Release v1.0.0
**Tag 2 · 20 Minuten · alle, getauschte Rollen, ohne Hilfe des Trainers**

🎯 **Ziel:** ein Feature vom Issue bis zum automatisch gebauten Release bringen.

| Rolle | Aufgabe |
|---|---|
| **Dev A** – Entwickler:in | Issue #5 `modulo()` umsetzen |
| **Maintainer** – Reviewer:in | Review, Approve, Merge |
| **Dev B** – **Release-Manager:in** | Changelog, Tag, Release (teilt den Bildschirm) |

## Ablauf
1. **Dev A:** Issue #5 → *Create merge request* → `modulo(a, b)` mit `ValueError` bei `b == 0` und zwei Tests → Conventional Commit (`feat: modulo() (Closes #5)`) → push → MR auf *Ready*
2. **Maintainer:** Review mit mindestens einem Kommentar → Approve → Merge (nur wenn die Pipeline grün ist!)
3. **Dev B:** neuen Stand holen und das Release vorbereiten:
   ```bash
   git switch main && git pull
   git switch -c chore/changelog-v1.0.0
   # CHANGELOG.md anlegen: v1.0.0 – add, divide, multiply, power, modulo, CI-Pipeline, Docker-Image
   git add CHANGELOG.md && git commit -m "docs: Changelog für v1.0.0"
   git push -u origin chore/changelog-v1.0.0
   ```
   → MR → der Maintainer merged.
4. **Dev B:** Release-Tag setzen:
   ```bash
   git switch main && git pull
   git tag -a v1.0.0 -m "Release 1.0.0"
   git push origin v1.0.0
   ```
5. **Alle:** Die Tag-Pipeline beobachten: `build-image` baut `calc-service:v1.0.0`.
6. **Dev B:** *Deploy → Releases → New release* aus Tag `v1.0.0`, Release Notes aus dem Changelog übernehmen, Milestone `v1.0` verknüpfen.
7. **Alle:** Milestone `v1.0` ansehen: alle Issues geschlossen? → Milestone schließen. 🏆

## Runner-Rätsel (Bonus, falls Zeit)
Eine Pipeline hängt seit 10 Minuten auf **pending**. Nennen Sie drei mögliche Ursachen und wo Sie in GitLab nachsehen.

✅ **Geschafft, wenn:** der Tag `v1.0.0` existiert, das Release angelegt ist und die Tag-Pipeline das Image gebaut hat.

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
