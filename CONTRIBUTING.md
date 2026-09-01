# Ontwikkelen aan AVERA

Deze handleiding beschrijft de voorgestelde werkwijze voor nieuwe AVERA-wijzigingen. Zij is geen claim dat alle controles al geautomatiseerd zijn. Lees eerst de [README](README.md), de [technische documentatie](AVERA_TECHNISCHE_DOCUMENTATIE.md) en [AGENTS.md](AGENTS.md).

## 1. Begin met een afgebakende wijziging

Beschrijf vooraf het doel, de betrokken onderdelen en de acceptatiecriteria. Maak onderscheid tussen openbare redactionele content en vertrouwelijke participatie- of onderzoeksgegevens.

Gebruik voor wijzigingen een aparte branch, bijvoorbeeld `docs/platform-documentation`, `feat/story-detail` of `fix/mobile-navigation`. Open een pull request naar `main`; publiceer geen grote of ongeteste wijzigingen rechtstreeks op `main`. Repositorybeheerders kunnen dit later afdwingen met branchregels en verplichte controles.

De huidige repository bevat nog geen verplichte CI-controles. Een review of groen buildresultaat is daarom geen vervanging voor de hieronder genoemde handmatige tests.

## 2. Lokale werkwijze

1. Werk vanaf een actuele codebasis en behoud eventuele bestaande lokale wijzigingen.
2. Gebruik minimaal Node.js 22 en installeer met `npm ci`.
3. Start met `npm run dev`. Zonder Supabase-configuratie is de fallback voldoende voor veel ontwerpwijzigingen.
4. Gebruik voor datatests een bevestigde testomgeving, geen echte persoonlijke bijdragen.
5. Houd de wijziging klein en actualiseer documentatie in dezelfde pull request.

Voor frameworkwijzigingen geldt [AGENTS.md](AGENTS.md): lees de relevante documentatie onder `node_modules/next/dist/docs/` van de geïnstalleerde Next-versie. Ga niet alleen af op gewoonten uit eerdere versies.

## 3. Code en ontwerp

- Houd paginaopbouw, datatoegang en fallbackcontent gescheiden volgens de bestaande bestandsverantwoordelijkheden.
- Gebruik de tokens in `globals.css` voor het basispalet. Nieuwe afwijkende kleuren zijn expliciete ontwerpkeuzes.
- Behoud de vloeiende overgang tussen header, hero-afbeelding en achtergrond.
- Voeg geen clientcomponent, afhankelijkheid of externe dienst toe zonder functionele noodzaak en toelichting.
- Houd links, knoppen, labels en focusgedrag toegankelijk. Maak een visuele placeholder niet ongemerkt operationeel.
- Gebruik geen verzonnen succesmeldingen of privacygaranties. Formulieren moeten hun werkelijke status tonen.
- Behandel cijfers als democontent totdat bron, definitie en peildatum zijn bevestigd.

Bij dependencywijzigingen horen `package.json` en `package-lock.json` samen in de pull request. Vermijd ongerelateerde updates.

## 4. Databasewijzigingen

De huidige basis staat in `supabase/avera_homepage.sql`; er is nog geen geconfigureerde migratiepipeline. Leg voor iedere schemaverandering de uitvoervolgorde, impact en herstelstrategie vast en sluit aan op de bevestigde werkwijze van het gedeelde Supabase-project.

- Inspecteer bestaande tabellen en policies voordat je een gedeeld schema wijzigt.
- Maak migraties en applicatieaanpassingen samen beoordeelbaar, zonder ze automatisch op productie uit te voeren.
- Houd schemawijzigingen gescheiden van demonstratiedata. De bestaande seed-upserts kunnen posities 1–3 overschrijven en publiceren.
- Controleer SELECT én geweigerde schrijfacties met de publieke rol. Test niet uitsluitend als beheerder.
- Test ongepubliceerde content en de gevallen nul, twee, drie en vier gepubliceerde records.
- Beoordeel expliciet het fallbackgedrag bij intrekking: de huidige volledige fallback bij minder dan drie rijen is geen veilige productie-publicatieworkflow.
- Gebruik geen `service_role`-key of andere geheime sleutel in frontendcode, `NEXT_PUBLIC_`-variabelen, issues of testfixtures.

