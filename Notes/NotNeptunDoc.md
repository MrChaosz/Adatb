---
Author: "Kulcsár Ádám"
---
# NotNeptun Dokumentáció
## Előszó
A program Apache XAMP-ot használ, mysql adatbázissal, nimble programozási nyelvben irva. Elméletileg teljesen cross platform (Windows, Linux, macOS), viszont Ubuntu alapó rendszeren való teszelés után kiderült egy openssl hiba, emiatt Windows rendszeren ajánlott a futtatása.

## Inditás
Inditás lehetséges egyenesen a NotNeptun mappájában lévő bináris fájlal, de ha valamiért nem működne akkor szükségünk lesz nim-re és nimble-re: [nim](https://nim-lang.org/install.html)

Emellett a fidget gui csomagra, amelyet `nimble install fidget` parancsal lehet telepiteni.

Forditani és inditani egyszerre a `nim c -r ./NotNeptun.nim -d:release --threads:on` paranccsal lehet. Utána pedig a létrehozott bináris fájlal.

Csatlakozni az adatbázisba a programon belül lehet. A kiexportált adatbázis alap adatai:
- host: localhost
- user: root
- password: root
- database: etr

## Egyed-Kapcsolati Diagram
![E-K diagramm](./EK.png "Egyed-kapcsolati diagramm")

## Táblák
Hallgato(<u>kód</u>, vezeteknev, keresztnev, szak) <br/>
- kód: a hallgató monogrammjából, a lista hosszából és véletlen számokból generált egyedi azonositó, legfeljebb 10 karakter, elsődleges kulcs
- vezeteknev: a hallgato vezetékneve, legfeljebb 255 karakter
- keresztnev: a hallgato keresztnneve, legfeljebb 255 karakter
- szak: hallgató szakja, legfeljebb 10 karakter <br/>

Oktato(<u>kód</u>, vezeteknev, keresztnev, kezdes)
- kód: az oktató monogrammjából, a lista hosszából és véletlen számokból generált egyedi azonositó, legfeljebb 10 karakter, elsődleges kulcs
- vezeteknev: az oktató vezetékneve, legfeljebb 255 karakter
- keresztnev: az oktató keresztnneve, legfeljebb 255 karakter
- szak: az oktató szakja, legfeljebb 10 karakter 
- kezdes: mikor kezdett oktatni, évszám <br/>

Kurzus(<u>kod</u>, nev, idopont) <br/>
- kod: kurzus kódja, amely a nevének a röviditése, legfeljebb 10 karakter, elsődleges kulcs
- nev: kurzus neve, legfeljebb 50 karakter
- idopont: nap amikor van a kurzus, datetime

Terem(<u>nev</u>, ferohely) <br/>
- nev: terem neve, legfeljebb 255 karakter, elsődleges kulcs
- ferohely: terem befogadó képessége, 11 hosszú szám

Epulet(<u>nev</u>, varos, utca) <br/>
- nev: épület neve, legfeljebb 50 karakter, elsődleges kulcs
- varos: város ahol az épület található, legfeljebb 255 karakter
- utva: az utca a városban ahol található az épület, legfeljebb 255 karakter

ResztVesz(<u>Hallgato.kod</u>, <u>Kurzus.kod</u>): N:N kapcsolat <br/>
Oktat(<u>Oktato.kod</u>, <u>Kurzus.kod</u>) N:N kapcsolat <br/>
TartvaVan(<u>Kurzus.kod</u>, <u>Terem.epuletnev</u>) N:1 kapcsolat <br/>
Tartalmaz( <u>epulet.nev</u>, <u>Terem.epuletnev</u> ) 1:N kapcsolat <br/>

## Relációs Adatbáziséma
Hallgato(<u>kód</u>, vezeteknev, keresztnev, szak) <br/>
Oktato(<u>kód</u>, vezeteknev, keresztnev, kezdes) <br/>
Kurzus(<u>kod</u>, *terem.nev* ,nev, idopont) <br/>
Terem(<u>nev</u>, *epuletnev*, ferohely) <br/>
Epulet(<u>nev</u>, varos, utca) <br/>
ResztVesz(<u>Hallgato.kod</u>, <u>Kurzus.kod</u>) <br/>
Oktat(<u>Oktato.kod</u>, <u>Kurzus.kod</u>) <br/>

## Funkcionális függőségek
Hallgato(<u>kód</u>, vezeteknev, keresztnev, szak) <br/>
{kod} -> { vezeteknev, keresztnev, szak }

Oktato(<u>kód</u>, vezeteknev, keresztnev, szak, kezdes) <br/>
{kod} -> { vezeteknev, keresztnev, szak, kezdes}

Kurzus(<u>kod</u>, *terem.nev* ,nev, idopont) <br/>
{kod} -> { terem.nev, nev, idopont } 

Terem(<u>nev</u>, *epulet.nev*, ferohely) <br/>
{ nev } -> { epulet.nev, ferohely }

Epulet(<u>nev</u>, varos, utca) <br/>
{ nev } -> { varos, utca }

## 2NF és 3NF
Hallgato(<u>kód</u>, vezeteknev, keresztnev, szak) <br/>
Oktato(<u>kód</u>, vezeteknev, keresztnev, szak, kezdes) <br/>
Kurzus(<u>kod</u>, *terem.nev*, nev, idopont) <br/>
Terem(<u>nev</u>, *epulet.nev*, ferohely) <br/>
Epulet(<u>nev</u>, varos, utca)  <br/>
ResztVesz(<u>Hallgato.kod</u>, <u>Kurzus.kod</u>) <br/>
Oktat(<u>Oktato.kod</u>, <u>Kurzus.kod</u>) <br/>

## Használt lekérdezések: 
- SELECT * FROM hallgato;
- SELECT * FROM terem;
- SELECT * FROM kurzus;
- SELECT * FROM epulet;
- SELECT * FROM oktato;
- SHOW TABLES FROM etr;
- SHOW COLUMNS FROM [ table ] IN etr; ahol table egy változó
- INSERT INTO [ table ] VALUES ...; ahol table a különböző táblák az adatbázisban, viszont felsorolásuk nagyon hosszú lenne
- DELETE FROM [ table ] WHERE hallgato.kod = [ key ]; ahol table a különböző táblák, a key pedig a kulcs ami alapján törlünk
- SELECT * FROM [ table ] WHERE hallgato.kod = [ key ]; ahol table a különböző táblák, a kulcs pedig ami alapján keresünk
- UPDATE [ table ] SET ... WHERE [ key ]; ahol table a tábla amit frissitünk, ... az adatok, key pedig a kulcs, ami alapján frissitünk

## Megvalósitás
A szoftver nim-ben volt irva, és mivel a fidget ui library nem támogatja erősen az objektum orientált programozást, ezért teljesen imperativ módon van megirva.

Kettő fontos fájl van, a NotNeptun.nim és a db.nim. A NotNeptun a megjelenitésért és adatok felviteléért felel, a db pedig az adatbázis műveletekért.

Különböző funkciók, fájlonként: <br/>
**NotNeptun.nim:**
- viewHallgatok <br>
A hallgato tábla megjelenését biztositja
- viewKurzusok <br>
A kurzus tábla megjelenését biztositja
- viewTermek <br>
A terem tábla megjelenését biztositja
- viewEpuletek <br>
Az epulet tábla megjelenését biztositja
- viewOktatok <br>
Az oktato tábla megjelenését biztositja
- hozzaAd <br>
A táblákhoz való hozzáadást biztositja
- torles <br>
A táblákból való törlést biztositja
- modositas <br>
A táblákon a modositást biztositja
- connect <br>
Az adatbázis felé a csatlakozást továbbitja
- drawMain <br>
A meglenitésért felelős főleg, menű és háttér rajzolásáért
- startFidget <br>
Ez inditja el az egész applikációt, kommunikál a fidget gui könyvtárral

**db.nim:**
- listHallgato <br>
SQL üzenetet küld a szerver fele, nem vár adatot, visszadja az összes hallgató adatait
- listTermek <br>
SQL üzenetet küld a szerver fele, nem vár adatot, visszadja az összes terem adatait
- listKurzusok <br>
SQL üzenetet küld a szerver fele, nem vár adatot, visszadja az összes kurzus adatait
- listEpulet <br>
SQL üzenetet küld a szerver fele, nem vár adatot, visszadja az összes épület adatait
- listOktato <br>
SQL üzenetet küld a szerver fele, nem vár adatot, visszadja az összes oktató adatait
- getTableNames <br>
SQL üzenetet küld a szerver fele, nem vár adatot, visszadja az összes tábla nevét ami az adatbázisban van
- getColumnsTable <br>
SQL üzenetet küld a szerver fele, egy tábla nevet vár, visszadja az összes oszlop nevét egy táblában
- insertData <br>
SQL üzenetet küld a szerver fele, egy tábla nevet és egy kulcsot vár, beilleszt adatot egy táblába
- deleteData <br>
SQL üzenetet küld a szerver fele és töröl egy adott adatot a táblába
- changeData <br>
SQL üzenetet küld a szerver fele, egy tábla nevet, egy kulcsot és az új adatokat várja, megváltoztat egy adott adatot a táblába
- searchKey <br>
SQL üzenetet küld a szerver fele, egy tábla nevet és egy kulcsot vár, visszadja azt a sort amely megegyezik a várt kulccsal
- dbConn <br>
A szerverhez való csatlakozási adatokat állitja be, a csatlakozás adatait várja

## Funkciók
A programban külünböző menűkön keresztül lehetőségünk van csatlakozni az adatbázishoz, adatokat megnézni és módositani. Ezekre a képernyőképeket lentebb láthatjuk.

## Felhasználói útmutató
Miután elinditottuk a programot, csakis egy lehetőségünk lesz, kiválasztani az adatbázishoz való csatlakozás menűt: <br/>
![Fogadó képernyő](./K%C3%A9perny%C5%91k%C3%A9pek/Fogad%C3%B3K%C3%A9p.PNG "Fogadó képernyő")

Onnan tudjuk hogy kiválasztottunk egy menűt, hogy kékre fog váltani a betű szine a gombban. <br/>
![Kiválasztott gomb](./K%C3%A9perny%C5%91k%C3%A9pek/Kiv%C3%A1lasztottGomb.PNG "Kiválasztott gomb")

Ha rámentünk a csatlakozás menűre akkor meg kell adni az adatbázishoz való csatlakozási adatokat. Ezek után a csatlakozás gombra kattintva tovább tudunk lépni. A mezők **nem** lehetnek üresek! <br/>
![Csatlakozás](./K%C3%A9perny%C5%91k%C3%A9pek/Csatlakoz%C3%A1s.PNG "Csatlakozás")

Továbblépésnél a főmenűben találjuk magunkat. Itt egy opciót kiválasztva léphetünk tovább különböző részekre. <br/>
![Főmenü](./K%C3%A9perny%C5%91k%C3%A9pek/F%C5%91men%C5%B1.PNG "Főmenü")

Ha kiválasztottunk egy menűt akkor meg fog jelenni a hozzá tartozó funkciók, példa az adatok megjelnitésére és a különböző funkciókra: <br/>
![Kiválasztott menű](./K%C3%A9perny%C5%91k%C3%A9pek/Kiv%C3%A1lasztottMen%C5%B1.PNG "Kiválasztott menű")

A különböző adat manipulációs mezőknél ki kell választani egy leeső menün keresztül a megváltoztatni kivánt táblát, fel kell vinni az kért adatokat, majd a gomb megnyomására az adatok változtatásra kerülnek, amiket a listázó menűkben megtekinthetünk. <br/>
![Hozzáadás](./K%C3%A9perny%C5%91k%C3%A9pek/Hozz%C3%A1ad%C3%A1s.PNG "Hozzáadás")
![Törlés](./K%C3%A9perny%C5%91k%C3%A9pek/T%C3%B6rl%C3%A9s.PNG "Törlés")
![Módositás](./K%C3%A9perny%C5%91k%C3%A9pek/M%C3%B3dositas.PNG "Módositás")