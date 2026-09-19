#!/usr/bin/env bash
# Outbound Blueprint · installation
# Copie les skills dans ~/.claude/skills/ et prépare le dossier de configuration.
# Ne touche à aucun de tes fichiers existants sans te le dire.

set -euo pipefail

REPO="https://github.com/morterolvalentin-ctrl/outbound-blueprint.git"
SKILLS_DIR="${HOME}/.claude/skills"
CONF_DIR="${HOME}/.claude/outbound"
TMP="$(mktemp -d)"
trap 'rm -rf "${TMP}"' EXIT

bold() { printf '\033[1m%s\033[0m\n' "$1"; }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$1"; }

bold "Outbound Blueprint · installation"
echo

command -v git >/dev/null || { echo "git est requis."; exit 1; }

git clone --depth 1 -q "${REPO}" "${TMP}/repo"
ok "dépôt récupéré"

mkdir -p "${SKILLS_DIR}" "${CONF_DIR}"

for s in outbound-setup outbound-batch post-call-sync; do
  if [ -d "${SKILLS_DIR}/${s}" ]; then
    backup="${SKILLS_DIR}/${s}.backup-$(date +%Y%m%d-%H%M%S)"
    mv "${SKILLS_DIR}/${s}" "${backup}"
    warn "${s} existait déjà, sauvegardée dans $(basename "${backup}")"
  fi
  cp -R "${TMP}/repo/skills/${s}" "${SKILLS_DIR}/${s}"
  ok "skill ${s} installée"
done

# Les fichiers de référence sont écrasés à chaque install : ce sont des copies
# du dépôt, jamais ta configuration. Ton config.json et ton dictionnaire à toi
# ne sont pas touchés.
for pair in \
  "references/dictionnaire-postes.exemple.json:dictionnaire-postes.exemple.json" \
  "references/schema-sheet-outbound.md:schema-sheet-outbound.md" \
  "mcp/README.md:mcp.md"; do
  src="${TMP}/repo/${pair%%:*}"
  dst="${CONF_DIR}/${pair##*:}"
  if [ -f "${src}" ]; then
    cp "${src}" "${dst}"
  else
    warn "${pair%%:*} absent du dépôt, ignoré"
  fi
done

if [ -d "${CONF_DIR}/prompts" ]; then
  warn "les prompts de ~/.claude/outbound/prompts/ sont remplacés par ceux du dépôt"
  rm -rf "${CONF_DIR}/prompts"
fi
cp -R "${TMP}/repo/prompts" "${CONF_DIR}/prompts"
ok "références, guide MCP et $(find "${CONF_DIR}/prompts" -name '*.md' | wc -l | tr -d ' ') prompts copiés dans ~/.claude/outbound/"

# Compteur d'installations : un seul appel, anonyme, qui n'envoie que ton
# système (macOS, Linux...), un identifiant aléatoire tiré ici et si c'est une
# réinstallation. Aucun nom, aucune adresse, aucun fichier. Il ne bloque jamais
# l'installation. Pour le couper : OUTBOUND_NO_STATS=1 avant la commande.
if [ -z "${OUTBOUND_NO_STATS:-}" ] && command -v curl >/dev/null; then
  ID_FILE="${CONF_DIR}/.install-id"
  re=0
  if [ -s "${ID_FILE}" ]; then
    re=1
  else
    od -An -N16 -tx1 /dev/urandom | tr -d ' \n' > "${ID_FILE}"
  fi
  case "$(uname -s)" in
    Darwin) os=macOS ;;
    Linux) os=Linux ;;
    MINGW*|MSYS*|CYGWIN*) os=Windows ;;
    *) os=Autre ;;
  esac
  curl -fsS -m 5 -o /dev/null -X POST "https://scalon.fr/api/installe" \
    --data-urlencode "os=${os}" \
    --data-urlencode "machine=$(cat "${ID_FILE}")" \
    --data-urlencode "re=${re}" 2>/dev/null || true
fi

echo
bold "C'est installé. Une seule chose à faire maintenant :"
echo
echo "    claude"
echo "    /outbound-setup"
echo
echo "La skill te posera des questions sur ton activité, branchera les outils"
echo "dont tu as besoin, et construira ta pipeline à partir de TES réponses."
echo
warn "Le fichier dictionnaire-postes.exemple.json n'est qu'un exemple de format."
warn "Ton dictionnaire à toi sera construit pendant /outbound-setup."
echo
