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
RUN chmod 755 /usr/local/bin/seminar-* \
 && chmod 644 /etc/profile.d/seminar.sh /etc/gitconfig \
 && echo '. /etc/profile.d/seminar.sh' >> /etc/bash.bashrc

ENV LANG=de_DE.UTF-8 SEMINAR=/unterlagen EDITOR=nano
USER seminar
WORKDIR /home/seminar
CMD ["bash", "-l"]
