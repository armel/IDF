# Présentation du salon IDF

## Historique

À partir de fin 2021, le salon EXPERIMENTAL du RRF était régulièrement occupé par une poignée d'OMs. Il l'est toujours depuis. Le besoin de disposer d'un salon privé, afin de pouvoir expérimenter et tester des choses, sans risquer de perturber l'ensemble du réseau RRF, s'est donc fait ressentir.

En avril 2022, en complément du `(75) F1ZPX U` et `(75) F1ZPX V` (Paris 15), ce salon privé s'est quelque peu ouvert. Dans un premier temps, Stéphane F5LGW, Sysop du `(94) F5ZSO V` (Charenton) et Pascal F4ICR, Sysop du `(94) F1ZUJ U` (Créteil) l'ont rejoints.

Au cours de l'été 2022, l'ANFR a commencé à communiquer autour des JO 2024. Une bonne partie de la communauté RA s'est rapidement inquiétée, craignant d'être expulsée de *ses* bandes, sans concertation. On peut dramatiser, mais on peut aussi suivre une autre approche et tenter d'être acteur d'un tel évènement. 

L'idée de créer un salon IDF (Ile de France), permettant de *fédérer* les points d'accès de la région et capable de créer une *bulle* la plus dense possible, s'est donc précisée un peu plus.

En décembre 2022, ce fût au tour d'Olivier F1GWX, Sysop du `(92) F1ZQC V`, de rejoindre le salon IDF.

## Ouverture du salon IDF

Le salon IDF s'inscrit totalement dans la philosophie du RRF. En particulier, il privilégie la radio et impose aux points d'accès d'être 100% radio. Il n'est pas ouvert aux interconnexions. **Si vous n'adhérez pas à l'éthique du RRF, inutile de rejoindre le salon IDF**.

Mais si vous souhaitez rejoindre le salon IDF, sachez qu'il est ouvert à tous les points d'accès: 

- disposant d'un indicatif de station répétitrice (*indicatif en Z*), 
- disposant d'un CTCSS ou d'un DCS **actifs**,
- présents dans les 8 départements de la région Ile de France (75, 77, 78, 91, 92, 93, 94 et 95).

> Si vous êtes Sysop d'un point d'accès proche de la région Ile de France, sans pour autant en faire partie, des exceptions sont possibles et seront étudiées avec bienséance. 

