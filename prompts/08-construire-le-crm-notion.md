# 07 · Construire le CRM dans Notion

**Quand l'utiliser :** une fois, au démarrage. Compte une heure, dont cinquante
minutes où tu regardes Claude travailler.

**Où :** une conversation Claude avec le connecteur Notion branché.

**Ce que ça remplace :** un CRM du marché à 1 000 ou 1 500 € par an et par siège.
Ici, dix euros par mois, souvent gratuits les premiers mois.

---

## Le modèle en trois objets

Un CRM, c'est trois tableaux reliés. Une **personne** travaille dans une
**entreprise** ; quand une discussion commerciale démarre avec elle, on ouvre un
**deal**. Tout le reste se calcule.

Un quatrième tableau, les **comptes rendus de rendez-vous**, se branche dessus
et met à jour les dates de dernier contact tout seul.

---

## Le prompt

Colle-le tel quel. Réponds aux questions qu'il te pose, il construit le reste.

```
Construis-moi un CRM complet dans Notion, dans la page [URL DE TA PAGE NOTION].

Crée QUATRE bases reliées entre elles, avec les propriétés, les formules et les
vues décrites ci-dessous. Crée-les dans cet ordre : Entreprises, Contacts,
Deals, Meetings, parce que les relations dépendent des bases précédentes.

═══════════════════════════════════════════════
BASE 1 · 🏢 Entreprises · une ligne par société
═══════════════════════════════════════════════
- Nom (titre)
- Site (url)
- Verticale (select) : à adapter à mon marché, demande-moi la liste
- Taille équipe commerciale (select) : 1-2, 2-10, 10-30, 30+
- Segment (formule) : à partir de Taille équipe commerciale,
    30+ → "P3 · Grand compte"
    10-30 → "P1 · Cible prioritaire"
    2-10 → "P2 · Cible secondaire"
    1-2 → "P4 · Trop petit"
- Tier (select) : A, B, C. Mon jugement sur la valeur du compte
- Contacts (relation vers 👤 Contacts, bidirectionnelle)
- Deals (relation vers 💼 Deals, bidirectionnelle)
- Etat (rollup sur Contacts.Etat rang, fonction maximum, converti en libellé) :
  l'entreprise prend l'état de son contact le plus avancé
- Dernier contact (rollup sur Contacts.Dernier contact, fonction la plus récente)

═══════════════════════════════════════════════
BASE 2 · 👤 Contacts · une ligne par personne
═══════════════════════════════════════════════
- Nom (titre)
- Poste (texte)
- LinkedIn (url) · C'EST LA CLÉ ANTI-DOUBLON, elle prime sur le nom
- E-mail (email), Téléphone (téléphone)
- Entreprise (relation vers 🏢 Entreprises) · OBLIGATOIRE
- Etat (select, dans cet ordre) : Lead, Qualifié, Opportunité, Won, Lost
- Etat modifié le (date)
- Etat rang (formule) : Lost → 1, Lead ou vide → 2, Qualifié → 3,
  Opportunité → 4, Won → 5. Sert au rollup de l'entreprise
- Dernier contact (date) : le dernier échange réel
- Prochaine action (date, avec rappel) : la prochaine relance planifiée
- Relance due (formule) : "⚠️ Relancer" si l'Etat est Qualifié ou Opportunité
  ET que Dernier contact est vide ou date de plus de 14 jours. Sinon vide
- Canal (select) : Cold call, Manuel, Import, Réseau
- Source (select) : Réseau, Réseau éloigné, LinkedIn, Cold message,
  Recommandation, Événement, Autre
- Type de personne (select) : Prospect, Client, Personne d'intérêt, Concurrent
- Owner (personne)
- Deals (relation vers 💼 Deals), Meetings (relation vers 🎤 Meetings)
- Commentaires (texte long)

═══════════════════════════════════════════════
BASE 3 · 💼 Deals · une ligne par discussion commerciale
═══════════════════════════════════════════════
- Nom (titre), au format « Entreprise · [ma société] »
- Entreprise (relation) · OBLIGATOIRE
- Contacts (relation, plusieurs possibles) · OBLIGATOIRE
- Phase (select, dans cet ordre) :
    1. Prise de besoin prévue
    2. Preuve à envoyer
    3. Retour sur la preuve
    4. Négociation en cours
    5. Contrat envoyé
    6. Contrat signé
    7. Perdu
  Demande-moi de renommer les phases 2 et 3 selon ce que j'envoie réellement
  pour convaincre : échantillon, pilote, audit, maquette, essai gratuit
- Phase modifiée le (date)
- Jours dans la phase (formule) : nombre de jours entre aujourd'hui et
  Phase modifiée le, ou la date de création si elle est vide
- Statut (formule) : phase 6 → "Gagné", phase 7 → "Perdu", sinon "Ouvert"
- Alerte (formule) : "⚠️ En retard" si Statut vaut "Ouvert" et que
  Jours dans la phase dépasse 30, ou dépasse 14 en phase 3
- Priorité (nombre) : 1 = le plus urgent
- Montant annuel (nombre, format monétaire)
- Date signature (date)
- Renouvellement (formule) : Date signature + 1 an
- Rappel renouvellement (formule) : Renouvellement moins 1 mois
- Raison perte (select) : Trop cher, Pas assez bien, Pas le moment,
  Mauvaise cible, Sans réponse, Autre
- Incomplet (formule) : "⚠️" s'il manque l'Entreprise ou les Contacts,
  ou si la phase est 7 sans Raison perte, ou la phase 6 sans Date signature
- Notes (texte long)
- Owner (personne), Meetings (relation)

═══════════════════════════════════════════════
BASE 4 · 🎤 Meetings · un compte rendu par rendez-vous
═══════════════════════════════════════════════
- Titre (titre), Date (date), Type (select) : Prise de besoin, Suivi,
  Négociation, Interne
- Contacts (relation) · OBLIGATOIRE, sinon le compte rendu n'apparaît nulle part
- Deals (relation)
- Compte rendu (texte long)

═══════════════════════════════════════════════
LES VUES
═══════════════════════════════════════════════
👤 Contacts
- 🔔 À relancer : Prochaine action posée, OU Relance due allumée.
  Triée par Prochaine action croissante. C'EST LA VUE DU MATIN
- 🧊 Leads à contacter : Etat = Lead ou vide
- 🗂 Par Etat : kanban groupé par Etat
- 📋 Tous les contacts : sans filtre

💼 Deals
- 🚀 Pipeline : kanban groupé par Phase, trié par Priorité. LA VUE DE LA SEMAINE
- ⚠️ En retard : Alerte allumée
- 📅 Renouvellements : Statut = Gagné, trié par Rappel renouvellement croissant
- 📋 Tous les deals : sans filtre

🏢 Entreprises
- 🎯 Par segment : groupé par Segment, P1 en premier
- 📋 Toutes : sans filtre

═══════════════════════════════════════════════
APRÈS CONSTRUCTION
═══════════════════════════════════════════════
1. Crée une entreprise, un contact et un deal de test, vérifie que chaque
   formule et chaque rollup rend bien la valeur attendue, puis supprime-les
2. Donne-moi la liste des formules que Notion a refusées ou ajustées
3. Écris-moi le mode d'emploi en une page, dans la page parente
```

