#!/bin/bash 

# TOUCHMINER touchminer.sh
# käynnistää ohjelman toiminnot  
#
# v. 0.62 2015/1/3
# 1$ lähdetekstitiedosto
# 2$ projektinNimi



# luodaan projektin hakemistot
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
rm -r ${2}/tmp/

#
# FUTURE kehitys
# 

# TODO sana+sana eli lyhyet ilmaukset (future) 

# TODO rytmiikka-analyysi ja siihen liittyvät jutut (future) 

# TODO tavut sanojen lopusta ja harjoittelu lyhyillä sanoilla (future) 
# TODO edellisen yhdistäminen tavuharjoituksiin? 

# TODO kirjainten esittely vähän kerrallaan ja harjoitusten rakentaminen sitä kautta? (future)
