---
name: outbound-batch
version: 1.0.0
description: |
  Fabrique un lot de prospection outbound de bout en bout, depuis une cible
  exprimée en langage naturel jusqu'à une liste de contacts avec mobiles,
  prête pour le cold call.
  Six phases, cinq points d'arrêt où l'utilisateur valide, dont trois qui
  engagent des crédits. Rien n'est jamais dépensé sans un chiffre annoncé et
  un accord explicite.
  Use when the user says "/outbound-batch", "cible les boîtes qui vendent aux X",
  "je veux prospecter les X", "fais-moi un lot sur X", or asks for a new
  outbound batch.
triggers:
  - outbound-batch
  - cible les boîtes
  - cible les entreprises
  - je veux prospecter
  - fais-moi un lot
  - nouveau lot outbound
---

# outbound-batch

**Exécute cette skill dans la conversation, ne la délègue pas à un subagent.**
Cinq de ses six phases se terminent par une validation de l'utilisateur, dont
trois engagent de l'argent. Un subagent ne peut pas tenir ces points d'arrêt.

## Avant toute chose

Lis `~/.claude/outbound/config.json` et
`~/.claude/outbound/dictionnaire-postes.json`. Ils contiennent l'activité de
l'utilisateur, sa verticale, sa cible, son client référence et **ses** intitulés
de poste. Ne redemande jamais ces informations, et n'utilise jamais un
dictionnaire d'exemple à leur place.

**Si l'un des deux fichiers manque, arrête-toi et dis de lancer
`/outbound-setup`.** Même chose si le fichier de prospection n'existe pas encore
ou n'a pas ses colonnes « Résumé entreprise » et « Dans l'ICP » : cette skill
travaille sur une base d'entreprises déjà constituée et qualifiée, elle ne la
crée pas. C'est `/outbound-setup` qui la monte, en phases 5 et 6. Sans configuration, cette skill ne peut produire que du
générique, et du générique ne se vend pas au téléphone.

Puis annonce les soldes de crédits Icypeas et Pipecorn, pour que l'utilisateur
sache dans quoi il s'engage.

## Les outils

