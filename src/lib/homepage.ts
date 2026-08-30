import {
  staticHomepageContent,
  type Dossier,
  type HomepageContent,
  type ImpactMetric,
  type Story,
} from "@/data/homepage";
import { getSupabaseClient } from "@/lib/supabase";

export async function getHomepageContent(): Promise<HomepageContent> {
  const supabase = getSupabaseClient();

  if (!supabase) {
    return staticHomepageContent;
  }

  const [storiesResult, metricsResult, dossiersResult] = await Promise.all([
    supabase
      .from("avera_stories")
      .select("number, category, title, excerpt, author, reading_time")
      .eq("is_published", true)
      .order("position")
      .limit(3),
    supabase
      .from("avera_impact_metrics")
      .select("value, label")
      .eq("is_published", true)
      .order("position")
      .limit(3),
    supabase
      .from("avera_dossiers")
      .select("title, summary")
      .eq("is_published", true)
      .order("position")
      .limit(3),
  ]);

  const stories: Story[] =
    !storiesResult.error && storiesResult.data.length === 3
      ? storiesResult.data.map((story) => ({
          number: story.number,
          category: story.category,
          title: story.title,
          excerpt: story.excerpt,
          author: story.author,
          time: story.reading_time,
        }))
      : staticHomepageContent.stories;

  const metrics: ImpactMetric[] =
    !metricsResult.error && metricsResult.data.length === 3
      ? metricsResult.data
      : staticHomepageContent.metrics;

  const dossiers: Dossier[] =
    !dossiersResult.error && dossiersResult.data.length === 3
      ? dossiersResult.data.map((dossier) => ({
          title: dossier.title,
          text: dossier.summary,
        }))
      : staticHomepageContent.dossiers;

  return { stories, metrics, dossiers };
}
