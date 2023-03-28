Changelog
=========

ParcelPro Shipment module voor Wordpress / WooCommerce
(c) Parcel Pro [parcelpro.nl]

## 1.5.39
* Tweak: General changes to be accepted on Wordpress repository

## 1.5.38
* Fix: The title of flat_rates or other rates that hadn’t been configured is now correctly displayed
* Tweak: Implement a proxy for all the API requests
* Tweak: Add extra info in the headers of the API requests

## 1.5.37
* Rebranding the plugin

## 1.5.36
* Fix: Uitzonderlijke foutmelding opgelost bij het laden van een order met producten zonder lengte, breedte of hoogte ingevuld.

## 1.5.35
* Fix: Checkout verbetering om te verzekeren dat de afhaalpunt pop up en parameters altijd in de checkout form geplaatst worden. 
* Fix: Fix voor unidentified index notice bij het overnemen van trackinggegevens.

## 1.5.34
* Fix: Landcode van pakketpunt overnemen

## 1.5.33
* Fix: Communiceert nu verzendregel titel via de achtergrond.
* Fix: Fix voor layout problemen met bepaalde themes.
* Fix: Notice melding als er geen mail id ingesteld is
* Fix: Melding als er geen landing ingesteld zijn op woocommerce omgeving.
* Fix: Naam verandering voor Api Key en Gebruikers ID om verwarring te voorkomen.
* Fix: Automatisch aanmeldstatus aangepast bij standaard instellingen.
* Fix: Overschrijvende status bij aanmelding aangepast bij standaard instellingen.


## 1.5.32
* Nieuw:  Melding 'geen afhaalpunten geselecteerd' nu geregristreerd als vertaalbaar.
* Fix: Meerdere deprecated jQuery functies geüpdatet.

## 1.5.31
* Nieuw:  Optie toegevoegd om klant opmerkingen bij de order aan te melden.

## 1.5.30
* Fix: Homerr verbeterde punten check.

## 1.5.29
* Fix: Bug bij het veranderen van verzendmethode met pakketpunt in de checkout opgelost.

## 1.5.28
* Fix: Er wordt nu strenger gecontroleerd op Homerr punten en of deze ingevuld zijn in de checkout.

## 1.5.27
* Fix: Bug in checkout opgelost.

## 1.5.26
* Fix: Homerr verzendmethodes worden nu beter verwerkt.

## 1.5.25
* Nieuw: Bij het aanpassen van een verzendmethode wordt de afhaalpunt nu verwijderd inplaats van gebruikt als afleveradres.

## 1.5.24
* Fix: Foutmeldingen null defined variables opgelost.

## 1.5.23
* Fix: Extra diensten met buitenlandse afhaalpunten werken nu beter. Alleen voor DHL ondersteund.

## 1.5.22
* Fix: Gewichten en dimensies worden nu correct doorgezet naar Parcel Pro systeem op basis van gekozen eenheid.

