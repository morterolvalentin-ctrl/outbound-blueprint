# 00 · Le setup complet, en un prompt

**Ce que ça fait :** monte toute la machine d'outbound téléphonique en une seule
conversation. La verticale, le fichier de qualification, le dictionnaire de
postes, le script d'appel, le CRM Notion et la routine.

**Combien de temps :** une demi-journée, dont l'essentiel à regarder et valider.

**Ce qu'il te faut avant de commencer :**

- Claude, avec les connecteurs Google Sheets et Notion branchés
- un compte chez un outil d'extraction de contacts LinkedIn
- un compte chez un outil d'enrichissement de numéros
- une solution de téléphonie qui s'intègre à ton CRM
- au moins un client existant, idéalement connu dans sa verticale

Si tu préfères y aller pièce par pièce, prends les prompts 01 à 08 dans l'ordre.
Ils font la même chose, avec plus d'explications à chaque étape.

---

```
Tu vas m'aider à monter une machine de prospection téléphonique complète, de
zéro. Je veux, à la fin de cette conversation : une liste d'entreprises
qualifiées, les bons contacts dedans, un script d'appel, un CRM, et une routine
quotidienne.

Procède en SIX phases. À la fin de chaque phase, tu t'arrêtes, tu me montres ce
que tu as produit, et tu attends mon accord explicite avant de continuer.
Ne saute jamais un arrêt, même si la phase te paraît évidente.
Si une dépense est engagée, tu annonces d'abord le nombre d'unités, le coût
maximum et mon solde.

═══ PHASE 1 · LE CADRE ═══
Pose-moi ces questions, une par une, et attends ma réponse à chacune :
1. Qu'est-ce que tu vends, en deux phrases, avec le problème que ça résout ?
2. Qui sont tes clients actuels, dans quel secteur, et pour quel montant ?
3. Quel est ton panier moyen, et ta fourchette basse et haute ?
4. Parmi tes clients, y en a-t-il un qui soit connu dans son secteur ?
5. Quel travail de terrain as-tu produit, ou peux-tu produire cette semaine,
   sur le marché que tu vises ? Une étude, un comptage, un benchmark, un audit.

Sur la question 5 : si la réponse est « rien », arrête-toi et dis-le-moi
franchement. Sans raison non commerciale d'appeler, le reste ne sert à rien.
Propose-moi alors trois travaux de terrain réalisables en une semaine sur mon
marché.

Puis propose-moi 4 verticales possibles, et classe-les sur un seul critère :
celle où je peux dire « on travaille déjà avec X » à quelqu'un qui connaît X.
Ce critère prime sur la taille du marché.

→ ARRÊT. Je choisis la verticale.

═══ PHASE 2 · LA BASE ET LA LISTE ═══
D'abord, d'où vient la base. Explique-moi l'export d'ENTREPRISES (pas de
contacts) depuis un outil comme Icypeas, sur trois critères : le pays que je
prospecte, une FOURCHETTE d'effectif (jamais un minimum seul), et un volume
maximum qui pilote ma dépense de crédits.

Déduis la fourchette d'effectif de mon panier moyen et de mes clients actuels,
et propose-la-moi.

Fais-moi commencer par un export de 500 à 1 000 entreprises, pas plus : la
qualification ci-dessous me donnera mon taux réel de « dans l'ICP », et je
saurai alors comment calibrer un export plus large.

→ ARRÊT. Je valide les critères et le volume avant de dépenser.

Ensuite, construis un Google Sheet de prospection avec ces colonnes, dans cet
ordre :
ID, Lot demandé, Entreprise, Domaine, Verticale, Taille équipe commerciale,
Résumé entreprise, Prénom, Nom, Poste, LinkedIn, E-mail, Mobile,
Source contact, Source mobile, Enrichi le, Statut, Nb appels, Dernier appel,
Prochaine action, Notes, Dans CRM, Etat CRM, Lien CRM, Sync le, Ajouté le.

Verse l'export dedans, puis qualifie chaque entreprise avec DEUX colonnes :

« Résumé entreprise », une ligne :
<Ce que fait la boîte>. Clients : <types de clients B2B>.

« Dans l'ICP », un verdict parmi : oui / oui, en partie / partiel / indirect /
non.

Clients B2B uniquement, jamais les particuliers. Si tu ne sais pas : INCONNU,
tu n'inventes jamais.

Travaille par lots de 50 lignes et montre-moi le premier lot avant de
continuer, que je vérifie que tu as compris ma cible. C'est le moment le plus
important : une erreur vue sur 50 lignes coûte trente secondes, la même erreur
vue au téléphone coûte la journée.

Écarte ensuite mes concurrents et les boîtes mal classées, et montre-moi ce que
tu écartes et pourquoi.

→ ARRÊT. Je valide le périmètre, entreprise par entreprise si je veux.

═══ PHASE 3 · LES CONTACTS ═══
D'abord, construis mon dictionnaire de postes en JSON : "rangs" (les intitulés
à retenir, groupés par famille, avec toutes les variantes LinkedIn réelles,
féminin, masculin, français, anglais, abréviations), "exclude" (ceux qui
ressemblent aux bons sans avoir ni budget ni influence), "exclude_geo".
Tout en minuscules, sans accent.

→ ARRÊT. Je valide le dictionnaire.

Ensuite, dans cet ordre, et seulement dans cet ordre :
1. Ce que j'ai déjà dans mes fichiers. Gratuit.
2. Le comptage chez l'outil d'extraction sur les entreprises sans aucun contact.
   Gratuit et exact.
   → ARRÊT. Tu m'annonces le coût, j'accepte ou je refuse.
3. L'extraction.
Dédoublonne sur DEUX clés : l'URL LinkedIn normalisée, et prénom + nom + domaine.

Deux personnes par entreprise au maximum. Qui, selon la taille de l'équipe
commerciale : moins de 10 → dirigeant puis responsable commercial ; 10 à 30 →
directeur commercial puis opérations ; plus de 30 → une seule personne côté
opérations ou CRM.

→ ARRÊT. Je relis le fichier.

═══ PHASE 4 · LES NUMÉROS ═══
Annonce-moi le nombre de personnes, le coût maximum, mon solde, et rappelle
qu'un échec coûte zéro.

→ ARRÊT. Je valide la dépense.

Filtre pays obligatoire. Puis trie toi-même les numéros rendus : mobile
national, fixe national, étranger en dernier et jamais seul. N'écris jamais le
premier numéro rendu sans l'avoir trié, l'API ne classe pas ses résultats.

Écris les échecs aussi : « non trouvé » et la date. Sinon je repaie la même
personne au lot suivant.

═══ PHASE 5 · LE SCRIPT ═══
Écris mon script de cold call, 25 secondes maximum, six blocs dans cet ordre :
1. Prénom + société
2. Vérification d'identité en question fermée : « Vous êtes bien [Prénom] au
   [Poste] chez [Entreprise] ? »
3. Ce que je fais, en une phrase sans jargon
4. Ma raison d'appeler qui n'est pas commerciale, appuyée sur mon travail de
   terrain, avec un chiffre PRÉCIS et NON ARRONDI
5. Mon client référence
6. La demande de 20 minutes, en question fermée à deux créneaux

Interdits : superlatifs, « leader », « solution », questions ouvertes,
« est-ce que ça vous intéresse », « je me permets de vous déranger ».

Donne-moi aussi les 5 objections les plus probables et une réponse de deux
phrases pour chacune, qui ramène à la demande de rendez-vous.

→ ARRÊT. Je le lis à voix haute et je le chronomètre.

═══ PHASE 6 · LE CRM ═══
Construis dans Notion quatre bases reliées : 🏢 Entreprises, 👤 Contacts,
💼 Deals, 🎤 Meetings, avec leurs propriétés, leurs formules et leurs vues.
Le détail complet est dans le prompt 08 de ce dépôt : applique-le tel quel.

Les deux vues qui comptent : « 🔔 À relancer » dans Contacts, cinq minutes
chaque matin, et « 🚀 Pipeline » dans Deals, quinze minutes chaque semaine.

Crée un jeu de test, vérifie chaque formule, supprime-le, puis écris-moi le
mode d'emploi en une page.

═══ POUR FINIR ═══
Rends-moi :
- le lien du Sheet et le lien du CRM
- ma routine quotidienne et hebdomadaire, en six lignes
- la liste des arbitrages que tu as pris seul
- ce que tu n'as pas pu faire et pourquoi
```

---

## Une fois que c'est monté

Tu n'as plus besoin de ce prompt. Au quotidien, deux seulement :

- **le matin** : [`09-traiter-une-session-dappels.md`](09-traiter-une-session-dappels.md), pour la session de la veille
- **quand tu veux un nouveau lot** : la skill [`outbound-batch`](../skills/outbound-batch/SKILL.md)
