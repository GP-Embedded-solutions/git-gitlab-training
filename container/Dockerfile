# Seminar-Container „Git & GitLab Professional“
FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_MAJOR=22
ARG LAZYGIT_VERSION=0.44.1

RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates curl gnupg git openssh-client sudo less locales tzdata \
      python3 python3-pip python3-venv jq nano neovim tig bash-completion rsync \
      docker.io docker-buildx \
 && sed -i 's/# de_DE.UTF-8/de_DE.UTF-8/' /etc/locale.gen && locale-gen \
 && rm -rf /var/lib/apt/lists/*

# Node.js 22 (gitlab-ci-local braucht >= 20) + gitlab-ci-local
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash - \
 && apt-get install -y --no-install-recommends nodejs && rm -rf /var/lib/apt/lists/* \
 && npm install -g gitlab-ci-local && npm cache clean --force

# lazygit (amd64 / arm64)
RUN ARCH=$(dpkg --print-architecture | sed 's/amd64/x86_64/') \
 && curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${ARCH}.tar.gz" \
    | tar -xz -C /usr/local/bin lazygit

RUN pip3 install --no-cache-dir --break-system-packages pytest pytest-cov ruff

# Benutzer „seminar“ (Docker-Gruppe für Übung 9)
RUN userdel -r ubuntu 2>/dev/null; useradd -m -s /bin/bash -u 1000 seminar \
 && usermod -aG docker seminar \
 && echo 'seminar ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/seminar

COPY files/seminar-einrichten files/seminar-check files/seminar-hilfe /usr/local/bin/
COPY files/bashrc-seminar.sh /etc/profile.d/seminar.sh
COPY files/gitconfig-system /etc/gitconfig
# Rechte fest setzen: COPY übernimmt sonst die Rechte des Host-Systems (z. B. 600 nach dem Entpacken)
RUN chmod 755 /usr/local/bin/seminar-* \
 && chmod 644 /etc/profile.d/seminar.sh /etc/gitconfig \
 && echo '. /etc/profile.d/seminar.sh' >> /etc/bash.bashrc

# Arbeitsstand merken: Nach jedem Befehl werden Ordner, selbst gesetzte Variablen (export …) und der
# Befehlsverlauf in /home/seminar gesichert (Volume). Nach `exit` oder einem geschlossenen Fenster stellt
# der nächste Start alles wieder her. Geheimnisse (Name enthält TOKEN, PASS, SECRET, KEY) werden nie gespeichert.
COPY <<'ZUSTAND' /etc/profile.d/zz-seminar-zustand.sh
case $- in *i*) ;; *) return 0 ;; esac
[ -n "${__SEM_AKTIV:-}" ] && return 0; __SEM_AKTIV=1
shopt -s histappend; HISTSIZE=10000; HISTFILESIZE=20000; HISTCONTROL=ignoredups
HISTIGNORE='*TOKEN=*:*PASSWORD=*:*SECRET=*'
[ -f "$HOME/.seminar-zustand" ] && . "$HOME/.seminar-zustand"
__SEM_WIEDER=" $(sed -n 's/^export \([A-Za-z_][A-Za-z0-9_]*\)=.*/\1/p' "$HOME/.seminar-zustand" "$HOME/.seminar-env" 2>/dev/null | tr '\n' ' ') "
__SEM_BASIS=""
__seminar_merken() {
  history -a
  [ -d "$PWD" ] && printf '%s\n' "$PWD" > "$HOME/.seminar-ordner"
  local n z=""
  if [ -z "$__SEM_BASIS" ]; then
    __SEM_BASIS=" "
    for n in $(compgen -e); do case "$__SEM_WIEDER" in *" $n "*) ;; *) __SEM_BASIS+="$n " ;; esac; done
  fi
  for n in $(compgen -e); do
    case "$__SEM_BASIS" in *" $n "*) continue ;; esac
    case "$n" in PWD|OLDPWD|SHLVL|_|SSH_AUTH_SOCK|SSH_AGENT_PID|SEMINAR_*|LINES|COLUMNS|HIST*|PS1) continue ;; esac
    case "${n^^}" in *TOKEN*|*PASS*|*SECRET*|*KEY*|*PRIVATE*) continue ;; esac
    z+="export $n=$(printf '%q' "${!n}")"$'\n'
  done
  ( umask 077; printf '%s' "$z" > "$HOME/.seminar-zustand.tmp" ) && mv -f "$HOME/.seminar-zustand.tmp" "$HOME/.seminar-zustand"
}
PROMPT_COMMAND="__seminar_merken${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
if [ "$PWD" = "$HOME" ] && [ -f "$HOME/.seminar-ordner" ]; then
  __sem_o="$(cat "$HOME/.seminar-ordner")"
  if [ -d "$__sem_o" ] && [ "$__sem_o" != "$HOME" ] && cd "$__sem_o"; then
    echo "   ↩ Weiter im letzten Ordner: ${PWD/#$HOME/\~}"
  fi
  unset __sem_o
fi
ZUSTAND
RUN chmod 644 /etc/profile.d/zz-seminar-zustand.sh \
 && echo '. /etc/profile.d/zz-seminar-zustand.sh' >> /etc/bash.bashrc

ENV LANG=de_DE.UTF-8 SEMINAR=/unterlagen EDITOR=nano
USER seminar
WORKDIR /home/seminar
CMD ["bash", "-l"]
