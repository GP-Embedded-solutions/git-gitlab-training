#!/usr/bin/env bash
# Git-Grundkonfiguration wie im Seminar-Container – für Ihren eigenen Rechner nach dem Seminar.
set -e
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global rerere.enabled true
git config --global alias.st "status -sb"
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.unstage "restore --staged"
git config --global alias.amend "commit --amend --no-edit"
echo "✅ Aliases st, lg, unstage, amend und Grundeinstellungen gesetzt. Jetzt noch user.name und user.email setzen."