Enfin, le salon IDF est également ouvert aux points d'accès QRP de type hotspot (H ou B) sur simple demande ou invitation d'un [admin](#administrateurs).


## Caractéristiques du salon IDF

Le salon IDF est probablement le salon **s'inscrivant le plus dans l'ADN du RRF**. En particulier, le salon IDF dispose, en totale autonomie vis à vis du RRF:

- de son propre **Tracker** (*RRF + IDF*),
- de son propre **Analyzer** (*RRF + IDF*),
- de sa propre **Sentinel**,
- de son propre **BlockIP**.

Conséquence immédiate, le salon IDF est également **Raptorisable**, à l'image des autres salons *actifs* du RRF (RRF, FON, TEC, INT, BAV, LOC et EXP). Et le salon IDF dispose de **tous les outils de monitoring et de suivi de l'activité**, à portée de clic. 

L'ensemble de la *tuyauterie* tourne sur une instance VMWare ESXi, 2 vCPU, 4 Go, 20 Go d'espace disque, derrière une connexion fibre. Une solution plus pérenne s'imposera peut-être avec le temps, en fonction de l'utilisation. Mais ce salon n'a pas l'ambition de croitre de façon démeusurée et de *cloner* ce qui existe déjà et qui fonctionne très bien, à savoir, le RRF.

![Console Web](https://github.com/armel/IDF/blob/main/images/IDF.png)

# Rejoindre le salon IDF

Vous avez le choix. La [méthode 1](#m%C3%A9thode-1---automatique) permet de tout faire en une seule commande. La [méthode 2](#m%C3%A9thode-2---pas-%C3%A0-pas) permet de suivre les étapes, pas à pas. Elle est donc plus didactique. À vous de choisir.

## Méthode 1 - Automatique

Depuis une simple connexion SSH sur votre Spotnik, entrez la commande:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/armel/IDF/main/idf.sh)"`

C'est tout. 

> Le salon IDF est désormais accessible via la commande `DTMF 104`.

## Méthode 2 - Pas à pas

### Etape 1 - Fichier `restart.idf`

Depuis une simple connexion SSH sur votre Spotnik, téléchargez et copiez le fichier `restart.idf` via la commande:

`wget https://raw.githubusercontent.com/armel/IDF/main/restart.idf -O /etc/spotnik/restart.idf`

Eventuellement, pensez à le rendre exécutable via la commande:

`chmod +x /etc/spotnik/restart.idf`

### Etape 2 - Fichier `Sidf.wav`

Depuis une simple connexion SSH sur votre Spotnik, téléchargez et copiez le fichier `Sidf.wav` via la commande:

`wget https://raw.githubusercontent.com/armel/IDF/main/Sidf.wav -O /usr/share/svxlink/sounds/fr_FR/RRF/Sidf.wav`

### Etape 3 - Mise à jour `Logic.tcl`

Editez le fichier `/usr/share/svxlink/events.d/local/Logic.tcl` afin de modifier la section dédiée à la commande DTMF 104 et pointer sur `restart.idf` au lieu de `restart.reg`.

```
# 104 Regional IDF
  if {$cmd == "104"} {
    puts "Executing external command"
    playMsg "Core" "online"
    exec nohup /etc/spotnik/restart.idf &
    return 1
  }
```

### Etape 4 - Mise à jour du Raptor

Si vous utilisez le Raptor et que vous souhaitez l'utiliser avec le salon IDF, entrez les commandes suivantes:

```
cd /opt/RRFRaptor
git reset --hard
git pull
git checkout feature_idf
```

Vous pouvez alors modifier éventuellement les paramètres par défaut en éditant le fichier `settings.py`. Consultez la documentation du [Raptor](https://github.com/armel/RRFRaptor/tree/feature_idf) si besoin (fichier `README.md`).

# Règles de fonctionnement

**Toutes les bonnes pratiques du RRF s'appliquent au salon IDF**, à l'image des salons annexes FON, TEC, INT, BAV, LOC et EXP. En complément, les stations répétitrices (*indicatif en Z*) sont vivement invitées à activer le Raptor et *bouger* sur les salons du RRF en priorité ou en cas d'activité.

> Exemple, les stations répétitrices `(75) F1ZPX U` et `(75) F1ZPX V` sont *raptorisées* partout, à l'exception du FON et utilisent le salon IDF comme *room de base* (salon de repos). Au passage, cela permet de limiter les déclenchements intempestifs sur les salons du RRF.

## Sentinel

Dans l'immediat, la Sentinel s'activera uniquement sur le TOT et les déclenchements intempestifs COURTS et ISOLES. Elle ne s'activera pas sur les CAMPEURS, pour des raisons évidentes.

### Règle N°0 - TOT
Le TOT est fixé à 5 minutes avec une mise en quarantaine de 10 secondes.

### Règle N°1 - Intempestifs courts
À partir d'un nombre N de déclenchements intempestifs, concentrés dans un laps de temps L, une mise en quarantaine sera appliquée au point d'accès responsable pour une durée D.

Aujourd'hui, le nombre N est égal à 5 et le laps de temps L a été fixé à 5 minutes. 

### Règle N°2 - Intempestifs isolés

À partir d'un nombre N de déclenchements intempestifs isolés, n'ayant conduit à aucune mise en quarantaine, une mise en quarantaine sera appliquée au point d'accès responsable pour une durée D.

Aujourd'hui, le nombre N est égal à 20.

### Evolution de la durée D

La durée D de la première mise en quarantaine est fixée à 5 minutes. Au delà, la durée D est calculée ainsi:

- station répétitrice: 5 minutes * nombre de mise en quarantaine,
- hotspot:  5 minutes * nombre de mise en quarantaine * 2.

> Un hotspot est plus fortement pénalisé dans la mesure ou il n'a aucune raison de perturber le salon. 

# Administrateurs

Les administrateurs du salon IDF sont Stéphane [F5LGW](https://www.qrz.com/db/F5LGW), Pascal [F4ICR](https://www.qrz.com/db/F4ICR) et Armel [F4HWN](https://www.qrz.com/db/F4HWN). 