## 1.5.21
- Nieuw: Vervoerder gebruikt om barcode te genereren wordt nu opgeslagen in een meta veld ([#orderid]_parcelpro_track_vervoerder) voor koppelingsmogelijkheden.
- Nieuw: Optie toegevoegd voor extra diensten om expliciet aan te kunnen geven of afhaalpunten gekozen moeten worden of niet.

##  1.5.20
- Nieuw: Pop-upscherm wordt getoond voor pakketpunten van Homerr.

##  1.5.19
- Nieuw: Barcode wordt nu toegevoegd aan de order notes zodra zending aangemeld wordt.
- Nieuw: Gewichten worden nu doorgestuurd met de zendingsgegevens.
- Fix: Sorteer tabel is nu iets gebruiksvriendelijker gemaakt.

##  1.5.18
- Nieuw: Optie om het berekenen met coupons aan/uit te zetten.
- Fix: Probleem opgelost dat ervoor zorgde dat bij het printen in bulk de meest recente label overgeslagen werd.

##  1.5.17
- Fix:  Een warning die gegeven werd door parcelpro-admin.js opgelost.

##  1.5.16
- Fix:  Opslaan van gekozen pakketpunt

## 1.5.15
- Optie om order status aan te passen na aanmelden toegevoegd.

## 1.5.14
- Problemen opgelost met deployment

## 1.5.13
- Problemen opgelost met deployment

##  1.5.12
- Opgelost dat de parcel pro locatie kiezer werd geopend op andere shipment methodes.
- Verbeterde documentatie voor custom hooks; zie read me.

##  1.5.11
-  Update voor nieuwe versie van Woocommerce

##  1.5.10
-  Update voor nieuwe versie van Woocommerce

##  1.5.9
-  Update voor nieuwe versie van Woocommerce

##  1.5.8
-  Update voor nieuwe versie van Woocommerce

##  1.5.7
-  Update voor nieuwe versie van Woocommerce

##  1.5.6
-  Update voor nieuwe versie van Woocommerce

## 1.5.5
### Fixes
-   Variatie ID s die verkeerd werden opgehaald via oude methode nu verhopen.

## 1.5.4
### Fixes
- Handmatige orders kunnen nu correct aangemaakt worden met een verzendmethode.

## 1.5.3
### Fixes
- Orders worden nu correct binnengeschoten.

## 1.5.2
#### Fixes
- Orders kunnen via de backend aangemaak worden zonder problemen.

## 1.5.1
#### Fixes
- Betere beveiliging op de achtergrond.

## 1.5.0
#### Fixes
- Er kan weer direct worden afgedrukt als de label opgevraagd wordt.
#### Nieuwe functionaliteiten
- Nieuw: Maatwerk verzendopties kunnen nu worden toevoegd.


## V.1.4.2

#### Fixes

- Gekozen parcelshop

## V.1.4.1

#### Nieuwe functionaliteiten

- Verzendopties achteraf via de backend wijzigen.

## V.1.4.0

#### Nieuwe functionaliteiten

- Verzendopties achteraf via de backend wijzigen.
#### Fixes

- E-mail variabelen

## V.1.2.8

#### Nieuwe functionaliteiten

- PostNL Handtekening voor ontvangst ook bij buren.

#### Fixes

- Fix Type aanroep via API.

## V.1.2.7

#### Fixes

- Fix m.b.t. Woocommerce check

## V.1.2.6

#### Fixes

- Fix m.b.t. php 7 'A non-numeric value encountered'

## V.1.2.5

#### Fixes

- Fix m.b.t. array_merge

## V.1.2.4

#### Nieuwe functionaliteiten

- VSP Brievenbuspakketje

#### Fixes

- Compatible wordpress 3.9 // Woocommerce 3.2.4
- array_key_exists() error bij nieuwe installatie.
- Auto export na status
- Same day

## V.1.2.3

#### Fixes

- Order items ophalen in woocommerce 3.x

## V.1.2.2

#### Fixes

- Controle of gekozen afhaalpunt ook hetzelfde is als de vervoerder van de verzendmethode.

## V.1.2.1

#### Nieuwe functionaliteiten

- Soorteren van Parcel Pro verzendmethodes.

#### Fixes

- Openen van popup bij het laden van het scherm wanneer een verzendmethode met afhaalpunt is geselecteerd.
- Wanneer verzendmethode met afhaalpunt gratis is geen undefined prijs.
- Lege titels in een rule krijgen een standaard titel.
- "Add Rule" button type gegeven tegen aanpassen input.

## V.1.2.0

#### Nieuwe functionaliteiten

- Verzendoptie Brievenbuspakketje voor DHL en PostNL.
- Mogelijkheid om eigen titel mee te geven aan verzendmethode.
- Aanmelden van een zending bij Parcel Pro bij een specifieke statuss.
- Handleiding voor het installeren van de WooCommerce module.

#### Fixes

- Openen van popup voor het kiezen van een afhaalpunt wanneer betalingsmethode veranderd.
- Verkeerd weergeven van prijs bij het kiezen van een afhaalpunt.

## V.1.1.4

#### Fixes

- Validatie van ingevoerde prijs en gewichten, fixt bug met variable btw.

## V.1.1.3

#### Fixes

- Quantity van producten bij bepalen gewicht zending en methodes.

## V.1.1.2

#### Nieuwe functionaliteiten

- Ondersteuning voor WooCommerce Sequential Order Numbers plugin

## V.1.1.1

#### Fixes

- Bugfix m.b.t. automatisch aanmelden
- Klikgedrag afhaallocatie frame

## V.1.1.0

#### Fixes

- BTW tarief in winkelwagen

#### Nieuwe functionaliteiten

- Ondersteuning voor DHL, DPD, PostNL en UPS

## V.1.0.0

#### Nieuwe functionaliteiten

- Verzendmethoden aanmaken
- Bestellingen aanmelden in het verzendsysteem
- Verzendlabel afdrukken
- Afhaallocatie kiezen voor zowel DHL als PostNL
- Ondersteuning voor DHL en PostNL
