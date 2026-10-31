# Seminar-Voreinstellungen (wird bei jeder Shell geladen)
[ -n "${SEMINAR_GELADEN:-}" ] && return 0; export SEMINAR_GELADEN=1
export SEMINAR="${SEMINAR:-/unterlagen}"
[ -f "$HOME/.seminar-env" ] && . "$HOME/.seminar-env"
mkdir -p "$HOME/seminar" 2>/dev/null
# ssh-agent einmal pro Container, Schlüssel werden beim ersten Push automatisch geladen
if [ -z "${SSH_AUTH_SOCK:-}" ]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
  if ! ssh-add -l >/dev/null 2>&1 && [ "$?" != 1 ]; then
    rm -f "$SSH_AUTH_SOCK"; mkdir -p "$HOME/.ssh"; chmod 700 "$HOME/.ssh"
    ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null 2>&1
  fi
fi
__seminar_branch() { git branch --show-current 2>/dev/null | sed 's/.*/ (&)/'; }
PS1='\[\e[1;32m\]seminar\[\e[0m\]:\[\e[1;34m\]\w\[\e[33m\]$(__seminar_branch)\[\e[0m\]\$ '
if [ -z "${SEMINAR_BEGRUESST:-}" ] && [ -t 1 ]; then
  export SEMINAR_BEGRUESST=1
  echo "🧰 Seminar-Container Git & GitLab · Unterlagen: \$SEMINAR · Arbeitsordner: ~/seminar · Hilfe: seminar-hilfe"
fi
