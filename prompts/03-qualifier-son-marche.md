# 02 · Qualifier son marché : à qui vend chaque entreprise

**Quand l'utiliser :** une fois ta base d'entreprises constituée
([`02-constituer-sa-base-entreprises.md`](02-constituer-sa-base-entreprises.md)),
et avant de dépenser un euro d'enrichissement.

**Où :** une conversation Claude avec ton Google Sheet branché en MCP.

---

## Le principe

Un code NAF te dit ce qu'une entreprise **est** sur le papier. Il ne te dira
jamais **à qui elle vend**. C'est pourtant la seule information qui détermine si
elle est une cible.

Deux entreprises partagent le code « commerce de gros d'équipements
automobiles ». La première vend à des garages indépendants partout en France.
La seconde vend uniquement à l'export, à des distributeurs. La première est une
cible parfaite, la seconde te fera perdre un appel. Aucun filtre standard ne les
sépare.

Ce prompt produit, pour chaque entreprise, **un résumé d'une ligne et un verdict**.
C'est ce résumé que tu relis avant de payer quoi que ce soit : une entreprise mal
classée écartée ici ne coûte rien, écartée après enrichissement elle a coûté ses
crédits.

---

## Prompt A · qualifier une liste d'entreprises

```
Tu vas qualifier des entreprises pour de la prospection B2B.

Ce que je vends : [ton offre en 1 phrase]
Ma cible : [ex. : les entreprises qui vendent aux garages automobiles]
Ma source : [onglet du Sheet, fichier CSV, ou liste collée ci-dessous]

Pour CHAQUE entreprise, écris un résumé d'une seule ligne, dans ce format
exact :

<Ce que fait la boîte, une phrase courte>. Clients : <types de clients B2B>. <Ma cible> : <verdict>.

Exemple : Grossiste en pneus, jantes et roues. Clients : garages, négociants
pneus. Garages : oui.

Règles, sans exception :
1. CLIENTS B2B UNIQUEMENT. Tu listes les professionnels qui paient la boîte,
   jamais les particuliers. Une boîte qui vend surtout au grand public le dit
   dans le verdict.
2. LE VERDICT a cinq valeurs, et seulement celles-ci :
   - oui : ma cible est un client direct qui paie
   - oui, en partie : client direct mais une partie seulement de la cible,
     ou avec d'autres canaux dominants
   - partiel : ma cible est un client parmi d'autres, ou marginal
   - indirect : la boîte vend à des intermédiaires (distributeurs, groupements,
     franchisés), ou ma cible est un partenaire ou un utilisateur, pas celui
     qui paie
   - non
   Une nuance courte après une virgule est permise : « oui, mais hors France ».
3. SI TU NE SAIS PAS, tu écris INCONNU. Tu n'inventes jamais un client type.
4. Le résumé dit POURQUOI la boîte est dans la liste, jamais d'où vient
   l'information.

Rends-moi un tableau trié dans cet ordre : non, puis indirect, puis partiel,
puis oui, en partie, puis oui. Avec le compte par verdict en bas.
Les premières lignes sont celles que je vais vouloir écarter, je veux les voir
en premier.
```

## Prompt B · écarter ce qui ne doit pas être appelé

```
Sur la liste qualifiée, écarte maintenant :

1. Mes concurrents directs : toute boîte dont l'offre recoupe la mienne.
   Lis la colonne « offre » ou son site avant de trancher.
2. Les boîtes mal classées : en cas de doute sur ce qu'elles vendent, va voir
   le site et corrige le résumé.
3. Les boîtes déjà présentes dans mon fichier de prospection : on ne reliste
   jamais une boîte déjà traitée, on repart de ses lignes existantes.

Dis-moi ce que tu as écarté et pourquoi, ligne par ligne. Ne supprime rien
sans me le montrer.
```

## Prompt C · sortir un lot à appeler

```
Sors-moi 30 entreprises dont le verdict est « oui » ou « oui, en partie »,
et qui ne sont pas encore dans mon fichier de prospection.

Pour chacune, donne dans la première colonne la phrase de résumé qui justifie
sa présence dans le lot.

Répartis-les par taille d'équipe commerciale et dis-moi la répartition.
```

---

## La règle qui coûte cher si on l'oublie

**Aucune entreprise ne part en enrichissement sans un résumé que tu as relu.**
C'est le seul point de contrôle gratuit de toute la chaîne.

## Étape suivante

[`04-dictionnaire-de-postes.md`](04-dictionnaire-de-postes.md)
