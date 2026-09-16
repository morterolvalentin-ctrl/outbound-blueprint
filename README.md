# Outbound Blueprint

Les prompts, les skills et les gabarits qui accompagnent le blueprint
**« 130 000 € de pipeline en 14 jours »**.

Tout ce qui est ici est prêt à copier. Tu n'as pas besoin de lire le blueprint
pour t'en servir, mais il explique pourquoi chaque pièce existe.

👉 **[Lire le blueprint](LIEN_BLUEPRINT_A_AJOUTER)**
👉 **[Prendre 30 minutes avec Valentin](https://cal.com/valentin-morterol-ezc5qn/30min)**
👉 [scalon.fr](https://scalon.fr)

## Par où commencer

| Tu veux | Ouvre |
|---|---|
| Tout monter d'un coup, en une conversation | [`prompts/00-setup-complet.md`](prompts/00-setup-complet.md) |
| Y aller étape par étape | la table ci-dessous, dans l'ordre |

## Les prompts, dans l'ordre

| # | Étape | Fichier |
|---|---|---|
| 00 | Le setup complet en un prompt | [`00-setup-complet.md`](prompts/00-setup-complet.md) |
| 01 | Choisir sa verticale et son offre | [`01-choisir-sa-verticale.md`](prompts/01-choisir-sa-verticale.md) |
| 02 | Qualifier son marché : à qui vend chaque entreprise | [`02-qualifier-son-marche.md`](prompts/02-qualifier-son-marche.md) |
| 03 | Construire son dictionnaire de postes | [`03-dictionnaire-de-postes.md`](prompts/03-dictionnaire-de-postes.md) |
| 04 | Trouver les contacts dans les entreprises retenues | [`04-trouver-les-contacts.md`](prompts/04-trouver-les-contacts.md) |
| 05 | Enrichir les mobiles sans brûler de crédits | [`05-enrichir-les-mobiles.md`](prompts/05-enrichir-les-mobiles.md) |
| 06 | Écrire son script de cold call | [`06-script-de-cold-call.md`](prompts/06-script-de-cold-call.md) |
| 07 | Construire le CRM dans Notion | [`07-construire-le-crm-notion.md`](prompts/07-construire-le-crm-notion.md) |
| 08 | Traiter une session d'appels | [`08-traiter-une-session-dappels.md`](prompts/08-traiter-une-session-dappels.md) |

## Les skills Claude Code

Deux skills à déposer dans `~/.claude/skills/`. Ce sont les versions publiques
de celles qu'on utilise tous les jours.

| Skill | Ce qu'elle fait |
|---|---|
| [`outbound-batch`](skills/outbound-batch/SKILL.md) | Fabrique un lot de prospection de bout en bout, d'une cible en langage naturel jusqu'à une liste de contacts avec mobiles. Six phases, cinq points d'arrêt où tu valides, dont trois qui engagent de l'argent |
| [`post-call-sync`](skills/post-call-sync/SKILL.md) | Transforme une session d'appels en statuts propres et pousse les qualifiés dans le CRM |

```bash
git clone https://github.com/morterolvalentin-ctrl/outbound-blueprint.git
cp -r outbound-blueprint/skills/* ~/.claude/skills/
```

## Les références

| Fichier | Contenu |
|---|---|
| [`references/dictionnaire-postes.json`](references/dictionnaire-postes.json) | Les intitulés de poste des décideurs commerciaux, en français et en anglais, avec les exclusions |
| [`references/schema-sheet-outbound.md`](references/schema-sheet-outbound.md) | Les colonnes du fichier de prospection, et ce que chacune sert |

## Licence

MIT. Prends, modifie, vends avec. Si ça te sert, dis-le.
