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

cp "${TMP}/repo/references/dictionnaire-postes.exemple.json" "${CONF_DIR}/dictionnaire-postes.exemple.json"
cp "${TMP}/repo/references/schema-sheet-outbound.md" "${CONF_DIR}/schema-sheet-outbound.md"
cp "${TMP}/repo/mcp/README.md" "${CONF_DIR}/mcp.md"
rm -rf "${CONF_DIR}/prompts"
cp -R "${TMP}/repo/prompts" "${CONF_DIR}/prompts"
ok "références, guide MCP et 10 prompts copiés dans ~/.claude/outbound/"

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
