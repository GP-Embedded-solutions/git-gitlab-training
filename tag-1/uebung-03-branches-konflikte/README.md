# Übung 3 – Branches & Konflikte
**Tag 1 · 40 Minuten · Teil A 👤 SELBST (einzeln), Teil B 👥 ZU ZWEIT im Breakout-Raum**

🎯 **Ziel:** im eigenen Projekt mit Branches und Tags arbeiten; einen Konflikt einmal per Merge und einmal per Rebase lösen.

## Teil A – Feature im calc-service (einzeln)
1. `cd ~/seminar/calc-service && git switch -c feature/divide`
2. In `src/calc.py` ergänzen:
   ```python
   def divide(a: float, b: float) -> float:
       if b == 0:
           raise ValueError("Division durch 0")
       return a / b
   ```
   und in `tests/test_calc.py` zwei Tests (normale Division und `pytest.raises(ValueError)` bei Division durch 0, `import pytest` nicht vergessen).
3. `python -m pytest` grün → Commit `feat: divide() mit Schutz vor Division durch 0`
4. Nach `main` mergen. War es ein Fast-Forward? Warum?
5. Branch löschen und einen annotierten Tag setzen: `git tag -a v0.1.0 -m "Release 0.1.0"`

## Teil B – Konflikt (zu zweit: eine Person teilt den Bildschirm, die andere navigiert)
1. `cd ~/seminar && bash $SEMINAR/tag-1/uebung-03-branches-konflikte/setup.sh && cd konflikt` und `git lg` ansehen
2. `git merge feature/perf`: Konflikt in `config.ini`. Entscheiden Sie gemeinsam: Welcher Timeout ist richtig? (Kompromiss: `timeout = 30`)
3. Lösen → `git add config.ini` → `git commit`. Graph ansehen.
4. Zurück auf Anfang: `git reset --hard HEAD~1`
5. Jetzt per Rebase: `git switch feature/perf && git rebase main` → lösen → `git add` → `git rebase --continue`
   > Meldet Git `Resolved 'config.ini' using previous resolution`? Dann hat sich Git Ihre Lösung aus Schritt 3 gemerkt (`rerere`). Prüfen mit `cat config.ini`, dann trotzdem `git add config.ini` und `git rebase --continue`.
6. Vergleichen Sie beide Graphen: Welche Historie würden Sie in einem Jahr lieber lesen?

✅ **Geschafft, wenn:** `calc-service` den Tag `v0.1.0` trägt und Sie beide Konfliktwege gegangen sind.

**Bonus:** drei kleine Commits erzeugen und mit `git rebase -i HEAD~3` zu einem zusammenfassen.

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
