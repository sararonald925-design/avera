# AVERA

AVERA is een onafhankelijk redactioneel platform voor verhalen, onderzoek en collectieve kennis. Deze repository bevat de zelfstandige Next.js-versie van de bestaande AVERA-landingspagina.

## Lokale ontwikkeling

```bash
npm install
npm run dev
```

Open daarna `http://localhost:3000`.

## Supabase

Kopieer `.env.example` naar `.env.local` en vul de publieke projectwaarden in:

```env
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=
```

Voer `supabase/avera_homepage.sql` uit in de Supabase SQL Editor. Zonder omgevingsvariabelen gebruikt de homepage dezelfde statische inhoud, zodat lokale builds en previews altijd blijven werken.

## Controle

```bash
npm run lint
npx tsc --noEmit
npm run build
```

Zie `AVERA_TECHNISCHE_DOCUMENTATIE.md` voor architectuur, privacy, gegevensmodel en implementatiekeuzes.
