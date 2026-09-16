# Outbound Blueprint

Une machine de prospection téléphonique complète, installable en une commande.
Elle se configure en te posant des questions sur **ton** activité, pas en
recopiant celle de quelqu'un d'autre.

C'est la version publique de ce qu'on utilise tous les jours chez
[Scalon](https://scalon.fr) : 130 000 € de pipeline en 14 jours, pour 204 €
d'outils par mois.

👉 **[Lire le blueprint](LIEN_NOTION_PUBLIC_A_COLLER_ICI)** · le guide complet qui explique pourquoi chaque pièce existe
👉 **[Prendre 30 minutes avec Valentin](https://cal.com/valentin-morterol-ezc5qn/30min)**

---

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/morterolvalentin-ctrl/outbound-blueprint/main/install.sh | bash
```

Puis, dans Claude Code :

```
/outbound-setup
```

C'est tout. La skill prend la main à partir de là.

<br>

> Tu préfères voir ce que fait le script avant de le lancer ?
> [`install.sh`](install.sh) fait trois choses : il clone ce dépôt dans un dossier
> temporaire, copie les trois skills dans `~/.claude/skills/` en sauvegardant ce
> qui existait déjà, et crée `~/.claude/outbound/`. Il ne touche à rien d'autre
> et n'installe aucune clé.

## Ce que fait `/outbound-setup`

Sept phases, quatre arrêts où tu valides.

| Phase | Ce qu'il se passe |
|---|---|
| **1. Ton contexte** | Il te demande ce que tu fais. Tu donnes **l'URL de ton site**, un **copier-coller** de ta plaquette, ou **trois phrases**. Il lit, puis te pose cinq questions : tes clients, ton panier, qui souffre du problème, qui signe, et ce que tu as produit comme travail de terrain |
| **2. Ta verticale** | Il propose 4 marchés et les classe sur un seul critère : celui où tu peux dire « on travaille déjà avec X » |
| **3. Ton dictionnaire** | Il construit **tes** décideurs à partir de **tes** réponses, famille par famille, et te demande explicitement qui tu as déjà appelé pour rien |
| **4. Tes outils** | Il regarde ce qui est déjà branché et te donne les commandes manquantes, une à la fois |
| **5. Ton fichier** | Il crée le Google Sheet de prospection |
| **6. Ton CRM** | Il construit les quatre bases Notion, avec les formules, les vues et le mode d'emploi |
| **7. Ton script** | Six blocs, 25 secondes, plus les cinq objections de ton marché et leurs réponses |

<br>

> **Rien ne vient d'un exemple.** Le fichier
> [`references/dictionnaire-postes.exemple.json`](references/dictionnaire-postes.exemple.json)
> montre un **format**. Il a été écrit pour une boîte qui vend à des directeurs
> commerciaux dans l'automobile. Si tu vends autre chose à quelqu'un d'autre, il
> ne te servira à rien, et la skill le sait : elle construit le tien.

## Les outils

Six serveurs MCP, dont quatre suffisent pour démarrer. Les commandes exactes
sont dans [`mcp/README.md`](mcp/README.md), et `/outbound-setup` te les donne
au bon moment.

| Outil | Rôle | Coût par mois |
|---|---|---|
| [Google Sheets](mcp/README.md#1-google-sheets--le-fichier-de-prospection) | Le fichier de prospection | 0 € |
| [Google Drive](mcp/README.md#2-google-drive--les-fichiers-autour) | Retrouver et lire les fichiers | 0 € |
| [Notion](mcp/README.md#3-notion--le-crm) | Le CRM | 10 € |
| [Allo](mcp/README.md#4-allo--la-téléphonie) | La téléphonie, reliée au CRM | dès 18 $ |
| [Pipecorn](mcp/README.md#5-pipecorn--les-numéros-de-mobile) | Les numéros de mobile | ~120 € |
| [Icypeas](mcp/README.md#6-icypeas--les-contacts-linkedin) | Les contacts LinkedIn | quelques euros |

Il n'y a pas d'outil de séquençage dans cette liste, et c'est volontaire. Ce
blueprint traite d'outbound téléphonique : un séquenceur fait à peu près doubler
le coût de la pipeline, et sur les premiers mois ce budget est mieux ailleurs.

## Les trois skills

Elles s'installent avec le script et se lancent comme des commandes.

| Skill | Quand |
|---|---|
| [`/outbound-setup`](skills/outbound-setup/SKILL.md) | Une fois, au début. Configure tout à partir de ton contexte |
| [`/outbound-batch`](skills/outbound-batch/SKILL.md) | À chaque nouveau lot. Six phases, cinq arrêts, dont trois qui engagent de l'argent |
| [`/post-call-sync`](skills/post-call-sync/SKILL.md) | Après chaque session d'appels. Classe, vérifie contre l'agenda et les mails, pousse dans le CRM |

## Les prompts, si tu préfères sans skill

Tout est faisable à la main, un prompt par étape. Le 02 est celui que personne
ne pense à chercher : d'où sort la base d'entreprises au départ.

| # | Étape | Fichier |
|---|---|---|
| 00 | Le setup complet en un prompt | [`00-setup-complet.md`](prompts/00-setup-complet.md) |
| 01 | Choisir sa verticale et son offre | [`01-choisir-sa-verticale.md`](prompts/01-choisir-sa-verticale.md) |
| 02 | Constituer sa base d'entreprises | [`02-constituer-sa-base-entreprises.md`](prompts/02-constituer-sa-base-entreprises.md) |
| 03 | Qualifier son marché : à qui vend chaque entreprise | [`03-qualifier-son-marche.md`](prompts/03-qualifier-son-marche.md) |
| 04 | Construire son dictionnaire de postes | [`04-dictionnaire-de-postes.md`](prompts/04-dictionnaire-de-postes.md) |
| 05 | Trouver les contacts | [`05-trouver-les-contacts.md`](prompts/05-trouver-les-contacts.md) |
| 06 | Enrichir les mobiles sans brûler de crédits | [`06-enrichir-les-mobiles.md`](prompts/06-enrichir-les-mobiles.md) |
| 07 | Écrire son script de cold call | [`07-script-de-cold-call.md`](prompts/07-script-de-cold-call.md) |
| 08 | Construire le CRM dans Notion | [`08-construire-le-crm-notion.md`](prompts/08-construire-le-crm-notion.md) |
| 09 | Traiter une session d'appels | [`09-traiter-une-session-dappels.md`](prompts/09-traiter-une-session-dappels.md) |

## Les références

| Fichier | Contenu |
|---|---|
| [`references/dictionnaire-postes.exemple.json`](references/dictionnaire-postes.exemple.json) | Un exemple de format, pas un contenu à réutiliser |
| [`references/schema-sheet-outbound.md`](references/schema-sheet-outbound.md) | Les colonnes du fichier de prospection, et les trois règles d'écriture |

## Désinstaller

```bash
rm -rf ~/.claude/skills/outbound-setup ~/.claude/skills/outbound-batch \
       ~/.claude/skills/post-call-sync ~/.claude/outbound
```

Tes MCP restent branchés, ton Sheet et ton CRM restent à toi.

## Qui a écrit ça

<img src="https://scalon.fr/img/asset-84dc076345.webp" alt="Valentin Morterol" width="96" height="96" align="left" hspace="16">

**Valentin Morterol**, cofondateur et CEO de [Scalon](https://scalon.fr).

On qualifie des marchés entiers pour les entreprises qui prospectent des
établissements locaux : garages, restaurants, bars, commerces. Pour chaque
établissement, ce qu'il fait vraiment et ce qui en fait un client.

[LinkedIn](https://www.linkedin.com/in/valentin-morterol/) · [valentin@scalon.fr](mailto:valentin@scalon.fr) · [Prendre 30 minutes](https://cal.com/valentin-morterol-ezc5qn/30min)

<br clear="left">

## Licence

MIT. Prends, modifie, vends avec. Si ça te sert, dis-le.
