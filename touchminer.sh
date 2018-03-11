#!/bin/bash 

#
# TOUCHMINER touchminer.sh
# @author Riku E. Järvinen
# käynnistää ohjelman toiminnot  
# v. 0.62 2018/3/11
#


# luodaan projektin hakemistot komentoriviargumenteista
# 1$ lähdetekstitiedosto
# 2$ projektinNimi
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
#rm -r ${2}/tmp/

#
# kehitys
# 

# TODO sana+sana eli lyhyet ilmaukset 
# TODO rytmiikka-analyysi ja siihen liittyvät jutut 
# TODO tavut sanojen lopusta ja harjoittelu lyhyillä sanoilla
# TODO edellisen yhdistäminen tavuharjoituksiin? 
# TODO kirjainten esittely vähän kerrallaan ja harjoitusten rakentaminen sitä kautta? 
