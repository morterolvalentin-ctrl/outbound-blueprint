# 04 · Trouver les contacts dans les entreprises retenues

**Quand l'utiliser :** après avoir validé le périmètre en étape 02.

**Où :** une conversation Claude, avec ton outil d'extraction branché en MCP.

---

## L'ordre compte, et il fait économiser

1. **Ce que tu as déjà.** Ton fichier, tes exports, tes anciens contacts. Gratuit.
2. **Ce que tu peux extraire.** Un outil d'extraction LinkedIn facture autour de
   deux centimes par profil rendu, et le comptage est gratuit avant de lancer.
3. **Ce que tu enrichis.** C'est l'étape 05, et c'est là que tout l'argent part.

L'étape 1 est celle que tout le monde saute. Sur un lot réel, la moitié des
appels à l'outil d'extraction tombe simplement parce qu'on a regardé d'abord ce
qu'on avait déjà.

---

## Prompt A · récupérer ce qu'on a déjà, sans dépenser

```
Dans [mon fichier / mes onglets de contacts déjà connus], trouve les personnes
qui travaillent dans les entreprises de mon lot.

Filtre sur mon dictionnaire de postes : garde les intitulés de "rangs",
écarte ceux de "exclude", en comparant en minuscules et sans accent.

Garde au maximum 2 personnes par entreprise.

Dédoublonne contre mon fichier de prospection sur DEUX clés, pas une :
- l'URL LinkedIn normalisée (sans paramètres, sans slash final, en minuscules)
- et le triplet prénom + nom + domaine de l'entreprise

Les deux sont nécessaires : un même profil peut apparaître sous deux URL
différentes, et deux URL différentes peuvent désigner la même personne à
l'encodage près.

Rends-moi deux listes :
- les contacts trouvés, prêts à écrire
- les entreprises pour lesquelles tu n'as trouvé AUCUN contact
La seconde liste est la seule qui partira chez un outil payant.
```

## Prompt B · compter avant de payer

```
Pour les entreprises sans aucun contact, prépare la requête d'extraction :
filtre sur l'entreprise, et sur les intitulés de poste de mon dictionnaire
("rangs" en inclusion, "exclude" en exclusion).

Lance d'abord le COMPTAGE, qui est gratuit et exact.

Puis annonce-moi, avant toute dépense :
- le nombre de profils qui seront facturés
- le coût unitaire et le coût total
- mon solde actuel

Et attends mon accord explicite. N'exécute rien tant que je n'ai pas répondu.
```

## Prompt C · choisir qui contacter dans chaque entreprise

```
Pour chaque entreprise du lot, sélectionne les personnes à retenir selon sa
taille d'équipe commerciale :

- moins de 10 commerciaux : le dirigeant ou le fondateur d'abord, puis le
  responsable commercial
- de 10 à 30 : le directeur commercial d'abord, puis les opérations commerciales
- plus de 30 : une seule personne, côté opérations commerciales ou CRM

Deux personnes par entreprise au maximum dès que c'est payant.

Explique-moi ton choix pour les 5 premières, que je vérifie ta logique.
```

---

## Les règles qui ne se négocient pas

1. **On paie au résultat, jamais à la requête.** Un échec ne coûte rien chez la
   plupart des fournisseurs. Ne jamais pré-filtrer « pour économiser », il n'y a
   rien à économiser.
2. **Compter d'abord.** Le comptage est gratuit et exact chez la plupart des
   outils d'extraction. Aucune dépense sans un chiffre annoncé.
3. **Une colonne se désigne par le nom de son en-tête, jamais par sa lettre.**
   Tu vas trier et réordonner ce fichier à la main pendant tes sessions. Une
   colonne qui passe de F à L dans la journée, c'est normal. Un script qui écrit
   en dur dans la colonne F écrase la mauvaise donnée.

## Étape suivante

[`05-enrichir-les-mobiles.md`](05-enrichir-les-mobiles.md)
