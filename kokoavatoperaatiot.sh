#!/bin/bash 

# TOUCHMINER kokoavatoperaatiot.sh
# kootaan data lokaaleista filuista 
#
# 2015/1/3
# 1$ projektinNimi


# sanajakauma abs 
sed 's/\(.*\) \(.*\)/\1/g' ${1}/tmp/tmp2 | tr -d ' ' | sort -n | uniq -c | sed 's/\(.*\) \(.*\)/\2 \1/g' | tr -s " " > ${1}/data/jakauma
# 30 ensimmäistä riviä plottia varten riittää demonstroimaan
head -n 30 ${1}/data/jakauma > ${1}/data/jakauma30

# TODO 2-tavujakauma abs
# TODO 3-tavujakauma abs

#TODO globaali normitettu jakauma (python suoraan?)
# jos ei onnistuu em. tavalla niin sitten awk:lla jokainen rivi tulos jaettuna data/lkmsana 


# TODO 2-tavujakauma normitettu 
# TODO 3-tavujakauma normitettu

# TODO GLOBAALI AIKA-ARVIO kaikille HARJOITUKSILLE 
# kokoa lokaaleista aika-arvioista, yhdistä tavut ja sanat  

# globaali sanafrekvenssi eli sanapeittävyys abs 
for i in s10 s20 s30 s40 s50 s100 s200 s300 s400 s500 s750 s1000 s1500 s2000 s2500 s3000 s4000 s5000 s10000 s50000
do 
  cat ${1}/"$i"/lkmtarkeet >> ${1}/tmp/tmpfrekvenssi
  cat ${1}/"$i"/frekvenssi >> ${1}/tmp/tmpfrekvenssi
  tr "\n" " " < ${1}/tmp/tmpfrekvenssi | sed 's/[ \t]*$//' | tr -s " " >> ${1}/data/frekvenssi
  cat /dev/null > ${1}/tmp/tmpfrekvenssi
done 
# globaali normitettu sanafrekvenssi eli sanapeittävyys
for i in s10 s20 s30 s40 s50 s100 s200 s300 s400 s500 s750 s1000 s1500 s2000 s2500 s3000 s4000 s5000 s10000 s50000
do 
  cat ${1}/"$i"/lkmtarkeet >> ${1}/tmp/tmppeittavyys
  cat ${1}/"$i"/peittavyys >> ${1}/tmp/tmppeittavyys
  tr "\n" " " < ${1}/tmp/tmppeittavyys | sed 's/[ \t]*$//' | tr -s " " >> ${1}/data/peittavyys
  cat /dev/null > ${1}/tmp/tmppeittavyys
done 

# globaali 2-tavufrekvenssi eli 2-tavupeittävyys abs 
# tmpfrekvenssi käy sillä /dev/null aiemmin
for i in t10 t20 t30 t40 t50 t75 t100 t150 t200 t300 t400 t500 t750 t1000
do 
  cat ${1}/"$i"/lkmtarkeet >> ${1}/tmp/tmpfrekvenssi
  cat ${1}/"$i"/frekvenssi >> ${1}/tmp/tmpfrekvenssi
  tr "\n" " " < ${1}/tmp/tmpfrekvenssi | sed 's/[ \t]*$//' | tr -s " " >> ${1}/data/frekvenssi2tavu
  cat /dev/null > ${1}/tmp/tmpfrekvenssi
done 
# globaali normitettu 2-tavufrekvenssi eli 2-tavupeittävyys
# tmppeittavyys käy sillä /dev/null aiemmin
for i in t10 t20 t30 t40 t50 t75 t100 t150 t200 t300 t400 t500 t750 t1000
do 
  cat ${1}/"$i"/lkmtarkeet >> ${1}/tmp/tmppeittavyys
  cat ${1}/"$i"/peittavyys >> ${1}/tmp/tmppeittavyys
  tr "\n" " " < ${1}/tmp/tmppeittavyys | sed 's/[ \t]*$//' | tr -s " " >> ${1}/data/peittavyys2tavu
  cat /dev/null > ${1}/tmp/tmppeittavyys
done 

# globaali 3tavufrekvenssi eli 2-tavupeittävyys abs 
# tmpfrekvenssi käy sillä /dev/null aiemmin
for i in u10 u20 u30 u40 u50 u100 u200 u300 u400 u500 u750 u1000 u1500 u2000 u2500 u3000 u4000 u5000 u10000
do 
  cat ${1}/"$i"/lkmtarkeet >> ${1}/tmp/tmpfrekvenssi
  cat ${1}/"$i"/frekvenssi >> ${1}/tmp/tmpfrekvenssi
  tr "\n" " " < ${1}/tmp/tmpfrekvenssi | sed 's/[ \t]*$//' | tr -s " " >> ${1}/data/frekvenssi3tavu
  cat /dev/null > ${1}/tmp/tmpfrekvenssi
done 
# globaali normitettu 3tavufrekvenssi eli 2-tavupeittävyys
# tmppeittavyys käy sillä /dev/null aiemmin
for i in u10 u20 u30 u40 u50 u100 u200 u300 u400 u500 u750 u1000 u1500 u2000 u2500 u3000 u4000 u5000 u10000
do 
  cat ${1}/"$i"/lkmtarkeet >> ${1}/tmp/tmppeittavyys
  cat ${1}/"$i"/peittavyys >> ${1}/tmp/tmppeittavyys
  tr "\n" " " < ${1}/tmp/tmppeittavyys | sed 's/[ \t]*$//' | tr -s " " >> ${1}/data/peittavyys3tavu
  cat /dev/null > ${1}/tmp/tmppeittavyys
done 

# TODO GLOBAALI PLOTTAUS
  # tuloksista edellä automatisoiduilla erillisillä python-skripteillä

# TODO GLOBAALI LOGI / raportin generointi 
# generoi tex-filuun jonne tulevat myös kuvat, voi hienosäätää kuvia yms. 
# myöhemmin mutta automaattinen raportti joka tapauksessa
#
#touch data/log
#
## sanoja yhteensä 
#echo -e "\nSanoja yhteensä: " >> data/log
#cp data/lkmsana tmp/tmpsanat
#wc -l tmp/tmpsanat | sed 's/tmp\/tmpsanat//' | tr -d ' ' >> data/log 
#
## merkkejä yhteensä 
#echo -e "\nMerkkejä yhteensä: " >> data/log
#cp data/lkmmerkki tmp/tmpmerkki
#wc -l tmp/tmpmerkki | sed 's/tmp\/tmpmerkki//' | tr -d ' ' >> data/log 
#
## harjoiteltavat erilaiset sanat 
#echo -e "\nErilaisia sanoja yhteensä: " >> data/log
#cp data/lkmerisana tmp/tmperisanat
#wc -l tmp/tmperisanat | sed 's/tmp\/tmperisanat//' | tr -d ' ' >> data/log 
