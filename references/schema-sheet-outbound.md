# Le fichier de prospection : les colonnes

Un seul onglet, une ligne par personne. Tout le reste de la chaîne lit et écrit
ici. Adapte les noms à ta langue, mais garde la logique des groupes.

## Identification

| Colonne | Contenu | Qui la remplit |
|---|---|---|
| `ID` | Identifiant unique et stable, jamais réutilisé. C'est la clé d'écriture | automatique |
| `Lot demandé` | Le libellé générique du lot, un seul par lot. Sert à comparer les taux de réponse entre lots | toi |
| `Ajouté le` | Date d'entrée dans le fichier | automatique |

## L'entreprise

| Colonne | Contenu |
|---|---|
| `Entreprise` | Raison sociale |
| `Domaine` | Le domaine du site, sert de clé de regroupement |
| `Verticale` | Le marché qu'elle adresse |
| `Taille équipe commerciale` | 1-2 / 2-10 / 10-30 / 30+ |
| `Résumé entreprise` | La phrase de qualification produite à l'étape 02, avec son verdict. Identique sur toutes les lignes d'une même entreprise |

## La personne

| Colonne | Contenu |
|---|---|
| `Prénom`, `Nom` | Sert aussi de garde nominale avant chaque écriture |
| `Poste` | L'intitulé exact, tel qu'il apparaît |
| `LinkedIn` | Clé anti-doublon numéro un |
| `E-mail` | |
| `Mobile` | Le premier numéro après tri, au format international |
| `Source contact` | D'où vient la personne |
| `Source mobile` | Le fournisseur, **ou son échec daté** |
| `Enrichi le` | Date de la tentative d'enrichissement, réussie ou non |

## Le suivi

| Colonne | Contenu |
|---|---|
| `Statut` | À enrichir, À appeler, Rappeler, Réponse négative, Ne pas contacter, Qualifié, Réponse positive |
| `Nb appels` | Tentatives sortantes réelles, jamais incrémenté pour un mail |
| `Dernier appel` | Jamais la date d'un mail |
| `Prochaine action` | Action concrète avec une date |
| `Notes` | Ce qui s'est passé pendant l'appel, en langage libre. **La colonne la plus importante du fichier** |

## La synchro vers le CRM

| Colonne | Contenu |
|---|---|
| `Dans CRM` | oui / non |
| `Etat CRM` | L'état côté CRM, recopié |
| `Lien CRM` | L'URL de la fiche |
| `Sync le` | Date de la dernière synchro |

---

## Les trois règles du fichier

1. **Une colonne se désigne par le nom de son en-tête, jamais par sa lettre.**
   Tu vas réordonner ces colonnes à la main. Un script qui écrit en dur dans la
   colonne F écrasera la mauvaise donnée le jour où tu déplaces une colonne.
2. **On n'écrit jamais à un numéro de ligne.** On écrit à un `ID`, avec une garde
   sur le prénom et le nom. Si le nom ne correspond pas, on n'écrit pas.
3. **Un échec se trace.** Une personne tentée sans succès et non marquée sera
   retentée au lot suivant, et repayée.
