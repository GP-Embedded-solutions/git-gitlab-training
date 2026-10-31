# Übung 5 – Team-Projekt in GitLab aufsetzen
**Tag 2 · 40 Minuten · alle, mit verteilten Rollen** (siehe [Rollen](../README.md#ihre-rollen-im-team-projekt))

🎯 **Ziel:** ein gemeinsames GitLab-Projekt mit sauberen Rollen, SSH-Zugang und geschütztem `main`.

## Alle: SSH-Schlüssel prüfen und absichern (10')
```bash
ssh-keygen -lf ~/.ssh/id_ed25519.pub     # Fingerabdruck – vergleichen mit gitlab.com → Edit profile → SSH Keys
ssh -T git@gitlab.com                     # "Welcome to GitLab, @…!"
cat ~/.ssh/config                         # Port 443 (altssh)? Dann sperrt Ihr Netz Port 22.
```
Noch keine Passphrase? Jetzt setzen: `ssh-keygen -p -f ~/.ssh/id_ed25519`

## Maintainer: Projekt anlegen & Mitglieder einladen
1. gitlab.com → Gruppe `$GRUPPE` → Subgruppe `backend` → **New project → Create blank project**: Name `calc-service`, Sichtbarkeit **Private**, **ohne** README.
2. Das eigene `calc-service` von gestern hochladen:
   ```bash
   cd ~/seminar/calc-service
   git remote add origin git@gitlab.com:$GRUPPE/backend/calc-service.git
   git push -u origin main --tags
   ```
3. *Manage → Members → Invite members*: **Dev A** als **Developer**, **Dev B** als **Reporter** (mit Ablaufdatum!).

## Dev A & Dev B: klonen und Rechte testen
4. Klonen:
   ```bash
   cd ~/seminar && git clone git@gitlab.com:$GRUPPE/backend/calc-service.git team-calc && cd team-calc
   ```
5. Beide: kleine Änderung in der `README.md` auf einem Branch `test/<vorname>` committen und pushen.
   - Dev B (Reporter) wird **abgelehnt**. Warum? → Der Maintainer ändert Dev B auf **Developer** → erneut pushen.

## Maintainer: zentrale Projekteinstellungen
6. *Settings → Repository → Protected branches*: `main` – **Allowed to merge: Maintainers**, **Allowed to push and merge: No one**
7. *Settings → Merge requests*: „Pipelines must succeed“ ✔ · „Delete source branch“ als Standard ✔ · Merge-Methode: *Merge commit* (Diskussion: Was würde *Fast-forward* ändern?)
8. *Settings → General*: Projektbeschreibung setzen.

## Alle: Schutz testen
9. Direkt auf `main` committen und pushen → **abgelehnt** („not allowed to push code to protected branches“). 🎉
10. Commit auf einen Branch retten:
    ```bash
    git switch -c fix/<vorname>-readme
    git switch main && git reset --hard origin/main
    git switch fix/<vorname>-readme && git push -u origin fix/<vorname>-readme
    ```
11. Aufräumen: `git switch main`, eigene Test-Branches löschen: `git push origin --delete test/<vorname> fix/<vorname>-readme` und lokal `git branch -D …`

✅ **Geschafft, wenn:** alle per SSH pushen können, Dev A und Dev B Developer sind und ein Push auf `main` für alle abgelehnt wird.

> **Allein nachüben:** Auf gitlab.com eine eigene Gruppe mit Subgruppe `backend` anlegen und die Rollen gedanklich mitgehen. Rechte testen geht mit einem zweiten Account.

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
