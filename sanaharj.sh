#!/bin/bash 

# TOUCHMINER sanaharj.sh
# sanaharjoitukset + sanadata
#
# 2018/3/11
# $1 projektinimi

for i in s10 s20 s30 s40 s50 s100 s200 s300 s400 s500 s750 s1000 s1500 s2000 s2500 s3000 s4000 s5000 s10000 s50000
do 

  # poistetaan kirjain s (itse asiassa kaikki kirjaimet hakemiston nimestä)
  # kirjoitetaan hakemistoon "$i"/lkmtarkeet
  echo "$i" | sed 's/[a-z]//' > ${1}/"$i"/lkmtarkeet

  # tallennetaan muuttujaan VAR tärkeiden sanojen lukumäärä eli kansion nimi ilman s-kirjainta
  VAR=$( cat ${1}/"$i"/lkmtarkeet | awk '{print $1}') 

  # tärkeimmät erilaiset sanat ja vastaavat frekvenssit tiedostoon 
  # tmp/tmp2 sis kaikki erilaiset sanat joissa lkm edessä
  # järjestetään numeerisesti ja käänteiseen järjestykseen
  # kirjoitetaan frekvenssi ja sana tiedostoon "tarkeetfq"
  cat ${1}/tmp/tmp2 | sort -nr | head -n $VAR > ${1}/"$i"/tarkeetfq

  # poistetaan frekvenssiluku sanojen edestä 
  # kirjoitetaan tärkeimmät erilaiset sanat tiedostoon "tarkeet"
  sed 's/\(.*\) \(.*\)/\2/g' ${1}/"$i"/tarkeetfq > ${1}/"$i"/tarkeet 

  # otetaan korkeintaan 8:n numeron kentästä kaikki frekvenssit talteen
  # kirjoitetaan frekvenssit tiedostoon "frekvenssit" 
  egrep -o '[0-9]{1,8}' ${1}/"$i"/tarkeetfq > ${1}/"$i"/frekvenssit 

  # summataan sanafrekvenssit rivi riviltä 
  # kirjoitetaan kokonaisfrekvenssi tiedostoon "frekvenssi"
  awk '{s+=$1} END {print s}' ${1}/"$i"/frekvenssit > ${1}/"$i"/frekvenssi 

  # lasketaan lokaali sanapeittävyys 
  # tiedosto "../data/lkmsana" sisältää kaikki esimerkkitiedoston sanat
  # TODO selitä tarkemmin mitä sed ja awk tekevät
  cp ${1}/"$i"/frekvenssi ${1}/"$i"/tmpfrekvenssi  
  cat ${1}/data/lkmsana >> ${1}/"$i"/tmpfrekvenssi 
  tr "\n" " " < ${1}/"$i"/tmpfrekvenssi | sed 's/[ \t]*$//' > ${1}/"$i"/tmppeitto
  awk '{printf "%4f", ($1 + 0) / ($2 + 0) }' ${1}/"$i"/tmppeitto > ${1}/"$i"/peittavyys 

  # sanaharjoitukset aakkosellisiin tiedostoihin + pilkut & linebrake->whitespace 
  mkdir ${1}/$i/harj/
  for j in {a..z} å ä ö 
  do
    # järjestetään aakkoselliseen järjestykseen  
    grep -i "^$j" ${1}/"$i"/tarkeet | sort > ${1}/"$i"/tmp$j 
    # harjoitukset omaa alihakemistoon 
    sed 's/$/,/' ${1}/$i/tmp$j | tr "\n" " " | sed 's/[ \t]*$//' | sed '$s/,$//' > ${1}/$i/harj/$j.txt 
    # kirjainkohtaiset merkkimäärät: mukana tyhjätilat ja pilkut 
    echo "$j" > ${1}/"$i"/tmp"$j"char
    cp ${1}/"$i"/harj/$j.txt ${1}/tmp/tmpchars
    # multibyte huomioitu wc -m optiolla ja 
    # TODO sed jälkeen vähennetään rivin lopusta whitespace jos rivillä kirjaimia awk '{print $1-1}' 
    wc -m ${1}/tmp/tmpchars | sed "s|${1}/tmp/tmpchars||g" >> ${1}/"$i"/tmp"$j"char
    tr "\n" " " <  ${1}/"$i"/tmp"$j"char | sed 's/[ \t]*$//' | tr -s " " >> ${1}/"$i"/kirjainmerkit 
  done 

  # sanojen kokonaismerkkimäärä sis. pilkut ja välilyönnit tiedostoon
  egrep -o '[0-9]{1,9}' ${1}/"$i"/kirjainmerkit >> ${1}/"$i"/tmpmerkit
  awk '{s+=$1} END {print s}' ${1}/"$i"/tmpmerkit > ${1}/"$i"/merkkimaara
  #cat ${1}/"$i"/merkkimaara

  # sanaharjoitusten lokaali aika-arvio 
  # aika = merkkimaara/nopeus (min) ilman taukoja
  for k in n80 n100 n120 n150 n200 n250 n300 n400 
  do 
    cp ${1}/"$i"/merkkimaara ${1}/"$i"/tmpmerkkimaara
    cat ref/"$k" >> ${1}/"$i"/tmpmerkkimaara
    tr "\n" " " < ${1}/"$i"/tmpmerkkimaara | sed 's/[ \t]*$//' > ${1}/"$i"/tmpaikalasku
    #cat ${1}/"$i"/tmpaikalasku
    awk '{ printf "%4f", ($1 + 0) / ($2 + 0) }' ${1}/"$i"/tmpaikalasku > ${1}/"$i"/aika$k
    # kerätään yhteen filuun "nopeusjaaika" kahteen sarakkeeseen nopeus aika 
    cat ref/"$k" > ${1}/"$i"/tmpajat
    cat ${1}/"$i"/aika$k >> ${1}/"$i"/tmpajat
    tr "\n" " " < ${1}/"$i"/tmpajat | sed 's/[ \t]*$//' >> ${1}/"$i"/ajat
  done 

  #sort -n ${1}/"$i"/nopeusjaaika -o ${1}/"$i"/nopeusjaaika

  # poistetaan väliaikaiset tiedostot 
  rm -r ${1}/"$i"/tmp* 

done 
