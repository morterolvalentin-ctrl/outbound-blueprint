---
name: outbound-setup
version: 1.0.0
description: |
  Installe et configure une machine de prospection téléphonique complète, à
  partir du contexte de l'utilisateur. Interroge d'abord la personne sur ce
  qu'elle vend et à qui (site web, copier-coller, ou description libre), en
  déduit sa cible et SES décideurs à elle, branche les outils manquants,
  puis construit son fichier de prospection, son CRM et son script d'appel.
  Ne réutilise jamais l'exemple de dictionnaire du dépôt comme configuration.
  Use when the user says "/outbound-setup", "configure ma pipeline outbound",
  "installe ma machine de prospection", "je viens d'installer le blueprint",
  or runs this skill for the first time.
triggers:
  - outbound-setup
  - configure ma pipeline
  - installe ma machine de prospection
  - setup outbound
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - WebFetch
  - AskUserQuestion
---

# outbound-setup

**Exécute cette skill dans la conversation, ne la délègue pas à un subagent.**
Elle est faite d'aller-retours avec l'utilisateur. Un subagent ne peut pas les
tenir.

Elle se lance une fois. À la fin, l'utilisateur a un fichier de prospection, un
CRM, un script, un dictionnaire de postes qui lui appartient, et deux skills
opérationnelles qui lisent sa configuration.

## Ce que tu as sous la main

`install.sh` a déposé tout ça dans `~/.claude/outbound/` :

| Fichier | À quoi il sert |
|---|---|
| `mcp.md` | Les commandes d'installation des 6 serveurs MCP, phase 4 |
| `prompts/` | Les 10 prompts du blueprint : la constitution de la base en phase 5, la spec complète du CRM en phase 7 |
| `schema-sheet-outbound.md` | Les deux onglets du fichier, leurs colonnes, les 7 règles et les mises en forme, phase 5 |
| `dictionnaire-postes.exemple.json` | Un **exemple de format**, jamais un contenu à reprendre |

**Lis ces fichiers au moment où tu en as besoin.** Ne reconstitue rien de
mémoire. Si l'un manque, dis-le à l'utilisateur et propose de relancer
l'installation, plutôt que d'improviser.

<br>

> **La règle qui gouverne toute cette skill.**
> Rien de ce que tu produis ne doit venir d'un exemple. Le fichier
> `~/.claude/outbound/dictionnaire-postes.exemple.json` montre un **format**,
> pas un contenu. Il a été écrit pour une entreprise qui vend à des directeurs
> commerciaux dans l'automobile. Si tu le recopies pour quelqu'un qui vend des
> logiciels de paie à des DRH, tu lui fabriques un fichier inutile et il le
> découvrira après avoir payé l'enrichissement.
> **Tout sort du contexte que la personne te donne en phase 1.**

---

## Les huit phases

| Phase | Ce qu'on fait | Arrêt |
|---|---|---|
| 1 | Comprendre ce que fait l'utilisateur | **Il valide la restitution** |
| 2 | Choisir la verticale et la cible | **Il choisit** |
| 3 | Construire SON dictionnaire de postes | **Il valide rang par rang** |
| 4 | Brancher les outils manquants | **Il lance les commandes** |
| 5 | Constituer la base d'entreprises et le fichier | **Il valide l'export et son volume** |
| 6 | Qualifier la base : résumé et verdict ICP | **Il valide le premier lot de 50** |
| 7 | Créer le CRM | aucun |
| 8 | Écrire son script d'appel | **Il le chronomètre** |

---

## Phase 1 · comprendre ce que fait l'utilisateur

**Ne commence par rien d'autre.** Tant que tu n'as pas compris son activité, tu
ne peux produire que du générique, et du générique ne se vend pas au téléphone.

Demande-lui du contexte, en lui laissant le choix de la forme :

> Avant tout, j'ai besoin de comprendre ce que tu fais. Donne-moi ce qui est le
> plus rapide pour toi :
> - **l'URL de ton site**, je vais le lire
> - **un copier-coller** de ta plaquette, de ton pitch, d'un vieux mail de
>   prospection, d'une page de ton site
> - ou **écris-le en trois phrases**, ça suffit aussi

S'il donne une URL, va la lire, et lis aussi les pages « offre », « produit »,
« clients », « tarifs » ou « cas clients » si elles existent.

Puis complète par ces questions, **une par une**, en attendant la réponse à
chacune. Ne les pose jamais en bloc.

