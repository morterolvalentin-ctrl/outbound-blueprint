# 03 · Construire son dictionnaire de postes

**Quand l'utiliser :** une fois, au démarrage de chaque verticale. Vingt minutes.

**Où :** n'importe quelle conversation Claude.

---

Tu ne veux pas tous les contacts d'une entreprise. L'alternant marketing ne
t'intéresse pas, le directeur de la communication non plus. Le dictionnaire de
postes est la liste des intitulés qui comptent, et surtout la liste de ceux qui
ressemblent aux bons sans en être.

**Le plus simple est de laisser la skill le faire.** `/outbound-setup` construit
ton dictionnaire à partir de ton activité, famille par famille, et te demande
explicitement qui tu as déjà appelé pour rien. Ce prompt est là si tu préfères
le faire à la main, ou le refaire pour une nouvelle verticale.

[`../references/dictionnaire-postes.exemple.json`](../references/dictionnaire-postes.exemple.json)
montre le **format** attendu. C'est un exemple écrit pour une entreprise qui
vend à des directeurs commerciaux dans l'automobile : ne le recopie pas, il ne
décrit pas tes acheteurs.

---

```
Je vends [ton offre] à [ta cible].
Mon interlocuteur idéal est celui qui [décris la douleur qu'il vit au quotidien].

Construis-moi un dictionnaire de postes au format JSON, avec quatre clés :

"rangs" : les intitulés à retenir, groupés par famille et par ordre de priorité.
  Pour chaque intitulé, donne les variantes réelles telles qu'elles
  apparaissent sur LinkedIn : féminin et masculin, français et anglais,
  abréviations, et les titres cumulés qu'on trouve en PME où une personne
  porte plusieurs casquettes.

"exclude" : les intitulés qui ressemblent aux bons mais qui n'ont ni le budget
  ni l'influence. Sois impitoyable ici, c'est cette liste qui fait la qualité
  du fichier. Pense aux fonctions de terrain, aux assistants, aux stagiaires
  et alternants, aux fonctions support.

"exclude_geo" : les mentions de pays ou de zone qui signalent une personne
  hors de mon marché géographique, telles qu'elles apparaissent dans les
  intitulés LinkedIn.

"note" : une phrase qui dit ce que ce dictionnaire oriente et ce qu'il laisse
  passer volontairement.

Contraintes de format :
- tout en minuscules, sans accent, pour que la comparaison soit insensible
  à la casse et aux accents
- inclus les variantes à apostrophe droite ET à apostrophe courbe
- pas de doublon entre "rangs" et "exclude"

Ensuite, explique-moi en 5 lignes qui contacter en priorité selon la taille de
l'entreprise : moins de 10 commerciaux, de 10 à 30, plus de 30.

Avant de me rendre le JSON, pose-moi ces deux questions et attends mes
réponses :
- quels intitulés ressemblent aux bons sans en être, dans MON marché ?
- qui ai-je déjà appelé pour rien ?
Ce sont mes réponses qui remplissent "exclude", pas ton modèle générique.
```

Enregistre le résultat dans `~/.claude/outbound/dictionnaire-postes.json` :
c'est le fichier que lisent les skills.

---

## Ce que ça change

Sans dictionnaire, un outil d'extraction te rend 40 personnes par entreprise et
tu paies l'enrichissement de 37 d'entre elles pour rien. Avec, tu descends à
2 ou 3 personnes par PME, et tu ne paies que celles-là.

## Étape suivante

[`04-trouver-les-contacts.md`](04-trouver-les-contacts.md)
