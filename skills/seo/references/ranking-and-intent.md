# Ranking systems and search intent

Source entries: **04, 06-13, 18, 56**.

## Translate systems into useful work, not ranking recipes

Google combines many page-level and site-wide signals. Useful site-wide signals
do not make every page strong; weaker signals do not imply every page is weak.
Relevance, quality, usability, query meaning, location, language, and settings
interact differently for different searches.

| System/concept | Defensible implication | Avoid |
| --- | --- | --- |
| RankBrain and neural matching | Explain relevant concepts clearly, including natural audience terminology | Forced synonyms, entity quotas, alleged scoring formulas |
| BERT | Preserve context, relationships, negation, and precise meaning | Writing disjointed "keyword-ese" |
| Passage ranking | Organize sections around useful subquestions within coherent pages | Claiming passages are separate indexed URLs |
| Freshness | Keep time-sensitive facts accurate where the query requires freshness | Changing dates without substantive updates |
| Original content/reporting | Add first-hand research, evidence, and attribution | Republishing or paraphrasing others without added value |
| Reviews | Provide actual evaluation, comparisons, and decision-making evidence | Invented product tests or unsupported "best" claims |
| PageRank/link analysis | Make relevant pages discoverable through useful contextual links | Link hoarding, paid ranking links, universal equity calculations |
| Site diversity/deduplication | Expect result composition to vary | Creating subdomains to guarantee multiple top results |

The supplied ranking guide says MUM is used for specialized applications, not
general Search ranking. Its 2021 announcement describes capabilities and future
directions, not an optimization checklist.

The helpful-content system became part of core ranking in March 2024. Panda and
Penguin are historical names for systems integrated into successors/core systems.
Do not present these as separate current tools a site owner can directly tune.
Historical BERT coverage percentages are not current rollout statistics.

## Build a query-to-page map

For each important page or proposed topic, determine:

- Intended audience and the user's actual task or decision.
- Dominant intent: informational/Know, task/Do, navigational/Website, or
  Visit-in-Person/local; commercial research can combine these.
- Primary question and related subquestions, including ambiguity and exclusions.
- Locale, language, device, and whether recency is material.
- Existing page best suited to satisfy the task and any true content gap.
- Evidence required to answer accurately and an original contribution.

If live query or SERP data is unavailable, label intent hypotheses. Do not fabricate
search volume, competition, keyword difficulty, rankings, or competitor evidence.
Use supplied Search Console data to refine the map when available.

Consolidate substantially redundant pages when warranted by their actual content
and purpose; do not call every overlapping query "cannibalization." Different
intent, locale, product, or pagination states may deserve distinct URLs.

## Evaluate satisfaction separately from quality

A credible, well-written page can still fail to answer a query. A concise page
can fully satisfy a narrow need without being a comprehensive guide. Assess both
the trust/quality of the page and how directly it meets the intended user's need.

Do not force every page into a long-form format. Match structure and evidence to
the task: definitions, instructions, comparison tables, original measurements,
product specifications, or local details as applicable.

## Historical architectural material

The local PageRank dossier is generated, not the full patent. The random-surfer
model can explain why relationships between pages matter, but modern ranking
cannot be calculated from that summary. Do not treat its damping value, outbound
link division, TrustRank claims, or "reasonable surfer" description as verified
current Google implementation parameters.

## Primary references

- https://developers.google.com/search/docs/appearance/ranking-systems-guide
- https://www.google.com/search/howsearchworks/how-search-works/ranking-results/
- https://developers.google.com/search/docs/specialty/ecommerce/write-high-quality-reviews
