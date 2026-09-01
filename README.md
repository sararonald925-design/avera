# AVERA — The Avera Collective

AVERA is een redactioneel platform voor verhalen, onderzoek en collectieve inzichten over macht, stilte en herstel. Deze repository bevat de responsive landingspagina, gebouwd met Next.js, React en TypeScript, met optionele openbare content uit Supabase.

## Status

De huidige versie is een werkende landingspagina, geen volledig participatieplatform. Verhalen, impactcijfers en dossiers kunnen uit Supabase worden gelezen; zonder configuratie gebruikt de pagina lokale voorbeeldcontent.

- Anonieme deelname is op dit moment een informatieblok, zonder inzendformulier of opslag.
- Het nieuwsbriefformulier heeft nog geen verwerkingsendpoint.
- Artikelpagina's, dossierpagina's, ledenaccounts en redactiebeheer zijn nog niet geïmplementeerd.
- Cijfers en privacyclaims in het ontwerp zijn geen aantoonbare productieresultaten. Controleer en onderbouw deze vóór publieke ingebruikname.

## Snel starten

Gebruik Node.js 22 of hoger en npm. De vastgelegde Supabase SDK vereist minimaal Node.js 22; de repository legt zelf nog geen Node-versie vast.

```bash
git clone https://github.com/sararonald925-design/avera.git
cd avera
npm ci
npm run dev
```

Open [localhost:3000](http://localhost:3000). Zonder Supabase-variabelen is de landingspagina direct te bekijken met de statische fallback.

## Supabase aansluiten

Maak optioneel een lokale `.env.local` op basis van [`.env.example`](.env.example):

```dotenv
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=
```

Gebruik uitsluitend de project-URL en publieke publishable key. Een `service_role`-key of andere geheime sleutel hoort nooit in een `NEXT_PUBLIC_`-variabele. Herstart de ontwikkelserver na wijzigingen.

Het schema staat in [`supabase/avera_homepage.sql`](supabase/avera_homepage.sql). Lees eerst de [database-instructies](AVERA_TECHNISCHE_DOCUMENTATIE.md#6-database-en-contentbeheer): dit bestand bevat ook seed-upserts die bestaande content op dezelfde posities overschrijven. Voer het niet blind uit op een gedeelde productiedatabase.

## Controles

```bash
npm run lint
npx tsc --noEmit
npm run build
npm run start
```

Er is nog geen geautomatiseerde test-suite of GitHub Actions-workflow opgenomen. Zie de ontwikkelhandleiding voor de handmatige controles.

## Documentatie

| Document | Inhoud |
| --- | --- |
| [Platform- en technische documentatie](AVERA_TECHNISCHE_DOCUMENTATIE.md) | Productgrenzen, architectuur, ontwerp, datamodel, beveiligingsgrenzen, deployment en roadmap |
| [Ontwikkelhandleiding](CONTRIBUTING.md) | Branches, wijzigingen, validatie en pull-requestchecklist |
| [Agentinstructies](AGENTS.md) | Repositoryregels voor coding agents |

De technische documentatie beschrijft de gecontroleerde codebasis van 1 september 2026. Externe deployment- en database-instellingen zijn niet vanuit deze repository bevestigd.
