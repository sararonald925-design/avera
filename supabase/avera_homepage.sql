create extension if not exists pgcrypto;

create table if not exists public.avera_stories (
  id uuid primary key default gen_random_uuid(),
  number text not null,
  category text not null,
  title text not null,
  excerpt text not null,
  author text not null,
  reading_time text not null,
  position integer not null,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (position)
);

create table if not exists public.avera_impact_metrics (
  id uuid primary key default gen_random_uuid(),
  value text not null,
  label text not null,
  position integer not null,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (position)
);

create table if not exists public.avera_dossiers (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  summary text not null,
  position integer not null,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (position)
);

alter table public.avera_stories enable row level security;
alter table public.avera_impact_metrics enable row level security;
alter table public.avera_dossiers enable row level security;

drop policy if exists "Public can read published AVERA stories" on public.avera_stories;
create policy "Public can read published AVERA stories"
on public.avera_stories for select to anon, authenticated
using (is_published = true);

drop policy if exists "Public can read published AVERA metrics" on public.avera_impact_metrics;
create policy "Public can read published AVERA metrics"
on public.avera_impact_metrics for select to anon, authenticated
using (is_published = true);

drop policy if exists "Public can read published AVERA dossiers" on public.avera_dossiers;
create policy "Public can read published AVERA dossiers"
on public.avera_dossiers for select to anon, authenticated
using (is_published = true);

insert into public.avera_stories
  (number, category, title, excerpt, author, reading_time, position, is_published)
values
  ('01', 'Macht', 'Wanneer macht boven recht staat', 'Over ongelijkheid, bescherming en het misbruik van invloed.', 'Amira M.', '12 min', 1, true),
  ('02', 'Instellingen', 'De instellingen die wegkeken', 'Hoe systemen falen door cultuur, belangen en stilte.', 'Julie R.', '14 min', 2, true),
  ('03', 'Herstel', 'Herstel is geen eindpunt, maar een richting', 'Drie vrouwen over veerkracht, gemeenschap en echte verandering.', 'Noor S.', '11 min', 3, true)
on conflict (position) do update set
  number = excluded.number,
  category = excluded.category,
  title = excluded.title,
  excerpt = excluded.excerpt,
  author = excluded.author,
  reading_time = excluded.reading_time,
  is_published = excluded.is_published,
  updated_at = now();

insert into public.avera_impact_metrics
  (value, label, position, is_published)
values
  ('4.821', 'Ervaringen gedeeld (anoniem)', 1, true),
  ('1.265', 'Patronen onderzocht', 2, true),
  ('100%', 'Stemmen beschermd', 3, true)
on conflict (position) do update set
  value = excluded.value,
  label = excluded.label,
  is_published = excluded.is_published,
  updated_at = now();

insert into public.avera_dossiers
  (title, summary, position, is_published)
values
  ('Macht', 'Hoe invloed zich boven regels plaatst — en verantwoordelijkheid verdwijnt.', 1, true),
  ('Stilte', 'Waarom zwijgen wordt beloond, en spreken zoveel kost.', 2, true),
  ('Institutionele verantwoordelijkheid', 'Wanneer systemen falen, wie draagt dan de last?', 3, true)
on conflict (position) do update set
  title = excluded.title,
  summary = excluded.summary,
  is_published = excluded.is_published,
  updated_at = now();
