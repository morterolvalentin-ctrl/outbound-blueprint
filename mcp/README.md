# Brancher les outils à Claude

Sept serveurs MCP. La skill [`outbound-setup`](../skills/outbound-setup/SKILL.md)
vérifie lesquels répondent déjà chez toi et te propose d'installer les autres,
une commande à la fois. Cette page est là si tu préfères le faire à la main.

Toutes les commandes se lancent dans un terminal, pas dans Claude.

| Outil | Rôle dans la chaîne | Sans lui | Coût |
|---|---|---|---|
| [Google Sheets](#1-google-sheets--le-fichier-de-prospection) | Le fichier de prospection | rien ne marche | 0 € |
| [Google Drive](#2-google-drive--les-fichiers-autour) | Retrouver et lire les fichiers du Drive | tu donnes les URL à la main | 0 € |
| [Notion](#3-notion--le-crm) | Le CRM | pas de suivi, tout se perd | 10 €/mois |
| [Allo](#4-allo--la-téléphonie) | La téléphonie reliée au CRM | tu appelles depuis ton mobile sans savoir qui te rappelle | dès 18 $/mois |
| [Pipecorn](#5-pipecorn--les-numéros-de-mobile) | Les numéros de mobile | pas de numéros à appeler | ~120 €/mois |
| [Icypeas](#6-icypeas--les-contacts-linkedin) | Les contacts LinkedIn | tu cherches les contacts à la main | quelques euros |
| [La Growth Machine](#7-la-growth-machine--optionnel-multicanal) | Le multicanal, optionnel | rien, ce blueprint est téléphonique | à partir de 60 €/mois |

---

## 1. Google Sheets · le fichier de prospection

C'est le seul indispensable. Sans lui, pas de fichier.

```bash
claude mcp add google-sheets \
  --env CREDENTIALS_PATH=/chemin/vers/credentials.json \
  --env TOKEN_PATH=/chemin/vers/token.json \
  -- uvx --with "mcp<2" --from mcp-google-sheets@latest mcp-google-sheets
```

Il te faut des identifiants OAuth Google. Crée un projet sur
[console.cloud.google.com](https://console.cloud.google.com), active l'API Google
Sheets **et** l'API Google Drive, crée des identifiants OAuth de type
« application de bureau », télécharge le JSON. Le fichier de token se crée tout
seul à la première connexion.

## 2. Google Drive · les fichiers autour

Pour que Claude retrouve tes fichiers sans que tu lui donnes chaque URL.

```bash
claude mcp add google-drive --transport http https://drivemcp.googleapis.com/mcp/v1
```

Authentification par OAuth : Claude t'ouvrira une page Google. Sur Claude web ou
l'application de bureau, Drive s'active plutôt depuis tes réglages de
connecteurs.

## 3. Notion · le CRM

```bash
claude mcp add notion --transport http https://mcp.notion.com/mcp
```

OAuth également. Autorise l'accès à l'espace où vivra le CRM, pas à tout ton
Notion.

## 4. Allo · la téléphonie

[withallo.com](https://withallo.com) · à partir de 18 $ par mois.

```bash
claude mcp add allo --transport http https://mcp.withallo.com/mcp \
  --header "Authorization: TA_CLE_API"
```

La clé se récupère dans Allo, **Settings → API**. Si tu appelles l'API en direct,
le schéma est `Api-Key`, pas `Bearer`.

C'est ce qui permet au nom de la personne de s'afficher quand elle te rappelle :
Allo lit ta base Notion. Quand tu as appelé cent personnes dans la journée, tu ne
reconnais aucun numéro, et un rappel entrant décroché à l'aveugle est un
rendez-vous gâché.

## 5. Pipecorn · les numéros de mobile

[app.pipecorn.com](https://app.pipecorn.com) · environ 120 € par mois.

```bash
claude mcp add pipecorn \
  --env API_KEY=ta_cle_pipecorn \
  -- npx mcp-remote https://mcp.pipecorn.com/mcp --header "X-API-Key:\${API_KEY}"
```

<br>

> **Attention au filtre pays.** Les outils d'enrichissement du MCP Pipecorn
> n'exposent pas le filtre de pays, et un numéro étranger trouvé est facturé
> plein tarif. Pour l'enrichissement de masse, passe par l'API REST avec
> `phone_country_codes`. La skill `outbound-batch` le sait et le fait.

## 6. Icypeas · les contacts LinkedIn

[icypeas.com](https://www.icypeas.com) · quelques euros par lot.

```bash
claude mcp add icypeas --transport http https://mcp.icypeas.com/mcp
```

Authentification par OAuth. Si le serveur ne répond pas, Icypeas s'utilise très
bien en REST et Claude sait l'appeler avec `curl` :

```bash
echo 'export ICYPEAS_KEY="ta_cle_icypeas"' >> ~/.zshrc && source ~/.zshrc
```

Le header est `Authorization: ta_cle`, **la clé seule, jamais « Bearer »**.
Le point d'entrée `find-people/count` est gratuit et exact : c'est lui qui donne
le coût avant toute dépense. Compte toujours avant d'extraire.

## 7. La Growth Machine · optionnel, multicanal

[lagrowthmachine.com](https://lagrowthmachine.com)

```bash
claude mcp add lgm --transport http https://mcp.lagrowthmachine.com/
```

**Tu n'en as pas besoin pour ce blueprint**, qui est volontairement limité à
l'outbound téléphonique. Un outil de séquençage multicanal fait à peu près
doubler le coût de la pipeline, et sur les premiers mois ce budget est mieux
ailleurs.

Branche-le le jour où tu veux ajouter une lane LinkedIn et e-mail à côté du
téléphone. Le fichier de prospection prévoit déjà une colonne `Lane` pour
aiguiller chaque contact vers l'un ou l'autre.

---

## Vérifier que tout répond

```bash
claude mcp list
```

Chaque ligne doit afficher `✔ Connected`. Une ligne `! Needs authentication`
veut dire que l'OAuth n'a pas été fait. Une ligne
`Missing environment variables` que la clé n'est pas dans ton environnement.

## Où vivent les clés

Dans ta configuration MCP et dans ton environnement shell, jamais dans un
fichier du projet et jamais collées dans une conversation. Les commandes
ci-dessus se tapent dans ton terminal, par toi.
