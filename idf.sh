#!/bin/bash

# Fichier restart.idf

echo 'Etape 1 - Installation du fichier restart.idf'
wget -qO- https://raw.githubusercontent.com/armel/IDF/main/restart.idf -O /etc/spotnik/restart.idf &> /dev/null
chmod +x /etc/spotnik/restart.idf

# Fichier Sidf.wav

echo 'Etape 2 - Installation du fichier Sidf.wav'
wget -qO- https://raw.githubusercontent.com/armel/IDF/main/Sidf.wav -O /usr/share/svxlink/sounds/fr_FR/RRF/Sidf.wav &> /dev/null

# Mise à jour Logic.tcl

echo 'Etape 3 - Mise à jour du fichier Logic.tcl'
sed -i -e "s/restart.reg/restart.idf/g" /usr/share/svxlink/events.d/local/Logic.tcl

# Mise à jour Raptor

echo 'Etape 4 - Mise à jour du Raptor'

cd /opt/RRFRaptor
git reset --hard --quiet
git pull --quiet
git checkout feature_idf --quiet

# Fin

echo 'Bienvenue sur le salon IDF !'
echo 'Vous pouvez désormais y acceder depuis la commande DTMF #104.'
echo 'Bon trafic'

/etc/spotnik/restart.idf