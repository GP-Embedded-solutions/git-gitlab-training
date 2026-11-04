# Übung 6 – Sichtbarkeit, Teilen, Tokens & Keys
**Tag 2 · 25 Minuten · 👥 GEMEINSAM mit verteilten Rollen (Teil B: 👤 jede/r selbst)**

🎯 **Ziel:** Projekte bewusst teilen und Maschinen sicher Zugriff geben: mit Token, Deploy Token und Deploy Key.

> 🔒 **Tokens und Schlüssel nur per Direktnachricht weitergeben, nie in den Gruppenchat.** Chat-Verläufe werden gespeichert und durchsucht.

## Teil A – Sichtbarkeit & Teilen (Maintainer teilt den Bildschirm)
1. *Settings → General → Visibility*: Welche Stufen bietet gitlab.com an? (Private · Public; **Internal** gibt es nur auf eigenen GitLab-Instanzen.) Das Projekt bleibt **Private**.
2. *Manage → Members → Invite a group*: Projekt mit der Gruppe `$GRUPPE` als **Reporter** teilen. Wer sieht es jetzt?

## Teil B – Personal Access Token & API (alle)
3. *Edit profile → Access tokens → Add new token*: Name „api-reader“, Scope **`read_api`**, Ablauf in **7 Tagen**.
4. API abfragen, ohne dass der Token in der Shell-History landet:
   ```bash
   read -rs GITLAB_TOKEN && export GITLAB_TOKEN        # Token einfügen, Enter (unsichtbar)
   G=https://gitlab.com/api/v4
   P=$(printf %s "$GRUPPE/backend/calc-service" | jq -sRr @uri)
   curl -s -H "PRIVATE-TOKEN: $GITLAB_TOKEN" "$G/projects?membership=true&simple=true" | jq -r '.[].path_with_namespace'
   curl -s -H "PRIVATE-TOKEN: $GITLAB_TOKEN" "$G/projects/$P/members/all" | jq -r '.[] | "\(.username): \(.access_level)"'
   ```
   Welche Zahl steht für welche Rolle? (10, 20, 30, 40, 50)

## Teil C – Deploy Token (Maintainer legt an, Dev A nutzt)
5. Maintainer: *Settings → Repository → Deploy tokens*: Name „build-server“, Scope **`read_repository`**. Benutzername und Token **per Direktnachricht** an Dev A.
6. Dev A spielt den Build-Server:
   ```bash
   read -rp "Deploy-Benutzer: " DU && read -rs -p "Deploy-Token: " DT && echo
   git clone "https://$DU:$DT@gitlab.com/$GRUPPE/backend/calc-service.git" /tmp/build-server
   cd /tmp/build-server && echo test >> README.md && git commit -qam test && git push   # sollte scheitern. Warum?
   ```

## Teil D – Deploy Key (Dev B erzeugt, Maintainer hinterlegt)
7. Dev B erzeugt einen eigenen Schlüssel **nur für einen Server**:
   `ssh-keygen -t ed25519 -f ~/.ssh/deploy_calc -N "" -C "deploy-calc"` und schickt `~/.ssh/deploy_calc.pub` per Direktnachricht an den Maintainer.
8. Maintainer: *Settings → Repository → Deploy keys → Add new key*, **ohne** „Grant write permissions“.
9. Dev B klont damit:
   ```bash
   GIT_SSH_COMMAND="ssh -i ~/.ssh/deploy_calc -o IdentitiesOnly=yes" \
     git clone git@gitlab.com:$GRUPPE/backend/calc-service.git /tmp/deploy-server
   ```

## Reflexion (Chat, 2')
Eine Kollegin verlässt die Firma. Was passiert mit (a) ihrem Personal Access Token, (b) dem Deploy Token, (c) dem Deploy Key? Was heißt das für nächtliche Deployments?

✅ **Geschafft, wenn:** alle per API ihre Projekte auflisten können und der Push des Build-Servers wie erwartet abgelehnt wurde.

---
💡 Hängen geblieben? Erst `git status` und `git lg`, dann [FAQ](../../nachschlagen/faq.md). Status auf 🟡 oder 🔴 setzen, Hilfe kommt.

[Tagesübersicht](../README.md)
