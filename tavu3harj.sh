#!/bin/bash 

# TOUCHMINER tavu3harj.sh
# 3-tavu harjoitukset + tavudata 
#
# 2015/1/25
# 1$ projektinimi

for i in u10 u20 u30 u40 u50 u100 u200 u300 u400 u500 u750 u1000 u1500 u2000 u2500 u3000 u4000 u5000 u10000
do 

  # poistetaan kirjain u 3-tavujen hakemiston nimestä (poistaa minkä tahansa yhden kirjaimen)
  echo "$i" | sed 's/[a-z]//' > ${1}/"$i"/lkmtarkeet

  # tärkeimmät erilaiset 3-tavut ja vastaavat frekvenssit tiedostoon 
  VARE=$( cat ${1}/"$i"/lkmtarkeet | awk '{print $1}') 
  cat ${1}/tmp/tmp3eritavu | sort -nr | head -n $VARE > ${1}/"$i"/tarkeetfq

  # tärkeimmät erilaiset u-tavut tiedostoon
  sed 's/\(.*\) \(.*\)/\2/g' ${1}/"$i"/tarkeetfq > ${1}/"$i"/tarkeet

  # kirjoitetaan tärkeiden 3-tavujen frekvenssit tiedostoon 
  egrep -o '[0-9]{1,9}' ${1}/"$i"/tarkeetfq > ${1}/"$i"/frekvenssit

  # summataan 3-tavujen frekvenssit tiedostoon
  awk '{s+=$1} END {print s}' ${1}/"$i"/frekvenssit > ${1}/"$i"/frekvenssi

  # lasketaan lokaali 3-tavujen peittävyys 
  cp ${1}/"$i"/frekvenssi ${1}/"$i"/tmpfrekvenssi
  # TODO 3-tavut lkmsana ei ole sama 3-tavuje lkm sillä 2-tavut poistettu ota eri filusta
  cat ${1}/data/lkm3tavu >> ${1}/"$i"/tmpfrekvenssi
  tr "\n" " " < ${1}/"$i"/tmpfrekvenssi | sed 's/[ \t]*$//' > ${1}/"$i"/tmppeitto
  awk '{printf "%4f", ($1 + 0) / ($2 + 0) }' ${1}/"$i"/tmppeitto > ${1}/"$i"/peittavyys

  # 3-tavu harjoitukset aakkosellisiin tiedostoihin + linebrake->whitespace 
  mkdir ${1}/$i/harj/
  for j in {a..z} å ä ö 
  do
    # järjestetään aakkoselliseen järjestykseen  
    grep -i "^$j" ${1}/"$i"/tarkeet | sort > ${1}/"$i"/tmp"$j"
    # tulostetaan jokainen rivi 3 kertaa filuun ja harjoitukset omaan alihakemistoon
    awk '{for(i=0;i<3;i++)print}' ${1}/"$i"/tmp"$j" | tr "\n" " " | sed 's/[ \t]*$//' > ${1}/$i/harj/$j.txt 
    # kirjainkohtaiset 3-tavujen merkkimäärät: mukana tyhjätilat ja pilkut 
    echo "$j" > ${1}/"$i"/tmp"$j"char
    cp ${1}/"$i"/harj/$j.txt ${1}/tmp/tmpchars
    # multibyte huomioitu wc -m optiolla ja TODO vähennetään whitespace rivin lopusta jos rivillä kirjaimia awk '{print $1-1}' 
    wc -m ${1}/tmp/tmpchars | sed "s|${1}/tmp/tmpchars||g" >> ${1}/"$i"/tmp"$j"char
    tr "\n" " " <  ${1}/"$i"/tmp"$j"char | sed 's/[ \t]*$//' | tr -s " " >> ${1}/"$i"/kirjainmerkit
  done 

  # 3-tavu kokonaismerkkimäärä sis. pilkut ja välilyönnit tiedostoon, tässä sanat kolmeen kertaan
  egrep -o '[0-9]{1,9}' ${1}/"$i"/kirjainmerkit >> ${1}/"$i"/tmpmerkit
  awk '{s+=$1} END {print s}' ${1}/"$i"/tmpmerkit > ${1}/"$i"/merkkimaara

  # 3-tavu harjoitusten lokaali aika-arvio 
  # aika = merkkimaara/nopeus (min) ilman taukoja
  for k in n80 n100 n120 n150 n200 n250 n300 n400 
  do 
    cp ${1}/"$i"/merkkimaara ${1}/"$i"/tmpmerkkimaara
    cat ref/"$k" >> ${1}/"$i"/tmpmerkkimaara
    tr "\n" " " < ${1}/"$i"/tmpmerkkimaara | sed 's/[ \t]*$//' > ${1}/"$i"/tmpaikalasku
    awk '{ printf "%4f", ($1 + 0) / ($2 + 0) }' ${1}/"$i"/tmpaikalasku > ${1}/"$i"/aika"$k"
    # kerätään yhteen filuun "ajat" kahteen sarakkeeseen nopeus aika 
    cat ref/"$k" > ${1}/"$i"/tmpajat
    cat ${1}/"$i"/aika"$k" >> ${1}/"$i"/tmpajat
    tr "\n" " " < ${1}/"$i"/tmpajat | sed 's/[ \t]*$//' >> ${1}/"$i"/ajat
  done 


  # poistetaan väliaikaiset tiedostot 
  rm -r ${1}/"$i"/tmp* 

done 
