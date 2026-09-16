# 05 · Enrichir les mobiles sans brûler de crédits

**Quand l'utiliser :** en dernier, une fois le fichier de contacts validé.

**Où :** une conversation Claude, avec ton outil d'enrichissement branché.

---

C'est l'étape la plus chère de la chaîne. Un mobile coûte autour de dix fois ce
que coûte un e-mail. Trois pièges coûtent de l'argent réel.

**Piège 1 : le numéro étranger.** Un mobile trouvé hors de ton pays est facturé
plein tarif. Le filtre pays est obligatoire.

**Piège 2 : le filtre ne filtre pas.** Le paramètre de pays oriente la recherche,
il ne garantit pas le résultat. Sur un test réel de 29 personnes, l'API a rendu
un numéro canadien en première position alors qu'un mobile français attendait en
deuxième. Ne jamais écrire aveuglément le premier numéro de la liste.

**Piège 3 : l'échec non tracé.** Une personne tentée sans succès et non marquée
sera retentée au lot suivant. Tu paies deux fois, et tu ne peux mesurer aucun
taux.

---

## Prompt · enrichir proprement

```
Enrichis les mobiles des contacts de mon lot.

AVANT DE LANCER, annonce-moi :
- le nombre de personnes concernées
- le coût MAXIMUM (coût unitaire × nombre de personnes)
- mon solde actuel
- et rappelle qu'un échec coûte zéro
Puis attends mon accord explicite.

Paramètres obligatoires :
- filtre pays sur [ton pays]

TRI DES NUMÉROS RENDUS, dans cet ordre :
1. mobile national
2. fixe national (un fixe reste un numéro utile, on le garde)
3. l'étranger, qui ne part JAMAIS seul dans la colonne Mobile

N'écris jamais le premier numéro de la liste sans l'avoir trié toi-même :
l'API ne classe pas ses résultats.

ÉCRITURE DANS LE FICHIER, par identifiant de ligne et jamais par numéro de
ligne, avec une garde sur le prénom et le nom :
- Mobile : le premier numéro après tri, au format international
- Notes : les autres numéros trouvés
- Source mobile : le nom de l'outil
- Enrichi le : la date du jour
- Statut : « À appeler »

Y COMPRIS SUR LES ÉCHECS : Source mobile = « [outil] : non trouvé » et la date.
Sans cette trace, on repaie la même personne au lot suivant.

Ne passe jamais une ligne en « Rappeler » si son compteur d'appels est à zéro.
« Rappeler » suppose au moins un appel réel. Une ligne jamais appelée reste
« À appeler ».
```

## Prompt · dernier contrôle avant d'appeler

```
Avant que je décroche le téléphone, vérifie dans le fichier :
- deux personnes de deux entreprises différentes qui partagent le même mobile :
  l'un des deux est faux, montre-les-moi
- les numéros mal formatés ou trop courts
- les lignes sans entreprise, sans nom, ou sans statut
```

---

## Sur le choix de l'outil

Ce qui compte n'est pas la marque, c'est le modèle de facturation. Prends un
outil qui facture **au résultat trouvé**, pas à la requête, et qui expose un
filtre pays. Prévois un second fournisseur pour repasser sur les non trouvés du
premier, le recouvrement entre deux bases est loin d'être total.

## Étape suivante

[`06-script-de-cold-call.md`](06-script-de-cold-call.md)
