#!/bin/bash 

# TOUCHMINER hakemistot.sh 
# luo tarvittavat hakemistot 
# lista hakemistoista, tiedostoista yms. ja niiden sisällöistä
#
# 2018/3/11
# 1$ lähdetekstitiedosto
# 2$ projektinNimi

#
# GLOBAALIT HAKEMISTOT ${2}/ alla 
#
  # tmp/*                  == globaalit väliaikaiset filut, pois lopuksi
  # data/*                 == data-analyysi, josta plotit  
    # data/frekvenssi      == tärkeiden sanojen frekvenssit / osuus havaituista sanoista 
    # data/frekvenssi2tavu == tärkeiden 2-tavujen frekvenssit / osuus havaituista sanoista 
    # data/frekvenssi3tavu == tärkeiden 3-tavujen frekvenssit / osuus havaituista sanoista 
    # data/jakauma         == kaikkien sanojen jakauma muodossa: x-aks frekvenssi y-aks kuinka monta sanaa vastaa ks. frekvenssiä
    # data/jakauma30       == sanajakauman 30 ensimmäistä entiteettiä ykkösestä alkaen 
    # data/lkm2tavu        == kaikkien 2tavujen lukumäärä 
    # data/lkm3tavu        == kaikkien 3tavujen lukumäärä 
    # data/lkmeri2tavu     == kaikkien erilaisten 2tavujen lukumäärä   
    # data/lkmeri3tavu     == kaikkien erilaisten 3tavujen lukumäärä   
    # data/lkmerisana      == kaikkien erilaisten sanojen lukumäärä   
    # data/lkmsana         == kaikkien sanojen lukumäärä ja kaikkien 2-tavujen lkm   
    # data/lkmmerkki       == kaikkien merkkien lukumäärä   
    # data/lkmmerkki2tavu  == kaikkien merkkien lukumäärä 2tavuille   
    # data/lkmmerkki3tavu  == kaikkien merkkien lukumäärä 3tavuille   
    # data/peittavyys      == tärkeiden sanojen normitetut frekvenssit eli peittävyydet / osuus havaituista sanoista 
    # data/peittavyys2tavu == tärkeiden 2-tavujen normitetut frekvenssit eli peittävyydet / osuus havaituista sanoista 
    # data/peittavyys3tavu == tärkeiden 3-tavujen normitetut frekvenssit eli peittävyydet / osuus havaituista sanoista 
  # plot/*                 == python plotit data-analyysistä 
  # report/*               == tänne generoidaan automaattinen data-analyysin raportti
  # s*/                    == hakemisto, jossa analysoitu sanoja
  # t*/                    == hakemisto, jossa analysoitu kahden kirjaimen tavuja
  # u*/                    == hakemisto, jossa analysoitu kolmen kirjaimen tavuja
  # ../ref/*               == apudataa mm kirjoitusnopeudet mrk/min
  # ../python/*            == python-plottauskoodit päähakemistossa
  # ../test/*              == testataan uusia juttuja ennen sijoittamista varsinaiseen koodiin 
# 

# TODO tarkista että käyttäjä antanut täsmälleen 2 argumenttia, jos ei niin älä suorita ohjelmaa + virheilmoitus
# TODO check if directory exists then rm -r directory and echo "luodaan uusi hakemisto [hakemiston nimi]"
# TODO kysy jos olemassa niin overwrite directory k/e

rm -r ${2}/

# yleiset hakemistot 
eval "mkdir -p ${2}/tmp/  ${2}/data/ ${2}/plot/  ${2}/report/" 

# sanojen analyysi
eval "mkdir -p ${2}/s10/  ${2}/s20/   ${2}/s30/   ${2}/s40/   ${2}/s50/    ${2}/s100/   ${2}/s200/"
eval "mkdir -p ${2}/s300/ ${2}/s400/  ${2}/s500/  ${2}/s750/  ${2}/s1000/  ${2}/s1500   ${2}/s2000/" 
eval "mkdir -p ${2}/s2500 ${2}/s3000/ ${2}/s4000/ ${2}/s5000/ ${2}/s10000/ ${2}/s50000/ ${2}/s100000/"

# tavut 2 kirjainta
eval "mkdir -p ${2}/t10/  ${2}/t20/  ${2}/t30/  ${2}/t40/  ${2}/t50/  ${2}/t75/ ${2}/t100/ ${2}/t150/" 
eval "mkdir -p ${2}/t200/ ${2}/t300/ ${2}/t400/ ${2}/t500/ ${2}/t750/ ${2}/t1000/" 

# tavut 3 kirjainta
eval "mkdir -p ${2}/u10/   ${2}/u20/   ${2}/u30/   ${2}/u40/   ${2}/u50/   ${2}/u100/"
eval "mkdir -p ${2}/u200/  ${2}/u300/  ${2}/u400/  ${2}/u500/  ${2}/u750/  ${2}/u1000/" 
eval "mkdir -p ${2}/u1500/ ${2}/u2000/ ${2}/u2500/ ${2}/u3000/ ${2}/u4000/ ${2}/u5000/" 
eval "mkdir -p ${2}/u10000/" 