Nieuwe koppelingen met Meridian of Phosphoros vereisen bevestigde schema's en datagrenzen. Raad identifiers, tabelnamen of toegangsniveaus niet.

## 5. Verificatie

Voer bij codewijzigingen uit:

```bash
npm run lint
npx tsc --noEmit
npm run build
npm run start
```

Rapporteer de werkelijke resultaten. Als een controle niet uitvoerbaar was, vermeld welke, waarom en wat nog moet worden gecontroleerd. Een build met fallbackdata bewijst geen werkende databasekoppeling.

### Handmatige minimumcontrole

| Controle | Verwacht resultaat |
| --- | --- |
| Desktop 1440 × 1000 en breed 1920 × 1080 | Hero-overgang intact; tekst en secties niet afgesneden |
| Tablet 768 × 1024 | Mobiele navigatie en herschikte grids bruikbaar |
| Mobiel 390 × 844 | Geen horizontale overflow; CTA's en invoerveld bereikbaar |
| Rond 1150, 850 en 560 px | Geen layoutsprongen die content verbergen |
| Alleen toetsenbord en 200% zoom | Logische volgorde, zichtbare focus en leesbare content |
| Reduced motion | Niet-essentiële overgangen beperkt |
| Zonder Supabase-configuratie | Volledige lokale fallback verschijnt |
| Met testdatabase, drie gepubliceerde rijen per groep | Herkenbare databasecontent verschijnt |
| Onvolledige dataset of geretourneerde queryfout | Huidige fallback per groep is aantoonbaar en bewust beoordeeld |
| Ankers en placeholders | Bestaande ankers werken; ongebouwde bestemmingen zijn niet als afgerond beschreven |

Gebruik voor databasecontroles een geïsoleerde testomgeving. Test nieuwsbriefvelden alleen met fictieve adressen zolang de verwerking ontbreekt. Bij uitsluitend documentatiewijzigingen volstaan controle tegen de broncode, werkende bestandslinks en inspectie van de Markdown; vermeld dat geen runtime-tests zijn uitgevoerd.

## 6. Pull-requestchecklist

- [ ] Doel, scope en acceptatiecriteria zijn duidelijk.
- [ ] Alleen bedoelde bestanden zijn gewijzigd.
- [ ] Bestaande werking en nog te bouwen functionaliteit worden onderscheiden.
- [ ] Lint, typecontrole en build zijn uitgevoerd, of de reden om ze over te slaan is beschreven.
- [ ] Relevante schermgroottes en toegankelijkheidsinteracties zijn gecontroleerd.
- [ ] Database- en fallbackgedrag zijn getest wanneer datatoegang verandert.
- [ ] Er staan geen geheimen, echte inzendingen of persoonsgegevens in diff, logs of screenshots.
- [ ] Gewijzigde cijfers, beelden en veiligheidsclaims hebben een gecontroleerde herkomst.
- [ ] Documentatie en eventuele migratie-/herstelstappen zijn bijgewerkt.
- [ ] Bekende beperkingen en open beslissingen staan in de PR-beschrijving.

## 7. Na samenvoegen

Controleer de daadwerkelijke deployment, niet alleen de merge. Doe een smoke-test van homepage, assets, navigatie en actieve databron. Een documentatie-PR voert geen databasewijziging uit en activeert geen ontbrekende productfunctie.

Bij problemen: leg reproduceerstappen, omgeving en betrokken commit vast zonder gevoelige gegevens te publiceren. Rol applicatie en database alleen volgens hun afzonderlijke herstelprocedure terug.
