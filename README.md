# Présentation du salon IDF

## Historique

À partir de fin 2021, le salon EXPERIMENTAL du RRF était régulièrement occupé par une poignée d'OMs. Le besoin de disposer d'un salon privé, afin de pouvoir expérimenter et tester des choses, sans risquer de perturber l'ensemble du réseau RRF, s'est fait ressentir.

En avril 2022, en complément du `(75) F1ZPX U` et `(75) F1ZPX V` (Paris 15), ce salon privé s'est quelque peu ouvert. Dans un premier temps, Stéphane F5LGW, Sysop du `(94) F5ZSO V` (Charenton) et Pascal F4ICR, Sysop du `(94) F1ZUJ U` (Créteil) l'ont rejoints.

Au cours de l'été 2022, l'ANFR a commencé à communiquer autour des JO 2024. Une bonne partie de la communauté RA s'est rapidement inquiétée, craignant d'être expulsée de *ses* bandes, sans concertation. On peut dramatiser, mais on peut aussi suivre une autre approche et tenter d'être acteur d'un tel évenement. 

L'idée de créer un salon IDF (Ile de France), permettant de *fédérer* les points d'accès de la région et capable de créer une *bulle* la plus dense possible, s'est donc précisée un peu plus.

En décembre 2022, ce fût au tour d'Olivier F1GWX, Sysop du `(92) F1ZQC V`, de rejoindre le salon IDF.

## Ouverture du salon IDF

Le salon IDF s'inscrit totalement dans la philosophie du RRF. En particulier, il privéligie la radio et impose aux points d'accès d'être 100% radio. Il n'est pas ouvert aux interconnexions. Si vous souhaitez rejoindre le salon IDF, sachez qu'il est ouvert à tous les points d'accès: 

- disposant d'un indicatif de station répétitrice (*indicatif en Z*), 
- disposant d'un CTCSS ou d'un DCS **actifs**,
- présents dans les 8 départements de la région Ile de France (75, 77, 78, 91, 92, 93, 94 et 95).

> Si vous êtes Sysop d'un point d'accès proche de la région Ile de France, sans pour autant en faire partie, des exceptions sont possibles et seront étudiées avec bienséance. 

Enfin, le salon IDF est également ouvert aux points d'accès QRP de type hotspot (H ou B), sur simple demande.


## Caractéristiques du salon IDF

Le salon IDF est probablement le salon **s'inscrivant le plus dans l'ADN du RRF**. En particulier, le salon IDF dispose, en totale autonomie vis à vis du RRF:

- de son propre **Tracker** (*RRF + IDF*),
- de son propre **Analyzer** (*RRF + IDF*),
- de sa propre **Sentinel**,
- de son propre **BlockIP**.

Concéquence immédiate, le salon IDF est également **Raptorisable**, à l'image des autres salons *actifs* du RRF (RRF, FON, TEC, INT, BAV, LOC et EXP).

# Rejoindre le salon IDF

## Methode 1 - Pas à pas

### Etape 1 - Fichier `restart.idf`

Depuis une simple connexion SSH sur votre Spotnik, téléchargez et copiez le fichier `restart.idf` via la commande:

`wget https://github.com/armel/IDF/blob/main/restart.idf -O /etc/spotnik/restart.idf`

Eventuellement, pensez à le rendre exécutable via la commande:

`chmod +x /etc/spotnik/restart.idf`

### Etape 2 - Fichier `Sidf.wav`

Depuis une simple connexion SSH sur votre Spotnik, téléchargez et copiez le fichier `Sidf.wav` via la commande:

`wget https://github.com/armel/IDF/blob/main/Sidf.wav -O /usr/share/svxlink/sounds/fr_FR/RRF/Sidf.wav`

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

Si vous utilisez le Raptor et que vous souhaitez l'utiliser avec le salon IDF, entrez les commandes suivantes :

```
cd /opt/RRFRaptor
git reset --hard
git pull
git checkout feature_idf
```

Vous pouvez alors modifier éventuellement les paramétrages par défaut en éditant le fichier `settings.py`. Consultez la documentation du Raptor si besoin (fichier `README.md`).

## Methode 2 - Automatique

Depuis une simple connexion SSH sur votre Spotnik, entrez la commande:

`/bin/bash -c "$(wget https://github.com/armel/IDF/blob/main/idf.sh)"`


# Administrateurs

Les administrateurs du salon IDF sont Stéphane F5LGW, Pascal F4ICR et Armel F4HWN. 
