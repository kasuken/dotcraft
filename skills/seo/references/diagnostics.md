# Diagnostics, measurement, and architectural claims

Source entries: **01, 17, 27-30, 53-56**.

## Search Console: use the right evidence

The supplied source 53 is an **About Search Console** overview, not the complete
Page Indexing or URL Inspection specification. Those reports need their own
current documentation and user-authorized data.

| Question | Appropriate evidence | Do not infer |
| --- | --- | --- |
| Was this URL indexed at the stored crawl? | Indexed URL Inspection | A successful live fetch proves current indexing |
| What does Google fetch/render now? | Live inspection, loaded resources and rendered HTML | The stored canonical/index has already updated |
| Which intended pages are excluded? | Page Indexing plus known URL inventory | Every excluded URL must be indexed |
| Are important URLs being crawled? | Crawl statistics and verified server logs | Client analytics counts all Googlebot activity |
| Did organic performance change? | Segmented performance data and relevant analytics | Aggregate clicks alone identify the cause |
| Is there a manual action? | Actual Manual Actions message/report | A traffic drop is a manual penalty |
| Is markup recognized/valid? | Feature-specific test/report and served page | Valid JSON guarantees rich display |

Check desired indexability before trying to "fix" every report state. Duplicates,
intentionally noindexed pages, and removed pages may be expected.

## Not-indexed investigation

1. Select affected examples and intended successful controls from the same template.
2. Check discovery, actual responses, robots/access, initial metadata, and rendering.
3. Compare declared and Google-selected canonicals if available.
4. Check sitemap/internal-link consistency, resource failures, duplication, and
   whether the page provides distinct useful content.
5. Use report dates and actual crawl timing; changes may not have been reprocessed.
6. State supported conclusions and the next discriminating check.

"Discovered - currently not indexed" and "Crawled - currently not indexed" are
states, not proof of a specific ranking penalty, quality defect, or server cause.
Do not repeatedly request indexing in place of fixing evidenced issues.

## Traffic-drop investigation

Establish whether the issue is a real Search decline or a reporting/analytics
change. Obtain comparison periods, impacted pages/queries, search types, devices,
countries, search appearances where available, and relevant site-change dates.

Separate changes in impressions, clicks, CTR, and average position. Check seasonality,
demand, query/page mix, site migrations, server/rendering/indexing changes,
manual actions, and changes to result presentation. Average position is an
aggregate, not a causal explanation; analytics engagement is not a revealed Google
ranking weight.

For suspected core-update effects:

1. Check the official Search Status Dashboard for rollout start and completion.
2. Wait at least a full week after completion before analyzing that comparison,
   as the supplied core-update guide recommends.
3. Compare a post-completion period with an appropriate period before the update;
   keep weekday, seasonal, device, country, and search-type effects in view.
4. Inspect sustained large drops and affected content objectively. Avoid drastic
   changes to already useful content over small position fluctuations.
5. Prefer durable improvements in quality/intent satisfaction. Deletion is a
   last resort for unsalvageable content, not the default recovery tactic.

Correlation with an update is not proof of a penalty or a particular system.
Improvements may take days to months to be recognized and have no guaranteed result.

## Before/after measurement

Record the baseline, change date, impacted sample, immediate technical acceptance
criteria, later reporting window, and meaningful business outcome. Avoid changing
many unrelated variables when testing a specific hypothesis.

Check discovery/indexing for intended URLs, performance by relevant segments,
actual conversions where authorized, and template-level regressions. Report
unavailable data explicitly. Never fabricate traffic, positions, index counts,
tool results, or revenue gains.

## Leaks, trial summaries, and patents

Sources 54-56 are generated dossiers in the local download script. The actual
leaked repository, court exhibits/testimony, and patent are not bundled.
Treat their assertions as leads for source verification, not primary evidence.

A field name such as `siteAuthority`, `goodClicks`, or `NavBoost` does not establish
current production use, causal weights, thresholds, or a manipulable recipe.
Public explanations can acknowledge aggregate interactions without validating
every definition of dwell time, click quality, Chrome tracking, or link decay.

Do not equate third-party DA/DR scores with a measurable Google score. Do not
recommend click bots, mandatory link velocity, deliberate pogo-sticking control,
or PageRank hoarding. A historical patent describes an invention, not proof that
the modern engine uses every listed mechanism.

If the user explicitly requests architectural research, identify the primary
document, date, context, and limits of the inference. Keep research separate from
actionable recommendations supported by site evidence and current policies.

## Primary references

- https://support.google.com/webmasters/answer/9128668
- https://support.google.com/webmasters/answer/7440203
- https://support.google.com/webmasters/answer/9012289
- https://developers.google.com/search/docs/appearance/core-updates
- https://status.search.google.com/
- https://developers.google.com/search/docs/appearance/ranking-systems-guide
