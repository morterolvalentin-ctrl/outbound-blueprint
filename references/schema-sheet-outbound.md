# Le fichier de prospection

**Un classeur Google Sheets, deux onglets.** C'est la structure du fichier qu'on
utilise tous les jours, réduite à ce qui sert. Elle vaut pour n'importe quelle
verticale.

La séparation en deux onglets n'est pas cosmétique : une entreprise vit une
seule fois, une personne vit plusieurs fois dans la même entreprise. Mélanger
les deux dans un seul onglet t'oblige à recopier le résumé d'entreprise sur
chaque ligne de contact, et à le corriger partout quand il change.

| Onglet | Une ligne = | Quand il se remplit |
|---|---|---|
| **1. Entreprises** | une entreprise | à l'export, puis à la qualification (étape 02) |
| **2. Contacts** | une personne | à l'extraction des contacts (étape 05) |

La jointure entre les deux se fait sur le **domaine du site**, jamais sur le nom
de l'entreprise. Deux entreprises peuvent porter le même nom, jamais le même
domaine.

---

## Onglet 1 · Entreprises

### Identité

| Colonne | Contenu |
|---|---|
| `Domaine` | Le domaine du site, sans `www` ni `https`. **C'est la clé de jointure de tout le fichier** |
| `Entreprise` | La raison sociale |
| `Site web` | L'URL complète |
| `Autres noms` | Marques, anciennes raisons sociales, enseignes. Sert à retrouver une boîte quand un prospect la nomme autrement |

### Segmentation

| Colonne | Contenu |
|---|---|
| `Verticale` | **Liste fermée**, la tienne, une dizaine de valeurs au maximum. Le gros grain : Automobile, CHR, BTP, Santé, Commerce… |
| `Effectif` | Tel que l'export te le rend |
| `Taille équipe commerciale` | `1-2` / `2-10` / `10-30` / `30+`. C'est ce qui détermine qui tu appelles dans la boîte, plus que l'effectif total |

### Qualification, les deux colonnes qui font tout le travail

| Colonne | Contenu |
|---|---|
| `Résumé entreprise` | Une phrase : ce que fait la boîte, et à quels clients professionnels elle vend. Format : `<Ce qu'elle fait>. Clients : <types de clients B2B>.` |
| `À qui elle vend` | **Texte libre**, une à huit valeurs. Le grain fin, et la colonne la plus précieuse du fichier. C'est elle qui te dit si une entreprise est une cible, et aucun code d'activité ne la remplace |
| `Dans l'ICP` | **Liste fermée** : `oui` · `oui, en partie` · `partiel` · `indirect` · `non` · `INCONNU` |
| `Offres / produits` | Ce qu'elle vend, en quelques mots. Sert à repérer tes concurrents |
| `Zone géographique` | National · Local ou régional · Multi-pays · Inconnu. Un « multi-pays » qui ne vend pas chez toi est un appel perdu |

<br>

> **Pourquoi deux colonnes pour la cible, `Verticale` et `À qui elle vend` ?**
> Parce qu'elles ne servent pas à la même chose. `Verticale` est fermée, donc
> filtrable et comptable : elle te dit combien de boîtes tu as par marché.
> `À qui elle vend` est libre, donc fidèle : elle contient « garages poids
> lourds », « carrosseries indépendantes », « concessions VO » là où la
> verticale dit seulement « Automobile ». Tu filtres sur la première pour
> cadrer, tu cherches dans la seconde pour cibler.

### Suivi du lot

| Colonne | Contenu |
|---|---|
| `Lot` | Le libellé générique du lot qui a produit la ligne, un seul par lot. C'est lui qui te permettra de comparer les taux de réponse entre lots |
| `Ajoutée le` | Date d'entrée dans le fichier, au format ISO `AAAA-MM-JJ` |

---

## Onglet 2 · Contacts

### Clé et rattachement

| Colonne | Contenu |
|---|---|
| `ID` | Identifiant unique et stable, jamais réutilisé, au format `OB-0001`, `OB-0002`…. **C'est la seule clé d'écriture autorisée** |
| `Domaine` | La jointure vers l'onglet Entreprises |
| `Entreprise` | Recopié pour la lisibilité, jamais pour la jointure |
| `Lot` | Le lot qui a produit la ligne |

### La personne

