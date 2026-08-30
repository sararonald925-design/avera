# AVERA — Technische documentatie

**Versie:** 1.0  
**Datum:** 30 augustus 2026  
**Status:** eerste zelfstandige implementatie

## 1. Doel en bron

Deze implementatie zet de bestaande AVERA-landingspagina om naar een zelfstandige applicatie. De werkende AVERA Site is de visuele en inhoudelijke bron van waarheid: de negen bestaande inhoudsblokken, volgorde, typografie, kleuren, afbeeldingen en responsieve compositie zijn behouden.

## 2. Stack

AVERA volgt dezelfde basis als Phosphoros:

- Next.js 16.3.2 met App Router;
- React en React DOM 19.2.8;
- TypeScript in strict mode;
- CSS Modules voor de landingspagina;
- `@supabase/supabase-js` 2.x voor de publieke databaseclient;
- npm en een vastgelegde `package-lock.json`;
- alias `@/*` naar `src/*`;
- geschikt voor een normale Next.js/Vercel-deployment.

## 3. Projectstructuur

```text
src/app/
  globals.css
  layout.tsx
  page.module.css
  page.tsx
src/data/homepage.ts
src/lib/homepage.ts
src/lib/supabase.ts
public/images/
supabase/avera_homepage.sql
```

`page.tsx` is een servercomponent. `page.module.css` bevat alle paginaspecifieke vormgeving; `globals.css` bevat alleen resetregels, ontwerptokens en globale toegankelijkheidsregels.

## 4. Inhoudsopbouw

De homepage bevat:

1. sticky `SiteHeader`;
2. `InvestigationHero`;
3. `ImpactMetrics`;
4. `AnonymousParticipation`;
5. `FeaturedStories`;
6. `SignalData`;
7. `DossierGrid`;
8. `CollectiveAction` en nieuwsbrief;
9. `SiteFooter`.

De secties blijven in één route omdat de referentie een doorlopende redactionele landingspagina is. De componentgrenzen zijn visueel en semantisch herkenbaar in de JSX en kunnen later zonder datamigratie naar aparte bestanden worden verplaatst.

## 5. Supabase-methode

De publieke client gebruikt dezelfde omgevingsvariabelen als Phosphoros:

```env
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=
```

`src/lib/supabase.ts` maakt uitsluitend een publieke client aan. Er wordt geen service-role key naar de browser of repository geschreven. `src/lib/homepage.ts` leest drie gepubliceerde datasets parallel en valt per dataset terug op de gecontroleerde statische inhoud wanneer de omgeving nog niet is gekoppeld, een query faalt of de verwachte drie items ontbreken.

## 6. Gegevensmodel en RLS

`supabase/avera_homepage.sql` maakt drie tabellen:

- `avera_stories`;
- `avera_impact_metrics`;
- `avera_dossiers`.

Row Level Security staat op iedere tabel aan. De publieke rollen `anon` en `authenticated` kunnen alleen rijen lezen waarvoor `is_published = true`. Er bestaan geen publieke insert-, update- of deletepolicies. Seedgegevens reproduceren de inhoud van de referentiepagina en zijn idempotent via `on conflict (position)`.

## 7. Rendering en terugval

De route wordt server-side opgebouwd en heeft een revalidatieperiode van vijf minuten. Wanneer Supabase niet is ingesteld, blijft de pagina volledig bouwbaar en toont zij exact dezelfde inhoud uit `src/data/homepage.ts`. Hierdoor blokkeert databaseconfiguratie de eerste deployment niet.

## 8. Privacy, veiligheid en toegankelijkheid

- Geen geheime Supabase-sleutels in clientcode of Git.
- Alleen gepubliceerde redactionele records zijn publiek leesbaar.
- De huidige “anoniem deelnemen”-onderdelen zijn informatief; er wordt in deze eerste implementatie nog geen gevoelige ervaring verzonden of opgeslagen.
- Navigatie en secties gebruiken semantische HTML en Nederlandstalige aria-labels.
- Alle interactieve elementen hebben zichtbare toetsenbordfocus.
- `prefers-reduced-motion` schakelt niet-essentiële animatieduur vrijwel uit.
- Afbeeldingen die als achtergrond dienen hebben beschrijvende `role="img"`-labels.

## 9. Responsive gedrag

De gedeelde paginabreedte en uitlijning worden gestuurd door `--page-gutter`. Desktop, tablet en mobiel behouden dezelfde inhoudsvolgorde. Onder 850 px wordt de desktopnavigatie vervangen door een native `details`-menu; grids schakelen vervolgens naar twee of één kolom. Onder 560 px worden typografie, witruimte, formulieren en footer verder verdicht zonder inhoud te verbergen.

## 10. Installatie en validatie

```bash
npm install
npm run lint
npx tsc --noEmit
npm run build
```

Voor databasekoppeling: voer `supabase/avera_homepage.sql` uit en vul daarna `.env.local` met de twee publieke waarden uit `.env.example`.

## 11. Vervolgwerk

De volgende functionele stap is het afzonderlijk ontwerpen van veilige inzendingen en nieuwsbriefregistratie. Dat vereist expliciete gegevensminimalisatie, moderatie, bewaartermijnen, rate limiting en private RLS-policies. Deze eerste PR slaat daarom nog geen persoonsgegevens of ervaringen op.
