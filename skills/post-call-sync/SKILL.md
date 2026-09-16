---
name: post-call-sync
description: >
  Traite une session de cold calls. Lit les lignes surlignées du fichier de
  prospection, classe chaque ligne à partir de la colonne Notes, croise avec
  la boîte mail et l'agenda pour établir les mails partis et les rendez-vous
  pris, écrit les colonnes de suivi, puis pousse dans le CRM : entreprise,
  contact, et deal quand il y a un rendez-vous. Idempotent, et refuse d'écrire
  une ligne dont le nom ne correspond pas.
  Use when the user says "/post-call-sync", "traite mes appels du jour",
  "mets à jour le fichier outbound", "j'ai fini ma session de cold call".
---

# Traiter une session de cold calls

L'utilisateur surligne les lignes qu'il vient de traiter et écrit ce qui s'est
passé dans la colonne `Notes`, en langage libre. Cette procédure transforme ces
notes en statuts exploitables, vérifie les faits déclarés contre la boîte mail
et l'agenda, et propage dans le CRM.

## Les couleurs, c'est l'utilisateur qui les donne, à chaque session

Il annonce dans sa demande ce que veut dire chaque surlignage. Ne rien inférer,
ne rien coder en dur, ne pas se fier à ce qu'une session précédente utilisait :
ni la teinte, ni le nombre de couleurs, ni leur sens ne sont stables.

Le sens habituel, deux couleurs :

| Ce qu'il dit | Effet |
|---|---|
| « les X, je viens de les appeler » | Nb appels +1, Dernier appel = aujourd'hui, Statut selon la note |
| « les Y, je ne les ai pas appelés, il ne faut pas rappeler » | `Ne pas contacter`, **compteur et date laissés intacts** |

Une ligne du second groupe n'a pas été appelée : lui incrémenter son compteur
invente un appel et fausse le taux de décroché de la session.

Si une couleur trouvée dans le fichier n'a pas été expliquée, demander. Ne
jamais deviner.

## Les étapes

**1. Récupérer les lignes surlignées.** Un fond de couleur posé à la main ne se
lit pas par une API de valeurs, il faut lire la grille avec ses formats. Est
surlignée toute ligne dont le fond n'est ni blanc ni transparent. Regrouper par
couleur exacte, puis appliquer le sens donné par l'utilisateur. Deux nuances
proches peuvent porter le même sens : c'est lui qui le dit, pas la valeur
hexadécimale.

**2. Classer depuis la colonne Notes.** Cinq valeurs de statut, et cinq
seulement :

| Ce que dit la note | Valeur écrite |
|---|---|
| personne n'a décroché : répondeur, messagerie, sonnerie, ligne morte | `Rappeler` |
| a décroché et c'est non, ne veut pas être rappelé, mauvais interlocuteur | `Réponse négative` |
| hors cible, plus en poste, ligne personnelle | `Ne pas contacter` |
| le prospect a dit oui : rendez-vous pris, ou il demande lui-même un mail pour le caler | `Réponse positive` |
| on lui a écrit après l'appel, mais il n'a pas dit oui | `Qualifié` |

La frontière entre les deux dernières, c'est ce que **le prospect** a dit, pas ce
que l'utilisateur a fait. Écrire à quelqu'un qui a opposé une objection, ou qui
n'a rien répondu, c'est `Qualifié`. Les deux vont dans le CRM.

Ne jamais écrire les états d'entrée de l'utilisateur (`À appeler`,
`À enrichir`). Une ligne annoncée comme appelée mais sans appel réel garde son
état d'entrée.

**3. Vérifier contre la boîte mail et l'agenda.** La note dit l'intention, les
preuves disent ce qui existe. Un rendez-vous n'est un rendez-vous que s'il y a
un événement. Un mail n'est un mail que s'il est dans les envoyés.

**4. Écrire le fichier.** Statut, Nb appels (tentatives sortantes), Dernier appel
(jamais la date du mail), Prochaine action.

**5. Pousser dans le CRM**, dans cet ordre : entreprise, puis contact, puis deal.
Un deal uniquement s'il y a un rendez-vous confirmé par un événement agenda.
Jamais de deal pour un mail seul. Puis revenir écrire les colonnes de synchro
sur la ligne de la personne.

## La règle qui prime sur toutes les autres

**Ne jamais écrire à un numéro de ligne. Toujours écrire à une personne
vérifiée.** Avant chaque écriture, relire prénom et nom de la ligne visée et
comparer, accents normalisés. Si ça ne correspond pas, ne pas écrire et le
signaler. L'utilisateur trie, filtre et édite ce fichier à la main pendant ses
sessions : une ligne peut bouger entre la lecture et l'écriture.

**Une colonne se désigne par le nom exact de son en-tête, jamais par sa lettre.**

## Conflits entre la note et les preuves

- **La note annonce un rendez-vous, l'agenda est vide** : pas de deal, passer en
  `Rappeler`, et le dire.
- **La note annonce un mail, la boîte ne montre rien** : demander confirmation
  avant de classer. Si l'utilisateur confirme, appliquer et noter que la preuve
  manque.
- **Un mail est parti mais la note n'en parle pas** : le mail fait foi.
- **Un contact est marqué hors cible au niveau de la société** : proposer
  d'étendre `Ne pas contacter` à toutes les lignes de cette société, ne pas le
  faire seul.

## Toujours rendre compte de

Les arbitrages pris seuls, les lignes laissées de côté et pourquoi, les conflits
note contre preuve, et les lignes refusées par la garde nominale.