| Outil | Ce qu'il fait ici |
|---|---|
| **Google Sheets** | le fichier de prospection, deux onglets : `1. Entreprises` et `2. Contacts` |
| **Icypeas** | l'extraction des contacts LinkedIn, phase 3 |
| **Pipecorn** | l'enrichissement des mobiles, phase 5 |
| **Allo** ([withallo.com](https://withallo.com)) | les appels, phase 6 |
| **Notion** | le CRM, alimenté ensuite par `post-call-sync` |

Les commandes d'installation sont dans `~/.claude/outbound/mcp.md`.

## Les six phases

| Phase | Ce qu'on fait | Arrêt |
|---|---|---|
| 0 | Traduire la cible exprimée en langage naturel en types d'entreprises réels présents dans le fichier | **L'utilisateur valide les types** |
| 1 | Sélectionner les entreprises, puis qualifier chacune : activité, clients B2B, vend-elle à la cible ? | **L'utilisateur valide le périmètre sur les résumés** |
| 2 | Récupérer les contacts déjà connus, sans dépenser | aucun |
| 3 | Icypeas sur le reliquat seulement | **L'utilisateur valide la dépense** |
| 4 | Écrire dans le fichier de prospection, puis recopier le résumé de chaque entreprise sur toutes ses lignes | **L'utilisateur valide le fichier** |
| 5 | Mobiles chez Pipecorn, filtre pays | **L'utilisateur valide la dépense** |
| 6 | Cold call | aucun |

## Phase 0 · traduire la cible

Le champ qui décrit à qui une entreprise vend est du texte libre : il contient
des milliers de valeurs distinctes. Chercher une expression exacte ne rattrape
rien. Chercher une **racine courte et sans accent** rattrape les pluriels et les
compositions : `carross`, `boulanger`, `pharmac`, `veterinair`.

Présenter à l'utilisateur **toutes** les variantes trouvées avec leur volume,
sans en écarter d'office. C'est lui qui tranche : le fichier ne peut pas savoir
que « carrossiers industriels » ou « carrossiers d'ambulances » ne l'intéressent
pas.

Retenir un **libellé générique du lot**, un seul, pour pouvoir comparer les taux
de réponse entre lots.

> **ARRÊT 1.** L'utilisateur valide la liste des types. Rien ne continue sans.

## Phase 1 · sélectionner et qualifier

Écarter à la main, avant toute dépense :
- **les concurrents**, toute entreprise dont l'offre recoupe celle de
  l'utilisateur ;
- **les entreprises mal classées**, avec un coup d'œil au site en cas de doute.
  Une classification est un modèle, elle se trompe.

Puis, pour **chaque** entreprise retenue, produire un résumé d'une ligne :

```
<Ce que fait la boîte, une phrase courte>. Clients : <types de clients B2B>. <Cible du lot> : <verdict>.
```

Règles :
- **Clients B2B uniquement.** On liste les professionnels qui paient, jamais les
  particuliers. Une entreprise qui vend surtout au grand public le dit dans le
  verdict.
- **Le libellé de la cible est celui du lot**, jamais un libellé en dur.
- **Le verdict a cinq valeurs, et seulement celles-ci** : `oui`,
  `oui, en partie`, `partiel`, `indirect`, `non`. Une nuance courte après une
  virgule est permise.
- Le résumé dit **pourquoi** l'entreprise est dans le lot, jamais d'où vient
  l'information.

Présenter le tableau complet trié `non`, `indirect`, `partiel` d'abord, puis les
`oui` : ce sont les premiers que l'utilisateur va vouloir écarter.

> **ARRÊT 2.** L'utilisateur valide le périmètre, entreprise par entreprise s'il
> le souhaite.

## Phase 2 · récupérer ce qu'on a déjà, gratuitement

C'est l'étape qui fait économiser le plus. Chercher d'abord dans les contacts
déjà connus de l'utilisateur, filtrer sur le dictionnaire de postes, dédoublonner
sur l'URL LinkedIn normalisée **puis** sur prénom + nom + domaine. Les deux clés
sont nécessaires : un même profil apparaît sous deux URL à l'encodage près, et
deux URL réellement différentes peuvent désigner la même personne.

La seule liste qui part chez un outil payant est celle des entreprises pour
lesquelles on n'a trouvé aucun contact.

## Phase 3 · Icypeas, sur le reliquat seulement

**Compter d'abord, c'est gratuit et exact.** Le point d'entrée
`find-people/count` d'Icypeas rend le nombre exact de profils qui seront
facturés, sans rien débiter. Annoncer le nombre de profils, le coût unitaire, le
coût total et le solde.

Le header Icypeas est `Authorization: <clé>`, **la clé seule, jamais
« Bearer »**. Une mauvaise requête rend zéro résultat sans lever d'erreur :
tester sur une entreprise connue avant de lancer une boucle.

> **ARRÊT 3.** L'utilisateur valide la dépense.

Qui contacter, dans l'ordre, selon la taille de l'équipe commerciale :
moins de 10 → dirigeant ou fondateur, puis responsable commercial ;
10 à 30 → directeur commercial, puis opérations commerciales ;
plus de 30 → une seule personne, côté opérations commerciales ou CRM.
Deux personnes par entreprise au maximum dès que c'est payant.

## Phase 4 · écrire dans l'onglet Contacts

Les contacts vont dans l'onglet `2. Contacts`, rattachés à leur entreprise par
le **domaine**. Le schéma complet des deux onglets est dans
`~/.claude/outbound/schema-sheet-outbound.md`.

Une colonne se désigne **par le nom de son en-tête, jamais par sa lettre** :
l'ordre des colonnes bouge à la main. Résoudre le nom au moment d'écrire.

Jamais de ligne sans domaine, sans LinkedIn et sans statut. Une fois tous les
contacts trouvés, recopier le résumé de chaque entreprise sur **toutes** ses
lignes. Le lot n'est pas fini tant qu'une ligne n'a pas de résumé.

> **ARRÊT 4.** L'utilisateur relit le fichier.

## Phase 5 · les mobiles

Annoncer le nombre de personnes, le coût **maximum**, le solde, et rappeler
qu'un échec coûte zéro.

> **ARRÊT 5.** L'utilisateur valide la dépense.

Filtre pays obligatoire, et **le filtre ne suffit pas** : il oriente la
recherche, il ne filtre pas le résultat. Ne jamais enrichir un mobile par les
outils MCP de Pipecorn, ils n'exposent pas ce filtre. Passer par l'API REST avec
`phone_country_codes`. Trier soi-même les numéros rendus :
mobile national, puis fixe national, puis l'étranger, qui ne part jamais seul
en colonne Mobile. Ne jamais écrire le premier numéro de la liste sans l'avoir
trié.

Reporter **y compris les échecs** : « non trouvé » et la date. Sans cette trace,
on repaie la même personne et on ne peut mesurer aucun taux.

Ne jamais passer une ligne en « Rappeler » si son compteur d'appels est à zéro :
« Rappeler » suppose au moins un appel réel.

Avant d'appeler, vérifier les doublons de numéros : deux personnes d'entreprises
différentes qui partagent un mobile, l'un des deux est faux.

## Phase 6 · le cold call

Les appels se passent dans **Allo**, qui est relié au CRM Notion : le nom de la
personne s'affiche quand elle rappelle.

30 appels par jour, trois tentatives au maximum sur sept jours à des créneaux
différents. Un appel vise un rendez-vous de prise de besoin de 20 minutes, pas
une démo. Après chaque appel : statut, compteur d'appels, date, prochaine
action, et **la note**.

## Les règles qui ne se négocient pas

1. **On paie au résultat, jamais à la requête.** Un échec ne coûte rien. Ne
   jamais pré-filtrer « pour économiser », il n'y a rien à économiser.
2. **Trouvé ne veut pas dire utilisable.** Un numéro étranger est facturé plein
   tarif.
3. **Une colonne se désigne par son nom d'en-tête, jamais par sa lettre.**
4. **Toujours annoncer avant de dépenser** : lignes concernées, coût maximum,
   solde. Puis attendre un accord explicite.
5. **Toujours tracer les échecs.**
6. **Aucune entreprise ne part en enrichissement sans résumé relu.**
7. **Ne jamais créer un contact à la main dans le CRM.** Seul un statut de
   réponse positive déclenche une création.