1. Qui sont tes clients actuels ? Leur nom, leur secteur, et le montant du
   contrat si tu veux bien.
2. Quel est ton panier moyen, et ta fourchette basse et haute ?
3. Dans les entreprises que tu vises, **qui souffre du problème que tu
   résous ?** Décris la personne par ce qu'elle vit au quotidien, pas par son
   titre.
4. Et **qui signe** ? Est-ce la même personne ?
5. Quel travail de terrain as-tu produit, ou peux-tu produire cette semaine, sur
   le marché que tu vises ? Une étude, un comptage, un benchmark, un audit.

<br>

> **Sur la question 5.** Si la réponse est « rien », arrête-toi et dis-le
> franchement : sans raison d'appeler qui ne soit pas commerciale, le reste de
> la machine tourne à vide. Propose trois travaux de terrain réalisables en une
> semaine sur son marché, et laisse-le choisir. C'est un investissement d'une
> journée qui change le taux de prise de rendez-vous.

Restitue ensuite, en dix lignes maximum : ce qu'il vend, le problème résolu, ses
clients types, son panier, qui souffre, qui signe, et ce qu'il a à offrir.

> **ARRÊT 1.** Il corrige la restitution. Ne continue pas sur une restitution
> qu'il n'a pas validée : tout le reste en dépend.

Écris le résultat dans `~/.claude/outbound/contexte.md`.

## Phase 2 · la verticale

Propose 4 verticales à partir de son contexte. Pour chacune : le type
d'entreprise visé, à qui ces entreprises vendent elles-mêmes, la taille
approximative du marché, et **s'il a déjà un client dedans**.

Classe-les sur un seul critère : celle où il peut dire « on travaille déjà avec
X » à quelqu'un qui connaît X. Ce critère prime sur la taille du marché.

S'il n'a de client dans aucune des quatre, dis-le et propose plutôt une liste de
dix personnes de son réseau à appeler cette semaine. Le réseau d'abord, le
téléphone ensuite.

> **ARRÊT 2.** Il choisit la verticale et le libellé exact qu'on utilisera
> partout.

## Phase 3 · son dictionnaire de postes

C'est la phase que personne ne doit bâcler, et c'est celle où il est le plus
tentant de recopier un exemple. Ne le fais pas.

À partir de **ses** réponses aux questions 3 et 4 de la phase 1, propose un
dictionnaire, et fais-le valider **famille par famille**, pas en bloc :

1. **Les décideurs.** Ceux qui signent. Pour chacun, donne les variantes réelles
   telles qu'elles apparaissent sur LinkedIn : féminin et masculin, français et
   anglais, abréviations, et les titres cumulés qu'on trouve en PME où une
   personne porte plusieurs casquettes.
2. **Les prescripteurs.** Ceux qui subissent le problème et le font remonter.
   Demande-lui explicitement s'il veut les appeler ou non : selon le cycle de
   vente, passer par eux est un raccourci ou une perte de temps.
3. **Les exclusions.** Pose la question dans ce sens, il ne la posera pas tout
   seul : *« Quels intitulés ressemblent aux bons sans en être ? Qui as-tu déjà
   appelé pour rien ? »* C'est cette liste qui fait la qualité du fichier, et
   elle ne s'invente pas depuis un modèle générique. Propose-lui aussi les
   suspects habituels : fonctions de terrain, assistants, alternants et
   stagiaires, fonctions support.
4. **Les exclusions géographiques.** Les mentions de pays qui signalent une
   personne hors de son marché.

> **ARRÊT 3.** Il valide chaque famille. Ajoute et retire ce qu'il dit, sans
> discuter.

Écris le fichier dans `~/.claude/outbound/dictionnaire-postes.json`, au format
de l'exemple : clés `rangs`, `exclude`, `exclude_geo`, tout en minuscules et
sans accent, avec les variantes à apostrophe droite **et** à apostrophe courbe.
Dis-lui qu'il peut le rouvrir et le corriger à tout moment, et que c'est
normal : un dictionnaire se corrige après les cinquante premiers appels.

## Phase 4 · brancher les outils

Lance `claude mcp list` et regarde ce qui répond déjà.

Puis présente-lui le tableau de ce qui manque, avec le coût de chacun, et
**propose de lui donner les commandes une par une**, dans cet ordre de priorité :

