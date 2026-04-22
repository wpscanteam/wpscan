# Changelog

Všechny změny a vylepšení pluginu jsou zaznamenány v tomto souboru.

## Verze 1.2.1 (datum vydání: 14.06.2023)

### Added
- Přidána možnost aktualizovat již existujícího uživatele, pokud ho již máte v seznamu (update_existing = true/false)
- Přidána možnost znovu přihlásit odhlášeného odběratele (resubscribe = true/false)
- Přepracována funkce odesílání dat (subscriber_data), aby se přes API posílaly jen položky opravdu vyplněné

## Verze 1.2.0 (datum vydání: 13.06.2023)

### Added
- Přidána nová kolonka pro integraci telefonního čísla
- Přidána možnost napsat tagy pro další segmentaci v rámci seznamů v Ecomail

## Verze 1.1.1 (datum vydání: 07.06.2023)

### Added
- Přidána funkcionality 'trigger_autoresponders' => true, aby se odesílaly automatizace.

## Verze 1.1.0 (datum vydání: 22.03.2023)

### Added
- Přidána možnost specifikovat field ID pro jméno a příjmení.

## Verze 1.0.0 (datum vydání: 21.03.2023)

### Added
- První vydání pluginu Elementor Ecomail Integration
- Základní integrace Ecomailu s widgetem formuláře Elementor Pro
- Přidána možnost nastavit Ecomail integraci v nastavení formuláře Elementor Pro
  - Možnost zadat klíč API Ecomail do pole "Ecomail API Key"
  - Možnost zadat identifikátor seznamu Ecomail (List ID) do pole "Ecomail List ID"
- Přidána Ecomail akce do možností formuláře "Actions After Submit"