# Übung 1 – Projektstart
**Tag 1 · 20 Minuten · 👤 SELBST – jede/r allein im eigenen Seminar-Container**

🎯 **Ziel:** ein eigenes Repository `calc-service` mit sauberer Grundkonfiguration und zwei aussagekräftigen Commits.

## Aufgaben
1. **Konfiguration prüfen.** Im Seminar-Container hat `seminar-einrichten` Name und E-Mail bereits gesetzt:
   ```bash
   git config --global user.name        # → Ihr Name, z. B.  Max Muster
   git config --global user.email       # → Ihre E-Mail, z. B.  max.muster@firma.de
   git config --list --show-origin      # → jede Einstellung mit ihrer Herkunftsdatei, z. B.
                                        #   file:/home/seminar/.gitconfig   user.name=Max Muster
                                        #   file:/etc/gitconfig             alias.lg=log --oneline …
   ```
   Fehlt Name oder E-Mail? Dann `seminar-einrichten` ausführen.

2. **Startprojekt kopieren** (`$SEMINAR` = die Unterlagen, `~/seminar` = Ihr Arbeitsordner):
   ```bash
   cp -r $SEMINAR/starter/calc-service ~/seminar/ && cd ~/seminar/calc-service
   ```

3. **Repository anlegen:** `git init`, dann `git status`.
   Was zeigt Git an? (Erwartet: `No commits yet` und vier *Untracked files*.)

4. **Tests laufen lassen und genau hinsehen:**
   ```bash
   python -m pytest           # 1 passed
   git status -u              # -u zeigt auch jede einzelne Datei in Unterordnern
   ```
   Sie sehen jetzt `src/__pycache__/…pyc` und `tests/__pycache__/…pyc`. Diese Dateien erzeugt Python automatisch, sie gehören **nicht** ins Repository.
   > Warum `-u`? Ohne `-u` zeigt Git nur `src/` und `tests/` als Ganzes an, dann sieht man die `.pyc`-Dateien nicht.

5. **`.gitignore` anlegen** (z. B. mit `nano .gitignore`) mit diesem Inhalt:
   ```
   __pycache__/
   *.pyc
   .pytest_cache/
   .ruff_cache/
   .venv/
   .env
   report.xml
   .cache/
   ```
   Danach wieder `git status -u`: Die `.pyc`-Dateien sind verschwunden, neu ist `.gitignore`.

6. **Erster Commit, nur die `.gitignore`:**
   ```bash
   git add .gitignore                 # erst in den Karton (Staging) legen …
   git status                         # … prüfen: nur .gitignore ist grün
   git commit -m "chore: gitignore"   # … dann zukleben
   ```

7. **Zweiter Commit, der Rest:**
   ```bash
   git add .                          # alles Übrige stagen – .gitignore filtert den Müll
   git status                         # prüfen: kein __pycache__ in der Liste!
   git commit -m "feat: add() mit Test"
   ```

✅ **Geschafft, wenn:** `git lg` zwei Commits mit Ihrem Namen zeigt und `git status` „nothing to commit, working tree clean“ meldet.

<details><summary>💡 Hinweis</summary>

Schon versehentlich `__pycache__` gestaged oder committet? Aus Git entfernen (die Dateien bleiben auf der Platte) und neu committen:
```bash
git rm -r --cached src/__pycache__ tests/__pycache__
git commit -m "chore: __pycache__ entfernen"
```
</details>

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
