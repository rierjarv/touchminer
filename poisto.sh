#!/bin/bash
# gutenberg Lähdemateriaalin käsittelyskripti, v.0.2 27.12.2014
# Project Gutenberg e-kirjoista poistaa tekstitiedostojen header ja footer 
# tarkasti ottaen poistaa saman kansion t*.txt-filuista (jättää alkuperäiset)
  # rivejä alusta 100 kpl ja lopusta 400 kpl (eli gutenberg
  # erikoismerkit " ? ! * . , ^ ; : jne.

  # luodaan tyhjä tiedosto esiprosessointia varten 
  if [ -f "gutenberg" ]; then rm gutenberg; fi 
  touch gutenberg

  # käydään läpi jokainen tekstitiedosto joka alkaa t:llä 
  for j in {1..92}
  do 
    # väliaikaiset tiedostot 
    if [ -f "l$j" ]; then rm l$j; fi 
    if [ -f "y$j" ]; then rm y$j; fi 
    touch l$j y$j

    # käsitellään väliaikaisia l$j-tiedostoja 
    cp t$j.txt l$j

    # poistetaan 100 riviä alusta
    sed '1,100d' l$j > y$j 
    cat /dev/null > l$j

    # poistetaan 400 riviä lopusta 
    tail -r < y$j | sed '1,400d' > l$j

    # poistetaan erikoismerkit 
    sed 's/["?!*»«<>.,^¨;:-]/ /g' l$j | sed 's/--/ /g' > y$j 

    # matskut tyhjään tiedostoon 
    cat y$j >> gutenberg  

    # poistetaan väliaikaiset tiedostot 
    rm l$j 
  done 
