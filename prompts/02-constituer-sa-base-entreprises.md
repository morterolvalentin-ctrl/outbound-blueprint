# 02 · Constituer sa base d'entreprises

**Quand l'utiliser :** une fois la verticale choisie. C'est la toute première
chose que tu produis, et tout le reste s'appuie dessus.

**Où :** dans Icypeas pour l'export, puis dans une conversation Claude avec
Google Drive et Google Sheets branchés en MCP.

---

## Le raisonnement

Tu ne pars pas d'une liste d'entreprises que tu aurais devinées. Tu pars de
**toutes** les entreprises d'un périmètre, et tu laisses Claude te dire
lesquelles sont tes clients.

C'est contre-intuitif quand on a l'habitude d'acheter des fichiers déjà
filtrés. Mais un fichier déjà filtré l'a été sur un code NAF et un effectif,
c'est-à-dire sur ce qu'une entreprise **est**, jamais sur **à qui elle vend**.
Le tri qui compte, personne ne l'a fait à ta place.

Donc : un export large, puis une qualification, puis l'enrichissement payant
uniquement sur ce qui a passé la qualification.

---

## Étape A · l'export depuis Icypeas

Dans Icypeas, fais un **export d'entreprises**, pas de contacts. Tu poses trois
critères :

| Critère | Comment le choisir |
|---|---|
| **Le pays** | Celui que tu prospectes. Tu appelles au téléphone, donc reste sur un pays où tu peux décrocher et être compris |
| **L'effectif** | C'est ton vrai filtre de qualité. Une fourchette, pas un minimum seul : par exemple 5 à 50 salariés, ou 10 à 200. En dessous de ta borne basse, il n'y a personne à qui vendre. Au-dessus de ta borne haute, le cycle de vente ne ressemble plus à un cold call |
| **Le volume** | Le nombre maximum d'entreprises à sortir. C'est ce qui pilote ta dépense de crédits, donc commence petit |

Tu ressors avec une liste brute. Dix mille entreprises, par exemple. Elle n'est
pas qualifiée, c'est normal, c'est la matière première.

<br>

> **Sur le volume.** Ne sors pas 50 000 entreprises au premier essai parce que
> tu peux. Fais un premier export de 500 à 1 000, fais tourner la qualification
> de l'étape B dessus, et regarde ton taux de « dans l'ICP ». S'il est de 4 %,
> tu sais qu'un export de 10 000 te donnera environ 400 cibles, et tu sais si ça
> vaut le coup d'élargir l'effectif ou de changer de critère. Ce test coûte
> presque rien et il t'évite de payer un export calibré au hasard.

## Étape B · le fichier, et la qualification par Claude

Verse l'export dans un Google Sheet. C'est lui qui devient ton **fichier de
prospection**, avec **deux onglets** : `1. Entreprises`, une ligne par
entreprise, que tu remplis maintenant ; et `2. Contacts`, une ligne par
personne, que tu rempliras à l'étape 05. La jointure entre les deux se fait sur
le **domaine du site**, jamais sur le nom.

Les colonnes exactes des deux onglets sont dans
[`../references/schema-sheet-outbound.md`](../references/schema-sheet-outbound.md).
Crée-les avant de verser quoi que ce soit, et pose tout de suite les listes
déroulantes et le format texte brut sur `Mobile` : Sheets mange le `+` et le
zéro initial d'un numéro sinon.

Branche Google Drive et Google Sheets à Claude en MCP (commandes dans
[`../mcp/README.md`](../mcp/README.md)), puis lance ce prompt.

```
Voici mon fichier de prospection : [URL du Sheet, onglet X]

MON ACTIVITÉ
Je vends : [ton offre en 1 phrase, et le problème qu'elle résout]
Mon client idéal : [décris-le par son activité et par ses propres clients,
  pas par un code NAF. Exemple : « une entreprise qui vend des pièces ou des
  équipements à des garages automobiles indépendants »]

CE QUE JE TE DEMANDE
Ajoute deux colonnes au fichier, et remplis-les pour chaque ligne.

Colonne 1, « Résumé entreprise ». Une seule ligne, dans ce format exact :
<Ce que fait la boîte, une phrase courte>. Clients : <types de clients B2B>.

Colonne 2, « Dans l'ICP ». Un verdict, et seulement l'une de ces cinq valeurs :
  - oui : mon client idéal est un client direct qui la paie
  - oui, en partie : client direct, mais une partie seulement de ma cible,
    ou avec d'autres canaux dominants
  - partiel : ma cible est un client parmi d'autres, ou marginal
  - indirect : elle vend à des intermédiaires (distributeurs, groupements,
    franchisés), ou ma cible est un partenaire ou un utilisateur, pas celui
    qui paie
  - non

RÈGLES, SANS EXCEPTION
1. CLIENTS B2B UNIQUEMENT. Tu listes les professionnels qui paient la boîte,
   jamais les particuliers. Une boîte qui vend surtout au grand public le dit
   dans le verdict.
2. SI TU NE SAIS PAS, tu écris INCONNU dans les deux colonnes. Tu n'inventes
   jamais un client type. Un INCONNU me coûte une vérification de trente
   secondes ; une invention me coûte un appel et ma crédibilité.
3. Le résumé dit ce que fait l'entreprise, jamais d'où vient l'information.
4. Écris par identifiant de ligne, et résous les colonnes par le nom de leur
   en-tête, jamais par leur lettre.

Travaille par lots de 50 lignes et montre-moi le premier lot avant de
continuer, que je vérifie que tu as compris ma cible.
```

<br>

> **Le premier lot de 50 est le moment le plus important de toute la méthode.**
> Si Claude a mal compris ta cible, tu le vois là, en trente secondes, sur
> 50 lignes. Si tu le laisses partir sur 10 000, tu le découvriras au téléphone.
> Corrige la description de ton client idéal et relance-le sur le même lot
> jusqu'à ce que les verdicts te paraissent justes.

## Étape C · ne garder que ce qui mérite d'être payé

```
Dans mon fichier, isole les lignes dont « Dans l'ICP » vaut « oui » ou
« oui, en partie ».

Dis-moi combien il y en a, et quelle proportion de l'export total ça
représente.

Écarte ensuite, en me montrant chaque ligne écartée et pourquoi :
- mes concurrents, toute boîte dont l'offre recoupe la mienne
- les boîtes dont le résumé est INCONNU, que je vérifierai à la main
- les doublons, sur le domaine du site

Ce qui reste est mon périmètre d'enrichissement. Rien d'autre ne part chez un
outil payant.
```

C'est la règle qui protège ton budget : **une entreprise écartée avant
l'enrichissement ne coûte rien, écartée après elle a coûté ses crédits.**

---

## Ce que tu as à la fin de cette étape

Un Google Sheet avec, pour chaque entreprise de ton périmètre, ce qu'elle fait,
à qui elle vend, et si elle est dans ta cible. C'est ce fichier qui alimente
tout le reste : les contacts à l'étape 05, les mobiles à l'étape 06, les appels
à l'étape 07, le CRM à l'étape 09.

Le détail des deux onglets, des sept règles du fichier et des mises en forme à
poser est dans
[`../references/schema-sheet-outbound.md`](../references/schema-sheet-outbound.md).

## Étape suivante

[`03-qualifier-son-marche.md`](03-qualifier-son-marche.md), pour affiner la
qualification et sortir tes premiers lots de 30 comptes à appeler.
