# NotNeptun Dokumentáció
## Előszó
A program Apache XAMP-ot használ, mysql adatbázissal, nimble programozási nyelvben irva. Elméletileg teljesen cross platform (Windows, Linux, macOS), viszont csakis Windows-on volt tesztelve.
## Inditás
Inditás lehetséges egyenesen a NotNeptun mappájában lévő exe fájlal, de ha valamiért nem működne akkor szükségünk lesz a nimble-re: https://nim-lang.org/install.html.

Forditani és inditani egyszerre a **nim c -r ./NotNeptun.nim -d:release --threads:on** paranccsal lehet.

## Egyed-Kapcsolati Diagram
![E-K diagramm](./EK.png "Egyed-kapcsolati diagramm")