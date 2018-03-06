#!/bin/bash 

# TOUCHMINER tavu2harj.sh
# 2-tavu harjoitukset + tavudata 
#
# 2015/1/25
# 1$ projektinimi

for i in t10 t20 t30 t40 t50 t75 t100 t150 t200 t300 t400 t500 t750 t1000
do 

  # poistetaan kirjain t 2-tavujen hakemiston nimestä (poistaa minkä tahansa yhden kirjaimen)
  echo "$i" | sed 's/[a-z]//' > ${1}/"$i"/lkmtarkeet

  # tärkeimmät erilaiset 2-tavut ja vastaavat frekvenssit tiedostoon 
  VARM=$( cat ${1}/"$i"/lkmtarkeet | awk '{print $1}') 
  cat ${1}/tmp/tmp2eritavu | sort -nr | head -n $VARM > ${1}/"$i"/tarkeetfq

  # tärkeimmät erilaiset 2-tavut tiedostoon
  sed 's/\(.*\) \(.*\)/\2/g' ${1}/"$i"/tarkeetfq > ${1}/"$i"/tarkeet

  # kirjoitetaan tärkeiden 2-tavujen frekvenssit tiedostoon 
  egrep -o '[0-9]{1,9}' ${1}/"$i"/tarkeetfq > ${1}/"$i"/frekvenssit

  # summataan 2-tavujen frekvenssit tiedostoon
  awk '{s+=$1} END {print s}' ${1}/"$i"/frekvenssit > ${1}/"$i"/frekvenssi

  # lasketaan lokaali 2-tavujen peittävyys 
  cp ${1}/"$i"/frekvenssi ${1}/"$i"/tmpfrekvenssi
  # TODO 3-tavut lkmsana ei ole sama 3-tavuje lkm sillä 2-tavut poistettu ota eri filusta
  cat ${1}/data/lkm2tavu >> ${1}/"$i"/tmpfrekvenssi
  tr "\n" " " < ${1}/"$i"/tmpfrekvenssi | sed 's/[ \t]*$//' > ${1}/"$i"/tmppeitto
  awk '{printf "%4f", ($1 + 0) / ($2 + 0) }' ${1}/"$i"/tmppeitto > ${1}/"$i"/peittavyys

  # 2-tavu harjoitukset aakkosellisiin tiedostoihin + pilkut & linebrake->whitespace 
  mkdir ${1}/$i/harj/
  for j in {a..z} å ä ö 
  do
    # järjestetään aakkoselliseen järjestykseen  
    grep -i "^$j" ${1}/"$i"/tarkeet | sort > ${1}/"$i"/tmp"$j"
    # tulostetaan jokainen rivi 3 kertaa filuun ja harjoitukset omaan alihakemistoon
    awk '{for(i=0;i<3;i++)print}' ${1}/"$i"/tmp"$j" | tr "\n" " " | sed 's/[ \t]*$//' > ${1}/$i/harj/$j.txt 
    # kirjainkohtaiset 2-tavujen merkkimäärät: mukana tyhjätilat ja pilkut 
    echo "$j" > ${1}/"$i"/tmp"$j"char
    cp ${1}/"$i"/harj/$j.txt ${1}/tmp/tmpchars
    # multibyte huomioitu wc -m optiolla ja TODO vähennetään whitespace rivin lopusta jos rivillä kirjaimia awk '{print $1-1}' 
    wc -m ${1}/tmp/tmpchars | sed "s|${1}/tmp/tmpchars||g" >> ${1}/"$i"/tmp"$j"char
    tr "\n" " " <  ${1}/"$i"/tmp"$j"char | sed 's/[ \t]*$//' | tr -s " " >> ${1}/"$i"/kirjainmerkit
  done 

  # 2-tavu kokonaismerkkimäärä sis. pilkut ja välilyönnit tiedostoon, tässä sanat kolmeen kertaan
  egrep -o '[0-9]{1,9}' ${1}/"$i"/kirjainmerkit >> ${1}/"$i"/tmpmerkit
  awk '{s+=$1} END {print s}' ${1}/"$i"/tmpmerkit > ${1}/"$i"/merkkimaara

  # 2-tavu harjoitusten lokaali aika-arvio 
  # aika = merkkimaara/nopeus (min) ilman taukoja
  for k in n80 n100 n120 n150 n200 n250 n300 n400 
  do 
    cp ${1}/"$i"/merkkimaara ${1}/"$i"/tmpmerkkimaara
    cat ref/"$k" >> ${1}/"$i"/tmpmerkkimaara
    tr "\n" " " < ${1}/"$i"/tmpmerkkimaara | sed 's/[ \t]*$//' > ${1}/"$i"/tmpaikalasku
    awk '{ printf "%4f", ($1 + 0) / ($2 + 0) }' ${1}/"$i"/tmpaikalasku > ${1}/"$i"/aika"$k"
    # kerätään yhteen filuun "nopeusjaaika" kahteen sarakkeeseen nopeus aika 
    cat ref/"$k" > ${1}/"$i"/tmpajat
    cat ${1}/"$i"/aika"$k" >> ${1}/"$i"/tmpajat
    tr "\n" " " < ${1}/"$i"/tmpajat | sed 's/[ \t]*$//' >> ${1}/"$i"/ajat
  done 


  # poistetaan väliaikaiset tiedostot 
  rm -r ${1}/"$i"/tmp* 

done 
