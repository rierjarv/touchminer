#!/bin/bash 

# TOUCHMINER sanatjamerkit.sh
# sanat, erilaiset sanat ja merkit + tmp1/tmp2-filut 
#
# 2015/1/25
# 1$ lähdetekstitiedosto
# 2$ projektinNimi

# tmp/tmp1 sis. kaikki sanat ja poistaa 1 merkkiä pitkät sanat 
tr -cs "[:alpha:]" "\n"  < $1  | tr '[:upper:]' '[:lower:]' | sort | awk 'length>1' | tr -d ' '  > ${2}/tmp/tmp1


#
# SANAT 
#
# tmp/tmp2 sis. kaikki erilaiset sanat ja numero edessä
uniq -c ${2}/tmp/tmp1 > ${2}/tmp/tmp2 
# kaikkien sanojen lkm
wc -l ${2}/tmp/tmp1 | sed "s|${2}/tmp/tmp1||g" | tr -d ' ' > ${2}/data/lkmsana
# rivien lukumäärä muuttujaan
VARI=$( cat ${2}/data/lkmsana | awk '{print $1}' )
# merkkien lkm, huomioitu multibyte sekä vähennetty newlinet 
wc -m ${2}/tmp/tmp1 | sed "s|${2}/tmp/tmp1||g" | awk '{print $1-var}' var="$VARI" | tr -d ' ' > ${2}/data/lkmmerkki
# erilaiset sanat
wc -l ${2}/tmp/tmp2 | sed "s|${2}/tmp/tmp2||g" | tr -d ' ' > ${2}/data/lkmerisana


#
# TAVUT 2 kirjainta sanojen alusta ja lopusta 
# (lopusta vain niistä sanoista, joissa on väh 4 kirjainta) 
#
# otetaan ${2}/tmp/tmp1 kaksi ensimmäistä kirjainta ja kirjoitetaan ${2}/tmp/tmp2tavu
cut -c 1-2 ${2}/tmp/tmp1 > ${2}/tmp/tmp2tavu
cp ${2}/tmp/tmp1 ${2}/tmp/tmp4 
# otetaan sanat joissa vähintään 4 kirjainta ja näiden rivimäärä 
# TODO jostain syystä ei poista kaikkia kolmen kirjaimen juttuja...?
cat ${2}/tmp/tmp4 | awk 'length>3' > ${2}/tmp/tmpvahnelja
wc -l ${2}/tmp/tmpvahnelja | sed "s|${2}/tmp/tmpvahnelja||g" | tr -d ' ' > ${2}/tmp/tmpvahneljarivit
# muuttuja, johon tulee vähintään neljämerkkisten sanojen rivien lukumäärä
VART=$( cat ${2}/tmp/tmpvahneljarivit | awk '{print $1}')
# otetaan kaksi viimeistä kirjainta edellisestä ja lisätään tiedoston loppuun 
sed 's/^.*\(..\)$/\1/' ${2}/tmp/tmpvahnelja >> ${2}/tmp/tmp2tavu
# aakkosjärjestys ja uniq 2 ekaa kirjainta ja kirjoitetaan tiedostoon 
sort ${2}/tmp/tmp2tavu | uniq -c > ${2}/tmp/tmp2eritavu 
# kaikkien 2tavujen lkm
awk '{print $1+var}' var="$VART" ${2}/data/lkmsana | tr -d ' ' > ${2}/data/lkm2tavu
# erilaisten 2tavujen lkm
wc -l ${2}/tmp/tmp2eritavu | sed "s|${2}/tmp/tmp2eritavu||g" | tr -d ' ' > ${2}/data/lkmeri2tavu
# kaikkien 2tavujen merkkimäärä
awk '{print 2*$1}' ${2}/data/lkmsana | awk '{print $1+2*var}' var="$VART" | tr -d ' ' > ${2}/data/lkmmerkki2tavu


#
# TAVUT 3 kirjainta
#
# poistetaan 2 tai vähemmän kirjaimia sis sanat 
cat ${2}/tmp/tmp1 | awk 'length>2' > ${2}/tmp/tmp3
# otetaan ${2}/tmp/tmp1 kolme ensimmäistä kirjainta ja kirjoitetaan ${2}/tmp/tmp3tavu
cut -c 1-3 ${2}/tmp/tmp3 > ${2}/tmp/tmp3tavu
wc -l ${2}/tmp/tmp3tavu | sed "s|${2}/tmp/tmp3tavu||g" | tr -d  ' ' >  ${2}/tmp/tmp3count
# otetaan sanat joissa vähintään 5 kirjainta ja näiden rivimäärä 
# TODO jostain syystä ei poista kaikkia neljän kirjaimen juttuja...?
cat ${2}/tmp/tmp4 | awk 'length>4' > ${2}/tmp/tmpvahviisi
wc -l ${2}/tmp/tmpvahviisi | sed "s|${2}/tmp/tmpvahviisi||g" | tr -d ' ' > ${2}/tmp/tmpvahviisirivit
# muuttuja, johon tulee vähintään viisi merkkisten sanojen rivien lukumäärä
VARV=$( cat ${2}/tmp/tmpvahviisirivit | awk '{print $1}')
# otetaan kolme viimeistä kirjainta edellisestä ja lisätään tiedoston loppuun 
sed 's/^.*\(...\)$/\1/' ${2}/tmp/tmpvahviisi >> ${2}/tmp/tmp3tavu
# aakkosjärjestys ja uniq 3 ekaa kirjainta ja kirjoitetaan tiedostoon 
sort ${2}/tmp/tmp3tavu | uniq -c > ${2}/tmp/tmp3eritavu 
# kaikkien 3tavujen lkm kun 2tavut poistettu alusta 
awk '{print $1+var}' var="$VARV" ${2}/tmp/tmp3count | tr -d ' ' > ${2}/data/lkm3tavu
# erilaisten 3-tavujen lkm
wc -l ${2}/tmp/tmp3eritavu | sed "s|${2}/tmp/tmp3eritavu||g" | tr -d ' ' > ${2}/data/lkmeri3tavu
# kaikkien 3tavujen merkkimäärä
wc -l ${2}/tmp/tmp3 |  sed "s|${2}/tmp/tmp3||g" | tr -d ' ' > ${2}/tmp/tmpallcount
awk '{print 3*$1}' ${2}/tmp/tmpallcount | awk '{print $1+3*var}' var="$VARV" | tr -d ' ' > ${2}/data/lkmmerkki3tavu
