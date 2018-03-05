# touchminer
A Command-line program for creating optimal touch typing exercises from ebook data.

**versio 0.71 2018/3/5**
-Moved the project to Github
-Checked the log below and corrected some typos 
-TODO translate this README to English from Finnish 

**versio 0.7 2015/1/25**
-tavut 2 kirjainta mukaan analyysiin sekä vastaavat harjoitukset...
  * tavujen otto cut -c 1-2 
  * kaksi kirjainta sanan alusta ja lopusta harjoituksiin 
  * korjattu merkkien lkm ei laske enää whitespaceja mukaan vähennetty awk
  * merkkien lkm wc -m huomioi multibyte characterit eli ä:t ja ö:t vain kerran
  * kopioitu tavu2harj.sh sanaharj.sh pohjasta ja muokattu sopivasti
-tavut 3 kirjainta mukaan analyysiin sekä vastaavat harjoitukset...
  * tavujen otto cut -c 1-3 
  * kolme kirjainta sanan alusta ja lopusta harjoituksiin 
  * tiedosto tavu2harj.sh tehty ja testattu ok 
-globaalit laskut eli 
  - tavujen frekvenssit ja peittävyydet 

**versio 0.62 2015/1/3**
-projektikohtainen hakemisto analyysille (eval) 
-muutettu kansiohierarkiaa: python-skriptit ja ref/ päähakemistossa 
-testattu toimivuus
-jaettu ohjelma osiin: 
  * touchminer.sh käynnistää muut osat
  * hakemistot.sh
  * sanatjamerkit.sh 
  * sanaharj.sh 
  * kokoavatoperaatiot.sh
  * TODO tavuharjoitukset ja niiden ajofilut
  * plotting.sh 
  * raportti.sh 
  * erillisenä on lähdemateriaalin prosessointi (riippuu materiaalista) sekä plottaus
-lokaali aika-arvio harjoituksille sekä data lokaaliin tiedostoon nopeusjaaika, liittyy lokaali plottaus (ei tehty) 

**versio 0.61 2015/1/2**
-paranneltu plottia python/plotjakauma.py 
 * bar graph leveys + autolabel tekstit + legend + värit + palkin reunan leveys 
 * matplotlibrc tehty hakemistoon python 
   . dpi-values 
   . autosave pdf 
   . serif fonts 
 * autosave pdf plotit hakemistoon ../plot/

**versio 0.6 2014/12/31**
-muutettu datafilut txt-pääte pythonia varten 
-tehty jakauma100 plottausta varten
-normitetun jakauman saa suoraan normed=1 tai normed=true -komennolla pythonin histogrammissa


**versio 0.5 2014/12/30**
-korjattu: poistettu yhden kirjaimen patternit awk:ksi 
-lisätty: harjoiteltavat merkit per kirjain logitiedostoon kirjoittaminen 
-liä¤tty kirjainkohtaisiin filuihin .txt-pääte (windows-siirtoa varten rapidtyping) 
-laskettu peittävyys awk:lla
-data/jakauma valmis plottaukseen 
  * sarake1 = x-aks eli kuinka monta sanaa joilla ks. frekvenssi
  * sarake2 = y-aks eli kuinka monta counttia ks. frekvenssin kaikilla sanoilla
-siistitty koodia mm. ylimääräisiä sortteja pois, nopeuttaa
-TÄRKEÄ: kirjoitettu koko koodi uudestaan siten, että tekee yhdellä kertaa eri analyysit 
-kirjainkohtaiset merkkimäärät data plottausta varten valmis tiedostossa "$i"/merkit
-globaali normitettu frekvenssi eli peittävyys ok
-globaali frekvenssi ok
-tehty useita eri analyysikansioita 
-analyysikohtaiset plotit (kirjainkohtaiset merkkimäärät) ohjattu data-hakemistoon

**versio 0.4 2014/12/28**
-poistettu yhden kirjaimen sarjat tärkeistä sanoista 
-suunniteltu rakenne kokonaan uusiksi
  * uudessa työnjaossa bash hoitaa raakadatan käsittelyn, python plottauksen
  * tarvitaan tieto kaikista harjoituksista ennen kuin kannattaa toteuttaa 
-asennettu python (homebrew) ja matplotlib yms. juttuja sekä virtualenv

**versio 0.3 2014/12/26**
-optimoitu koodia mm. poisto.sh tail-käyttö 
-touchminer.sh tekee tällä hetkellä vain sanoja
-touchminer.sh 4000 yleisintä sanaa, greppaillaan aakkosellisiin tiedostoihin 
 (automaattinormitus kurssin pituuden suhteen tulee realistisesti näiden sanojen osalta). kun siirretään
 harjoitukset RapidTyping, niin käsin poistetaan epärelevantit sanat
-edelliseen liittyen matematiikka vain kertoo sen, kuinka suuri tai pieni prosenttiosuus  
 lähdemateriaalin sanoista jää nyt harjoittelematta. Tämä tulee olemaan merkittävä aina, kun
 yritetään tehdä yleispäteviä harjoituksia (mutta ei esimerkiksi asiakkaan datan analysoinnissa)
-keksitty millä nähdään normitukset, 
-jakauman tarkasteluun tarvitaan aritmetiikkaa vähintään piirtovaiheessa; 
-mahdollista olisi kyllä tehdä jakaumia vastaava datafilu perusoperaatioilla

**versio 0.2 2014/12/15**
-tehty lähdemateriaalin käsittelyä, 29M gutenberg.txt-filu
-tehty pipeline hahmottelua paperille
-korjailtu bugeja

**versio 0.1 2014/12/14**
-ensimmäinen versio
-Tiedostot
    poisto.sh 
      aineiston esikäsittely Gutenberg-kirjastosta latauksen jälkeen.
    touchminer.sh 
      etsii yleisimmäät sanat argumenttina annetusta tekstitiedostosta
    testi.sh 
      kokeillaan ominaisuuksia 
