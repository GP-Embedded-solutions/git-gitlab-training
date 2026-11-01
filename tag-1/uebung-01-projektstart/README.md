# Übung 1 – Projektstart
**Tag 1 · 20 Minuten · einzeln im Seminar-Container**

🎯 **Ziel:** ein eigenes Repository `calc-service` mit sauberer Grundkonfiguration und zwei aussagekräftigen Commits.

## Aufgaben
1. Konfiguration prüfen. Im Seminar-Container hat `seminar-einrichten` Name und E-Mail bereits gesetzt:
   ```bash
   git config --global user.name
   git config --global user.email
   git config --list --show-origin      # Woher kommt welche Einstellung?
   ```
2. Startprojekt kopieren (`$SEMINAR` zeigt auf die Unterlagen, `~/seminar` ist Ihr Arbeitsordner):
   ```bash
   cp -r $SEMINAR/starter/calc-service ~/seminar/ && cd ~/seminar/calc-service
   ```
3. `git init`, dann `git status`: Was zeigt Git an?
4. Eine `.gitignore` anlegen mit: `__pycache__/`, `*.pyc`, `.pytest_cache/`, `.ruff_cache/`, `.venv/`, `.env`, `report.xml`, `.cache/`
5. `python -m pytest` ausführen, dann `git status`: Taucht `__pycache__` auf?
6. Zwei Commits: zuerst nur die `.gitignore` (`chore: gitignore`), dann den Rest (`feat: add() mit Test`).

✅ **Geschafft, wenn:** `git lg` zwei Commits mit Ihrem Namen zeigt und `git status` „nothing to commit“ meldet.

<details><summary>💡 Hinweis</summary>

Schon versehentlich `__pycache__` gestaged? `git rm -r --cached src/__pycache__ tests/__pycache__` und erneut committen.
</details>

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
