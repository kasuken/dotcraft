# Search fundamentals

Source entries: **01-05, 19**. These recommendations are for organic Google
Search, not paid placement.

## Understand the pipeline

| Stage | What to establish | Useful evidence |
| --- | --- | --- |
| Discovery | Google can learn a URL exists | Internal links, external references, submitted sitemaps |
| Crawling | The crawler can retrieve the URL and resources | GET responses, robots rules, verified logs, crawl statistics |
| Rendering | Important content and links are available after rendering | Initial HTML, rendered DOM, resource failures, URL Inspection |
| Indexing | Content is suitable and consolidated into the index | Indexed URL Inspection, Page Indexing, declared/selected canonicals |
| Serving/ranking | The indexed page satisfies this query and context | Search Console query/page data and intent/content assessment |
| Appearance | The result can use a particular presentation | Feature documentation, markup, applicable reports |

Success at one stage does not guarantee success at the next. A `200` response,
a sitemap submission, or valid schema is not an indexing guarantee. An indexed
page is not guaranteed to appear for an arbitrary query.

Source 03 is a topic directory, not a disclosure of index partitions or internal
parsing implementation. Do not infer internal architecture from its catalog label.

## Minimum practical site assessment

1. Establish which public pages should be eligible for Search. Exclude private,
   transactional, staging, and intentionally restricted pages from that objective.
2. Confirm usable main content, intended successful responses, and absence of
   accidental crawl/indexing blocks.
3. Ensure important pages are reachable through real links from relevant pages.
   Use a sitemap to aid discovery when appropriate, not to replace navigation.
4. Provide descriptive page-specific titles, readable content, meaningful links,
   and useful images where they support the purpose.
5. Prefer a coherent hierarchy and stable, understandable URLs. Do not undertake
   a URL migration solely to insert keywords.
6. Compare the mobile experience with desktop where differences could affect
   content, metadata, media, or navigation.
7. Validate the actual site response and rendered page. Repository configuration
   cannot prove that production is deployed correctly.

Google may infer a reasonable canonical without explicit markup, but consistent
declared preferences help prevent accidental consolidation and confusing variants.
Ordinary duplicate URLs are an efficiency/consolidation issue, not an automatic
"duplicate content penalty."

## Crawlers

The crawler overview distinguishes common crawlers, special-case crawlers, and
user-triggered fetchers. Their purposes, robots behavior, caching, and limits can
differ. Apply the documentation for the specific crawler/product and file type.
Do not assume a generic crawler limit is Googlebot's current HTML limit.

When analyzing server logs, verify claimed Google requests using the documented
IP/rDNS procedure or official IP ranges. A user-agent can be spoofed. Do not use
client-side analytics alone to count Googlebot rendering activity.

## Avoid low-value optimization

Google does not use the meta keywords tag. It specifies no ideal content length,
heading count, keyword density, or number of internal links. Use headings
semantically for readers and accessibility without inventing an "exactly one H1"
ranking requirement. Domain names, URL keywords, and TLD choices should serve the
business and audience, not a promise of ranking advantage.

Prefer lasting improvements in usefulness, discoverability, and task completion.
Search changes may be reflected in hours, days, weeks, or months. State that timing
is uncertain and that results cannot be guaranteed.

## Primary references

- https://developers.google.com/search/docs/fundamentals/how-search-works
- https://developers.google.com/crawling/docs/crawlers-fetchers/overview-google-crawlers
- https://developers.google.com/search/docs/fundamentals/seo-starter-guide
- https://developers.google.com/search/docs/essentials
