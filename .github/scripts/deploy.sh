#!/usr/bin/env bash
# Deploy do site (raiz do repositório) para o servidor via rsync sobre SSH.
# Variáveis vêm dos Secrets do GitHub (repositório ou Environment):
#   SSH_HOST     (obrigatório)  ex.: servidor.exemplo.com
#   SSH_USER     (obrigatório)  ex.: deploy
#   SSH_KEY      (obrigatório)  chave PRIVADA SSH dedicada ao deploy
#   DEPLOY_PATH  (obrigatório)  ex.: /var/www/aquazen
#   SSH_PORT     (opcional, padrão 22)
set -euo pipefail

if [ -z "${SSH_HOST:-}" ] || [ -z "${SSH_USER:-}" ] || [ -z "${SSH_KEY:-}" ] || [ -z "${DEPLOY_PATH:-}" ]; then
  echo "::warning::Secrets do ambiente não configurados (SSH_HOST/SSH_USER/SSH_KEY/DEPLOY_PATH)."
  echo "Pulei o deploy. Configure os secrets do repositório/environment para ativar a publicação."
  exit 0
fi

# Remove espaços/quebras de linha nas pontas (erro comum ao colar o valor do
# secret no GitHub) e prefixos/sufixos que não fazem parte do hostname.
trim() {
  local s="$1"
  s="${s#"${s%%[![:space:]]*}"}"
  s="${s%"${s##*[![:space:]]}"}"
  printf '%s' "$s"
}
SSH_HOST="$(trim "$SSH_HOST")"
SSH_USER="$(trim "$SSH_USER")"
SSH_PORT="$(trim "${SSH_PORT:-}")"
DEPLOY_PATH="$(trim "$DEPLOY_PATH")"
SSH_HOST="${SSH_HOST#*://}"   # remove "ssh://", "http://" etc, se colado por engano
SSH_HOST="${SSH_HOST%%/*}"    # remove qualquer caminho/barra final após o host
SSH_HOST="${SSH_HOST%:*}"     # remove ":porta" se veio embutido no host

echo "Diagnóstico (sem expor os valores): SSH_HOST tem ${#SSH_HOST} caractere(s), SSH_USER tem ${#SSH_USER} caractere(s)."

PORT="${SSH_PORT:-22}"

# Prepara a chave e o known_hosts
mkdir -p ~/.ssh
chmod 700 ~/.ssh
printf '%s\n' "$SSH_KEY" > ~/.ssh/id_deploy
chmod 600 ~/.ssh/id_deploy
ssh-keyscan -p "$PORT" -H "$SSH_HOST" >> ~/.ssh/known_hosts 2>/dev/null || true
chmod 600 ~/.ssh/known_hosts

SSH_OPTS="-i $HOME/.ssh/id_deploy -p ${PORT} -o StrictHostKeyChecking=accept-new -o ConnectTimeout=30"
REMOTE="${SSH_USER}@${SSH_HOST}"

echo "Publicando em ${REMOTE}:${DEPLOY_PATH} (porta ${PORT})"

# Garante que o diretório de destino exista (rsync antigo não cria subpastas).
ssh $SSH_OPTS "$REMOTE" "mkdir -p '${DEPLOY_PATH}'"

# Sincroniza a raiz do repositório, exceto metadados de git/CI.
if command -v rsync >/dev/null 2>&1 && \
   rsync -avz --delete \
     --exclude='.git/' --exclude='.github/' \
     -e "ssh ${SSH_OPTS}" ./ "${REMOTE}:${DEPLOY_PATH}/"; then
  echo "Deploy (rsync) concluído."
else
  echo "::warning::rsync indisponível/falhou — usando fallback via tar por SSH."
  tar --exclude='./.git' --exclude='./.github' -czf - . | ssh $SSH_OPTS "$REMOTE" \
    "mkdir -p '${DEPLOY_PATH}' && find '${DEPLOY_PATH}' -mindepth 1 -delete 2>/dev/null; tar -C '${DEPLOY_PATH}' -xzf -"
  echo "Deploy (tar) concluído."
fi