---

## Les six règles qui font vivre ce CRM

Aucun outil ne les applique à ta place. Elles tiennent en six lignes et elles
valent plus que toutes les colonnes.

1. **Jamais de contact sans entreprise.** Il sort de tous les calculs.
2. **Un deal s'ouvre quand un rendez-vous de prise de besoin est calé**, pas
   avant. Avant, le contact est simplement Qualifié.
3. **Un deal ne stagne pas.** Soit il avance, soit il passe en Perdu, avec sa
   raison. Un pipeline propre vaut mieux qu'un gros pipeline.
4. **`Dernier contact` à jour après chaque échange.** C'est la date qui fait
   tourner toutes les alertes de relance.
5. **Jamais de perte sans `Raison perte`.** Sinon l'analyse de tes pertes est
   fausse, et c'est la seule analyse qui te fait progresser.
6. **Ne renomme pas les champs** une fois que des scripts ou des prompts les
   cherchent par leur nom. Ajouter un champ ne casse rien, renommer casse tout.

## La routine

- **Chaque matin, 5 minutes** : vue 🔔 À relancer. Pour chaque ligne, tu relances,
  tu mets `Dernier contact` à aujourd'hui, tu poses ou tu vides
  `Prochaine action`.
- **Chaque semaine, 15 minutes** : vue 🚀 Pipeline puis ⚠️ En retard. Chaque deal
  en retard : relance, ou passage en Perdu avec sa raison.
- **Chaque mois** : vue 🎯 Par segment pour choisir la prochaine vague, et
  📅 Renouvellements.

## Aller plus loin : la cohérence automatique

Les formules ci-dessus calculent, mais elles n'écrivent pas. Quatre règles
doivent tenir la cohérence entre deals et contacts. Tu peux les faire tourner à
la main en une commande, ou les automatiser plus tard.

```
Passe en revue mon CRM et applique ces règles, dans cet ordre.
N'écris que si la valeur change, et fais-moi la liste de ce que tu as modifié.

1. Deal en phase 7. Perdu → ses contacts passent Lost, SAUF ceux déjà Won et
   SAUF ceux qui ont un autre deal encore ouvert
2. Deal en phase 6. Contrat signé → ses contacts passent Won
3. Deal ouvert (phases 1 à 5) → ses contacts Lead, Qualifié ou sans Etat
   passent Opportunité. Un contact Lost relié à un deal ouvert RESTE Lost :
   il est sorti de la boucle, le deal continue avec les autres
4. Deal ouvert dont TOUS les contacts sont Lost → le deal passe en 7. Perdu,
   avec une ligne datée dans Notes. La raison de perte reste à moi
5. Un Etat ou une Phase a changé sans que la date soit posée → pose
   « Etat modifié le » ou « Phase modifiée le » à aujourd'hui
6. Un meeting daté d'aujourd'hui ou d'avant, relié à des contacts → avance leur
   « Dernier contact » à la date du meeting, sans jamais la reculer
```

Le piège de la règle 3 : un contact perdu ne ferme pas un deal. Il ne le ferme
que s'il était le dernier contact actif. Sinon tu fermes le deal toi-même, ou
tu ajoutes le bon interlocuteur.

## Étape suivante

[`09-traiter-une-session-dappels.md`](09-traiter-une-session-dappels.md)
