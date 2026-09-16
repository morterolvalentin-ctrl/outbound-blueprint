# 08 · Traiter une session d'appels

**Quand l'utiliser :** le soir, après chaque session de cold call.

**Où :** une conversation Claude avec ton Sheet, ton agenda et ta boîte mail
branchés.

**Ce que ça remplace :** environ deux heures de saisie manuelle pour 100 appels.

---

## La boucle, en trois temps

**Pendant les appels.** Tu travailles ligne par ligne dans le fichier. Tu colores
la ligne en cours, ce qui t'évite d'appeler Jean-Michel en croyant parler à
Philippe. Et surtout, tu écris dans la colonne `Notes` ce qui s'est réellement
passé, en langage libre. Cinq secondes par appel.

**Le soir.** Claude lit les lignes surlignées, classe chacune à partir de sa note,
vérifie contre ton agenda et tes mails envoyés, et écrit les statuts.

**Ensuite.** Seuls les qualifiés partent dans le CRM.

---

## Prompt · classer la session

```
Traite ma session d'appels d'aujourd'hui dans [mon fichier de prospection].

LES COULEURS. Je te les donne à chaque session, ne devine jamais :
- les lignes en [couleur A] : je viens de les appeler
- les lignes en [couleur B] : je ne les ai pas appelées, il ne faut plus les
  contacter
Si tu trouves une couleur dont je ne t'ai pas parlé, demande-moi. N'invente pas.

Une ligne du second groupe n'a PAS été appelée : ne touche ni à son compteur
d'appels ni à sa date de dernier appel. L'incrémenter inventerait un appel et
fausserait mon taux de décroché.

CLASSEMENT depuis la colonne Notes. Cinq valeurs de Statut, et cinq seulement :

| Ce que dit la note | Statut |
|---|---|
| personne n'a décroché : répondeur, messagerie, sonnerie, ligne morte | Rappeler |
| a décroché et c'est non, ne veut pas être rappelé, mauvais interlocuteur | Réponse négative |
| hors de ma cible, plus en poste, ligne personnelle | Ne pas contacter |
| le prospect a dit oui : rendez-vous pris, ou il demande lui-même un mail pour le caler | Réponse positive |
| je lui ai écrit après l'appel, mais il n'a pas dit oui | Qualifié |

LA FRONTIÈRE entre les deux dernières, c'est ce que LE PROSPECT a dit, pas ce
que j'ai fait. Envoyer un mail à quelqu'un qui a opposé une objection, ou qui
n'a rien répondu, c'est « Qualifié ». Les deux vont dans le CRM.

Ne mets jamais « À appeler » ni « À enrichir » : ce sont mes états d'entrée,
on n'y touche pas.

VÉRIFICATION. La note dit l'intention, l'agenda et les mails disent ce qui
existe :
- un rendez-vous n'est un rendez-vous que s'il y a un événement dans l'agenda
  avec cette personne
- un mail n'est un mail que s'il est dans mes envoyés, vers le domaine du
  prospect, daté d'aujourd'hui

En cas de conflit :
- la note annonce un rendez-vous, l'agenda est vide → pas de deal, statut
  « Rappeler », et tu me le signales
- la note annonce un mail, la boîte ne montre rien → demande-moi confirmation
  avant de classer
- un mail est parti mais la note n'en parle pas → LE MAIL FAIT FOI

ÉCRITURE. Colonnes Statut, Nb appels (tentatives sortantes uniquement),
Dernier appel (jamais la date du mail), Prochaine action.

LA RÈGLE QUI PRIME SUR TOUTES LES AUTRES : n'écris jamais à un numéro de ligne,
écris toujours à une personne vérifiée. Avant chaque écriture, relis le prénom
et le nom de la ligne visée et compare-les, accents normalisés. Si ça ne
correspond pas, n'écris pas et signale-le-moi. Je trie et je filtre ce fichier
à la main pendant mes sessions, une ligne peut bouger entre ta lecture et ton
écriture.

RENDS-MOI COMPTE de : les arbitrages que tu as pris seul, les lignes laissées de
côté et pourquoi, les conflits entre note et preuve, les lignes refusées par la
garde nominale.
```

## Prompt · pousser dans le CRM

```
Prends les lignes passées en « Réponse positive » ou « Qualifié » et qui ne
sont pas encore dans Notion.

Dans cet ordre, pour chacune :
1. ENTREPRISE. Cherche-la dans la base Entreprises. Si elle existe, rattache le
   contact à la fiche existante. Ne crée JAMAIS de doublon. Si elle manque,
   crée-la avec son nom, sa verticale et la taille de son équipe commerciale
2. CONTACT. Crée-le, relié à l'entreprise. Etat = Qualifié. Canal = Cold call.
   Source = Cold message. Type = Prospect. Téléphone = le mobile du fichier.
   Commentaires = la note d'appel recopiée verbatim. Dernier contact = la date
   du dernier appel. Etat modifié le = aujourd'hui
3. DEAL, uniquement s'il y a un rendez-vous CONFIRMÉ par un événement agenda.
   Jamais pour un mail seul. Nom = « Entreprise · [ma société] », Phase = 1,
   Phase modifiée le = aujourd'hui, relié à l'entreprise et au contact

Puis reviens écrire dans le fichier, sur la ligne de la personne : Dans Notion,
Etat Notion, Lien Notion, et la date de synchro.

Sois idempotent : si je relance ce prompt demain, tu ne dois rien recréer.
```

---

## Ce qui fait que ça marche

**La note d'appel.** Cinq secondes pendant l'appel, en langage libre, mais
précise : « messagerie, c'est bien la bonne personne », « rendez-vous jeudi 14h »,
« pas intéressé, ne jamais rappeler », « a demandé un mail de présentation ».
C'est le carburant de toute la chaîne. Une note vague donne un statut faux.

**La vérification contre les faits.** Sur une session réelle, sept mails partis
sur onze n'étaient mentionnés dans aucune note. Si tu classes uniquement depuis
tes notes, tu perds un tiers de ton travail.

## Retour au sommaire

[`../README.md`](../README.md)