| Colonne | Contenu |
|---|---|
| `Prénom` · `Nom` | Servent aussi de **garde nominale** avant chaque écriture |
| `Poste` | L'intitulé exact, tel qu'il apparaît, sans le reformuler |
| `LinkedIn` | Clé anti-doublon numéro un |
| `E-mail` | |
| `Mobile` | Le premier numéro après tri, au format international `+33 6 12 34 56 78`. Garde le format que rend ton outil, ne le normalise pas |
| `Source contact` | D'où vient la personne : ton fichier existant, l'outil d'extraction, une recommandation |
| `Source mobile` | Le fournisseur, **ou son échec** : `<outil> : non trouvé` |
| `Enrichi le` | Date de la tentative, réussie **ou non**, au format ISO |

### Le suivi d'appel

| Colonne | Contenu |
|---|---|
| `Statut` | **Liste fermée** : `À enrichir` → `À appeler` → puis `Rappeler` · `Réponse négative` · `Réponse positive` · `Qualifié` · `Ne pas contacter` |
| `Nb appels` | Tentatives sortantes **réelles**. Jamais incrémenté pour un mail |
| `Dernier appel` | Jamais la date d'un mail |
| `Prochaine action` | Une action concrète, avec une date |
| `Notes` | Ce qui s'est passé pendant l'appel, en langage libre. **La colonne la plus importante du fichier** : c'est elle qui alimente le classement automatique et le CRM |

### La synchro vers le CRM

| Colonne | Contenu |
|---|---|
| `Dans CRM` | oui / non |
| `Etat CRM` | L'état côté CRM, recopié |
| `Lien CRM` | L'URL de la fiche |
| `Sync le` | Date de la dernière synchro |

---

## Les règles du fichier

Elles viennent toutes d'une erreur réelle, et chacune a coûté quelque chose.

**1. Une colonne se désigne par le nom de son en-tête, jamais par sa lettre.**
Tu vas réordonner ces colonnes à la main pendant tes sessions. Chez nous,
`Résumé entreprise` est passée de la colonne F à la colonne L dans la même
journée. Un script qui écrit en dur dans la colonne F écrase alors la mauvaise
donnée, sans rien signaler.

**2. On n'écrit jamais à un numéro de ligne.**
On écrit à un `ID`, après avoir relu le `Prénom` et le `Nom` de la ligne visée.
Si le nom ne correspond pas, on n'écrit pas et on le signale. Si quelqu'un
d'autre édite le fichier pendant que tu travailles, des lignes bougent entre
la lecture et l'écriture : une écriture par indice est une écriture sur le
mauvais prospect.

**3. `Notes` s'ajoute, ne s'écrase jamais.**
On concatène avec ` | `. L'historique d'un prospect tient dans cette colonne, et
un écrasement le supprime définitivement.

**4. Un échec se trace.**
Une personne tentée sans succès et non marquée sera retentée au lot suivant, et
repayée. `Source mobile` = `<outil> : non trouvé`, et la date.

**5. Jamais `Rappeler` sur une ligne à zéro appel.**
`Rappeler` suppose au moins un appel réel. Sinon tu ne distingues plus les
lignes vierges des relances, et ta file d'appels du lendemain est fausse.

**6. Dédoublonne les personnes avant de payer.**
La même personne apparaît sous deux lignes plus souvent qu'on ne le croit :
deux URL LinkedIn différentes, ou une différence d'encodage sur le nom.
Dédoublonne sur l'URL normalisée **et** sur prénom + nom + domaine.

**7. Plafonne les enrichissements par entreprise.**
Quatre personnes au maximum par boîte, servies par ordre de priorité de ton
dictionnaire de postes. Au-delà, tu paies pour appeler des gens qui te
renverront vers les quatre premiers.

---

## Les mises en forme qui évitent des erreurs

À poser une fois, à la création du fichier :

- **figer la ligne d'en-tête** des deux onglets ;
- **validation des données** sur `Verticale`, `Dans l'ICP`, `Statut` et
  `Taille équipe commerciale` : une liste déroulante empêche les fautes de
  frappe qui rendent un filtre faux sans prévenir ;
- **format date** `AAAA-MM-JJ` sur `Ajoutée le`, `Enrichi le`, `Dernier appel`,
  `Prochaine action`, `Sync le` ;
- **format texte brut** sur `Mobile`, sinon Sheets mange le `+` et le zéro
  initial ;
- **un filtre** sur la ligne d'en-tête des deux onglets.
