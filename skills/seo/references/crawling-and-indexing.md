# Crawling, indexing, and URL controls

Source entries: **01-03, 25-30, 43, 47, 53**.

## Choose the control for the goal

| Goal | Appropriate mechanism | Key limitation |
| --- | --- | --- |
| Keep private content private | Server-side authentication/authorization | robots.txt and noindex are not security controls |
| Exclude an accessible HTML/PDF URL from Search | Crawlable robots meta or X-Robots-Tag `noindex` | Google must fetch it to see the rule |
| Reduce crawling of unwanted URL spaces | Appropriate robots.txt `Disallow` | The URL may still appear without crawled content |
| Consolidate substantially equivalent URLs | Consistent canonical preferences; permanent redirect when retiring variants | Google selects the canonical |
| Retire content with no suitable replacement | Actual `404` or `410` response | A `200` error message can be a soft 404 |
| Temporarily unavailable service | Correct temporary server-error handling | Persistent errors can eventually remove indexed URLs |
| Help discover preferred URLs | Internal links and sitemaps | Submission is not indexing |
| Urgent temporary search removal | Authorized Search Console removal plus lasting appropriate control | Removal tool alone is not permanent deletion |

Do not block a URL in robots.txt and rely on its unobserved noindex to remove it.
Do not use noindex as a canonical-selection or crawl-budget shortcut.

## robots.txt

Read the actual root file for the relevant protocol, host, and port. Verify the
specific crawler group, not just `User-agent: *`. Specific groups do not inherit
the wildcard group; duplicate matching groups combine. More specific matching
paths prevail; ties use the least restrictive rule.

Google supports `User-agent`, `Allow`, `Disallow`, and `Sitemap`; it does not
support `crawl-delay` or robots.txt `noindex`. Paths are case-sensitive. `*`
matches zero or more characters; `$` marks the end. Test intended allowed and
blocked examples before deploying a broad pattern.

Use UTF-8 plain text. The official specification limits parsing to 500 KiB.
Distinguish robots.txt error handling from ordinary page error handling:
a robots `4xx` other than `429` generally means no restrictions, while fetch
failures/server errors have documented cache/backoff behavior. Check that
behavior directly when diagnosing an outage.

Keep critical JS, CSS, images, and content API resources accessible if rendering
depends on them. Do not list sensitive hidden paths as a protection mechanism.

## Canonicalization

Confirm content equivalence before consolidation. Prefer a crawlable, indexable,
successful destination with the intended language and purpose.

Use one consistent absolute canonical URL in a valid HTML head, or an appropriate
HTTP `Link` header for non-HTML files. Provide self-referential canonicals on
preferred pages. Align redirects, sitemap URLs, internal links, locale annotations,
host/protocol choices, and declared canonicals.

Permanent redirects and canonical annotations are strong preferences; sitemaps
are weaker preferences. Do not use fragments, conflicting HTML/header targets,
robots.txt, removal tools, or noindex to choose a canonical.

Keep initial HTML and rendered canonicals consistent. If JavaScript is the only
way to add one, avoid a conflicting initial canonical and ensure exactly the
intended annotation is produced. Distinct pagination pages normally self-canonicalize;
translated main content is not just a duplicate of the source language.

Only indexed URL Inspection or comparable Google-provided evidence can establish
Google's stored selected canonical. A source-code tag is a declaration, not proof.

## Sitemaps

Use a maintained route/data inventory or the CMS's existing generator. Include
absolute preferred URLs meant for Search, not error pages, redirects, blocked or
noindex routes, or every tracking variation.

Each sitemap is limited to **50,000 URLs and 50 MB uncompressed**. Split larger
sets and use a sitemap index when appropriate. Use UTF-8, proper XML namespaces,
entity escaping, and accurate `lastmod` for substantive changes. Google ignores
`priority` and `changefreq`; do not generate artificial last-modified dates.

Check the served XML and referenced URLs, not just file generation. Submit through
authorized Search Console/API access or advertise the absolute sitemap URL in
robots.txt. Neither mechanism guarantees crawling or indexing.

## HTTP and routing

Use GET to verify actual responses; HEAD handling may differ. Inspect the complete
redirect chain and final response. Prefer direct server-side redirects to a
relevant destination for migrations/consolidation and avoid loops/chains.

| Response | Interpretation |
| --- | --- |
| `200` | Content may be processed; empty/error-like content can still be a soft 404 |
| `301`, `308` | Permanent redirect, strong target preference |
| `302`, `307` | Temporary redirect, weaker target preference |
| `304` | Reuse previously retrieved unchanged content |
| `404`, `410` | Missing/removed content; URLs are removed over time |
| `401`, `403` | Access failure, not a crawl-rate throttle |
| `429`, `5xx` | Overload/server-error signals; crawlers back off |

Do not redirect all removed URLs to the home page. Preserve useful replacements
where genuinely equivalent and return real missing statuses otherwise. Ensure
deep SPA routes load directly and missing routes do not all return the app shell.

## Crawl budget

Prioritize this for very large/rapidly changing inventories or evidenced discovery/
crawl bottlenecks, not every small site. It combines crawl capacity and crawl
demand and is not itself a ranking factor.

Use verified logs and crawl statistics to distinguish capacity problems from
low demand. Reduce infinite facets, session IDs, unbounded calendars, duplicate
inventory, soft 404s, and redirect chains; improve server health and caching.
Do not promise that blocking one section transfers its budget to another.

## Primary references and supplemental specifications

- https://developers.google.com/search/docs/crawling-indexing/robots/intro
- https://developers.google.com/crawling/docs/robots-txt/robots-txt-spec
- https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls
- https://developers.google.com/search/docs/crawling-indexing/sitemaps/build-sitemap
- https://developers.google.com/crawling/docs/troubleshooting/http-status-codes
- https://developers.google.com/crawling/docs/crawl-budget