| Outil | Rôle | Sans lui | Coût |
|---|---|---|---|
| **Google Sheets** | Le fichier de prospection | rien ne marche | 0 € |
| **Google Drive** | Retrouver et lire ses fichiers | il donne chaque URL à la main | 0 € |
| **Notion** | Le CRM | pas de suivi, tout se perd | 10 €/mois |
| **Allo** ([withallo.com](https://withallo.com)) | La téléphonie reliée au CRM | il appelle depuis son mobile sans savoir qui le rappelle | dès 18 $/mois |
| **Pipecorn** | Les numéros de mobile | pas de numéros à appeler | ~120 €/mois |
| **Icypeas** | Les contacts LinkedIn | il cherche les contacts à la main | quelques euros |

Les quatre premiers sont l'ossature. Pipecorn et Icypeas se branchent au moment
d'attaquer le premier lot.

S'il te parle d'un outil de séquençage multicanal, dis-lui que ce n'est pas
nécessaire ici et pourquoi : ça fait à peu près doubler le coût de la pipeline,
et sur les premiers mois ce budget est mieux ailleurs.

Les commandes exactes sont dans `~/.claude/outbound/mcp.md`, installé avec la
skill. **Lis ce fichier**, ne reconstitue pas les commandes de mémoire : une URL
d'endpoint inventée fait perdre une demi-heure.

Donne-les **une à la fois**, attends qu'il confirme que ça répond, passe à la
suivante. Ne lui colle jamais six commandes d'un coup.

<br>

> **Ce que tu ne fais jamais.** Tu ne lui demandes pas de te coller une clé API
> dans la conversation, et tu n'en écris aucune dans un fichier du projet. Les
> clés vivent dans sa configuration MCP et dans son environnement shell. Si une
> commande en contient une, c'est lui qui la tape dans son terminal.

Deux précautions à lui transmettre, elles coûtent de l'argent sinon :

- **Pipecorn** : les outils d'enrichissement MCP n'exposent pas le filtre pays,
  et un numéro étranger trouvé est facturé plein tarif. L'enrichissement de
  masse passe par l'API REST avec le filtre pays. La skill `outbound-batch` le
  fait déjà.
- **Icypeas** : le header est `Authorization: <clé>`, la clé seule, jamais
  « Bearer ». Le comptage est gratuit et exact, c'est lui qui donne le coût
  avant toute dépense.

S'il ne veut pas tout installer aujourd'hui, note ce qui manque dans la config
et continue. Les phases 5 à 7 fonctionnent sans Allo ni Pipecorn.

## Phase 5 · constituer la base d'entreprises

C'est la marche que tout le monde saute, et sans elle il n'y a rien à qualifier.
L'utilisateur ne part pas d'une liste d'entreprises qu'il aurait devinées : il
part de **toutes** les entreprises d'un périmètre, et c'est toi qui lui dis
lesquelles sont ses clients.

Explique-lui l'export **d'entreprises** dans Icypeas, pas de contacts, sur trois
critères :

- **le pays** qu'il prospecte, celui où il peut décrocher son téléphone ;
- **l'effectif**, en fourchette et jamais en minimum seul : sous la borne basse
  il n'y a personne à qui vendre, au-dessus de la borne haute le cycle de vente
  ne ressemble plus à un cold call. Déduis une fourchette de son panier moyen et
  de ses clients actuels, et propose-la-lui ;
- **le volume maximum**, qui pilote sa dépense de crédits.

<br>

> **Fais-lui commencer petit.** Un premier export de 500 à 1 000 entreprises,
> qualifié en phase 6, donne son taux réel de « dans l'ICP ». S'il est de 4 %, il
> sait qu'un export de 10 000 lui rendra environ 400 cibles, et il sait s'il doit
> élargir l'effectif ou changer de critère. Ce test coûte presque rien et il
> évite un export de 50 000 lignes calibré au hasard.

> **ARRÊT 4.** Il valide les critères et le volume avant de lancer l'export.
> C'est une dépense de crédits : annonce ce que ça coûte.

### Construis-lui son fichier, ne te contente pas de le décrire

**Lis `~/.claude/outbound/schema-sheet-outbound.md` et crée réellement le
classeur.** L'utilisateur ne doit pas avoir à recopier un tableau de
documentation à la main : c'est long, et il se trompera sur un nom de colonne
que les autres skills chercheront ensuite par son nom exact.

Un classeur, **deux onglets**, parce qu'une entreprise vit une seule fois et
qu'une personne vit plusieurs fois dans la même entreprise :

| Onglet | Une ligne = | Rempli à |
|---|---|---|
| `1. Entreprises` | une entreprise | la phase 5, puis qualifié en phase 6 |
| `2. Contacts` | une personne | l'extraction des contacts, plus tard |

La jointure se fait sur le **domaine du site**, jamais sur le nom : deux
entreprises peuvent porter le même nom, jamais le même domaine.

Fais, dans cet ordre :

1. **Crée le classeur** et nomme-le avec son activité et la date.
2. **Écris les en-têtes des deux onglets**, exactement tels qu'ils sont dans le
   schéma. Adapte seulement ce qui est propre à son marché : les valeurs de
   `Verticale`, qui sont sa liste fermée à lui.
3. **Verse l'export d'entreprises** dans l'onglet `1. Entreprises`, en mappant
   les colonnes de l'export sur les en-têtes. Montre-lui le mapping avant
   d'écrire, il y aura des colonnes de l'export qui ne correspondent à rien.
4. **Pose les mises en forme** : ligne d'en-tête figée et filtrée sur les deux
   onglets ; listes déroulantes sur `Verticale`, `Dans l'ICP`, `Statut` et
   `Taille équipe commerciale` ; format date `AAAA-MM-JJ` sur toutes les
   colonnes de date ; **format texte brut sur `Mobile`**, sinon Sheets mange le
   `+` et le zéro initial.
5. **Vérifie** en relisant l'en-tête que tu viens d'écrire, et annonce-lui le
   nombre de lignes versées et le nombre de colonnes de chaque onglet.

Deux colonnes méritent qu'on lui explique pourquoi elles existent toutes les
deux, sinon il en supprimera une : **`Verticale`** est une liste fermée, donc
filtrable et comptable, elle dit combien de boîtes il a par marché.
**`À qui elle vend`** est du texte libre, donc fidèle : elle contient « garages
poids lourds » ou « carrosseries indépendantes » là où la verticale dit
seulement « Automobile ». On filtre sur la première pour cadrer, on cherche dans
la seconde pour cibler.

### Les règles à lui transmettre

Elles viennent toutes d'une erreur réelle, et chacune a coûté quelque chose.
Dis-les-lui maintenant, pas quand il les aura commises :

1. **Une colonne se désigne par le nom de son en-tête, jamais par sa lettre.**
   Il va réordonner ses colonnes à la main. Un script qui écrit en dur dans la
   colonne F écrase la mauvaise donnée sans rien signaler.
2. **On n'écrit jamais à un numéro de ligne**, mais à un `ID`, après avoir relu
   le prénom et le nom de la ligne visée.
3. **`Notes` s'ajoute avec ` | `, ne s'écrase jamais.** L'historique d'un
   prospect tient dans cette colonne.
4. **Un échec d'enrichissement se trace**, sinon on le repaie au lot suivant.
5. **Jamais `Rappeler` sur une ligne à zéro appel.**
6. **Dédoublonner les personnes avant de payer**, sur l'URL LinkedIn normalisée
   **et** sur prénom + nom + domaine.
7. **Quatre enrichissements par entreprise au maximum**, servis par ordre de
   priorité du dictionnaire de postes.

## Phase 6 · qualifier la base

Ajoute deux colonnes au fichier et remplis-les pour chaque ligne.

**« Résumé entreprise »**, une seule ligne, dans ce format exact :

```
<Ce que fait la boîte, une phrase courte>. Clients : <types de clients B2B>.
```

**« Dans l'ICP »**, un verdict parmi cinq valeurs et seulement celles-ci :
`oui`, `oui, en partie`, `partiel`, `indirect`, `non`.

Règles, sans exception :

1. **Clients B2B uniquement.** Les professionnels qui paient la boîte, jamais
   les particuliers. Une boîte qui vend surtout au grand public le dit dans le
   verdict.
2. **Si tu ne sais pas, écris INCONNU** dans les deux colonnes. N'invente jamais
   un client type. Un INCONNU lui coûte une vérification de trente secondes, une
   invention lui coûte un appel et sa crédibilité.
3. Le résumé dit ce que fait l'entreprise, **jamais d'où vient l'information**.
4. Écris par identifiant de ligne, et résous les colonnes par le nom de leur
   en-tête.

Travaille **par lots de 50 lignes**.

> **ARRÊT 5.** Montre-lui le premier lot de 50 avant de continuer.
> C'est le moment le plus important de toute la configuration : si tu as mal
> compris sa cible, il le voit là, en trente secondes, sur 50 lignes. S'il te
> laisse partir sur 10 000, il le découvrira au téléphone. Corrige la
> description de son client idéal et relance sur le même lot jusqu'à ce que les
> verdicts lui paraissent justes.

Une fois la base qualifiée, isole les lignes en `oui` et `oui, en partie`,
annonce-lui combien il en reste et quelle proportion de l'export ça représente,
puis écarte ses concurrents, les INCONNU et les doublons de domaine, en lui
montrant chaque ligne écartée.

Ce qui reste est son périmètre d'enrichissement. **Rien d'autre ne part chez un
outil payant.** Une entreprise écartée avant l'enrichissement ne coûte rien,
écartée après elle a coûté ses crédits.

Le prompt complet de ces deux phases est dans
`~/.claude/outbound/prompts/02-constituer-sa-base-entreprises.md`.

## Phase 7 · le CRM

Construis les quatre bases Notion reliées : 🏢 Entreprises, 👤 Contacts,
💼 Deals, 🎤 Meetings, avec leurs propriétés, leurs formules, leurs rollups et
leurs vues. La spécification complète est dans
`~/.claude/outbound/prompts/08-construire-le-crm-notion.md`, installé avec la
skill. **Lis ce fichier et applique-le tel quel.** N'improvise pas un schéma de
CRM : les formules, les rollups et les vues y sont écrits parce qu'ils ont été
testés. Si le fichier est absent, dis-le et arrête-toi plutôt que d'inventer.

Deux adaptations à lui demander :

- **les phases 2 et 3 du pipeline** doivent porter le nom de ce qu'il envoie
  réellement pour convaincre : échantillon, pilote, audit, maquette, essai ;
- **la liste des verticales** dans Entreprises doit être la sienne.

Crée un jeu de test, vérifie chaque formule et chaque rollup, supprime-le, puis
écris le mode d'emploi en une page dans la page parente.

## Phase 8 · son script d'appel

Six blocs, 25 secondes maximum :

1. Prénom et société
2. Vérification d'identité en question fermée : « Vous êtes bien [Prénom] au
   [Poste] chez [Entreprise] ? »
3. Ce qu'il fait, en une phrase sans jargon
4. Sa raison d'appeler qui n'est pas commerciale, appuyée sur son travail de
   terrain, avec un chiffre **précis et non arrondi**
5. Son client référence
6. La demande de 20 minutes, en question fermée à deux créneaux

Interdits : superlatifs, « leader », « solution », questions ouvertes, « est-ce
que ça vous intéresse », « je me permets de vous déranger ».

Donne-lui aussi les cinq objections les plus probables **sur son marché à lui**,
et une réponse de deux phrases pour chacune, qui ramène à la demande de
rendez-vous.

> **ARRÊT 6.** Il le lit à voix haute et le chronomètre. Au-delà de 25 secondes,
> coupe.

## Pour finir

Écris `~/.claude/outbound/config.json` :

```json
{
  "activite": "une phrase",
  "verticale": "le libellé retenu",
  "cible": "à qui vendent les entreprises visées",
  "client_reference": "le nom cité au téléphone",
  "travail_de_terrain": "l'étude ou le comptage qui sert de raison d'appeler",
  "sheet_url": "",
  "base_entreprises": { "source": "", "pays": "", "effectif": "", "volume": 0, "taux_icp": null },
  "crm_url": "",
  "outils_branches": [],
  "outils_manquants": [],
  "cree_le": "AAAA-MM-JJ"
}
```

C'est ce fichier que lisent `outbound-batch` et `post-call-sync`. Elles ne
redemanderont jamais ces informations.

Puis rends-lui :

- le lien du Sheet et le lien du CRM
- son script, prêt à imprimer
- sa routine : cinq minutes chaque matin sur la vue « 🔔 À relancer », quinze
  minutes chaque semaine sur « 🚀 Pipeline »
- ce qu'il reste à brancher, s'il a sauté des outils en phase 4
- **la prochaine commande à taper** : `/outbound-batch` pour fabriquer son
  premier lot de prospection

Et dis-lui la seule chose qui compte vraiment : la machine fait le volume et la
régularité, mais ce qui transforme un rendez-vous, c'est son produit et le
problème qu'il résout. Si le rendez-vous ne se transforme pas, le problème n'est
pas dans le script.
