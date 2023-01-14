#!/bin/bash

# Fichier restart.idf

echo 'Etape 1 - Installation du fichier restart.idf'
wget https://github.com/armel/IDF/blob/main/restart.idf -O /etc/spotnik/restart.idf

# Fichier Sidf.wav

echo 'Etape 2 - Installation du fichier Sidf.wav'
wget https://github.com/armel/IDF/blob/main/Sidf.wav -O /usr/share/svxlink/sounds/fr_FR/RRF/Sidf.wav

# Mise à jour Logic.tcl

echo 'Etape 3 - Mise à jour du fichier Logic.tcl'
sed -i -e "s/restart.reg/restart.idf/g" /usr/share/svxlink/events.d/local/Logic.tcl

# Mise à jour Raptor

echo 'Etape 4 - Mise à jour du Raptor'

cd /opt/RRFRaptor
git reset --hard
git pull
git checkout feature_idf

# Fin

echo 'Bienvenue sur le salon IDF'
/etc/spotnik/restart.idf