#!/bin/bash 

#
#
# TOUCHMINER
#
# Sovellus luo optimaaliset kymmensormitekniikan harjoitukset perustuen
# sille parametreina annettuun tekstitiedostoon $1. Harjoitukset ja niihin
# liittyvä muu data kirjoitetaan hakemistoon $2.
#
# 1$ lähdetekstitiedosto
# 2$ projektinNimi (hakemisto)
#
# @author Riku E. Järvinen
# 2015-2018
#
#

# luodaan projektin hakemistot komentoriviargumenteista
./hakemistot.sh $1 $2 

# lasketaan sanat & merkit ja erilaiset sanat + luodaan tmp1/tmp2-filut 
./sanatjamerkit.sh $1 $2 

# sanaharjoitukset + sanadata
./sanaharj.sh $2

# tavu 2-harjoitukset + tavu2-data
./tavu2harj.sh $2 

# tavu 3-harjoitukset + tavu3-data
./tavu3harj.sh $2 

# kokoavat dataoperaatiot mm. jakauma, frekvenssi, aika-arvio yms.  
# kokoavat tavuoperaatiot 
./kokoavatoperaatiot.sh $2

# TODO plottaus 
#./plottaus.sh

# TODO raportti 
#./raportti.sh 

# poistetaan väliaikaiset tiedostot
# HUOM ohjelman toimivuutta voidaan testata kommentoimalla allaoleva rivi
 rm -r ${2}/tmp/

#
# kehitys
# 

# TODO sana+sana eli lyhyet ilmaukset 
# TODO rytmiikka-analyysi ja siihen liittyvät jutut 
# TODO tavut sanojen lopusta ja harjoittelu lyhyillä sanoilla
# TODO edellisen yhdistäminen tavuharjoituksiin? 
# TODO kirjainten esittely vähän kerrallaan ja harjoitusten rakentaminen sitä kautta? 
