export type Story = {
  number: string;
  category: string;
  title: string;
  excerpt: string;
  author: string;
  time: string;
};

export type ImpactMetric = {
  value: string;
  label: string;
};

export type Dossier = {
  title: string;
  text: string;
};

export type HomepageContent = {
  stories: Story[];
  metrics: ImpactMetric[];
  dossiers: Dossier[];
};

export const staticHomepageContent: HomepageContent = {
  stories: [
    {
      number: "01",
      category: "Macht",
      title: "Wanneer macht boven recht staat",
      excerpt: "Over ongelijkheid, bescherming en het misbruik van invloed.",
      author: "Amira M.",
      time: "12 min",
    },
    {
      number: "02",
      category: "Instellingen",
      title: "De instellingen die wegkeken",
      excerpt: "Hoe systemen falen door cultuur, belangen en stilte.",
      author: "Julie R.",
      time: "14 min",
    },
    {
      number: "03",
      category: "Herstel",
      title: "Herstel is geen eindpunt, maar een richting",
      excerpt: "Drie vrouwen over veerkracht, gemeenschap en echte verandering.",
      author: "Noor S.",
      time: "11 min",
    },
  ],
  metrics: [
    { value: "4.821", label: "Ervaringen gedeeld (anoniem)" },
    { value: "1.265", label: "Patronen onderzocht" },
    { value: "100%", label: "Stemmen beschermd" },
  ],
  dossiers: [
    {
      title: "Macht",
      text: "Hoe invloed zich boven regels plaatst — en verantwoordelijkheid verdwijnt.",
    },
    {
      title: "Stilte",
      text: "Waarom zwijgen wordt beloond, en spreken zoveel kost.",
    },
    {
      title: "Institutionele verantwoordelijkheid",
      text: "Wanneer systemen falen, wie draagt dan de last?",
    },
  ],
};
