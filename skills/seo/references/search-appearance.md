# Search appearance: titles, snippets, and structured data

Source entries: **05, 37-42**. Important gaps: source 40 is a changelog, source
41 covers breadcrumbs rather than Organization, and source 42 covers titles
rather than a full snippet specification.

## Titles and descriptions

Give each important page a descriptive, concise, accurate title appropriate to
its primary content and language. Make the visible main heading distinct and
keep it consistent in meaning with the title. Avoid empty fragments, keyword
lists, repeated boilerplate, stale dates, and unsupported claims.

Google can generate title links from titles, headings, other prominent text,
Open Graph metadata, links, and other sources. A rewrite is not automatically
a penalty or a bug. Correct actual inconsistencies and let recrawling occur.

Write a page-specific meta description summarizing the genuine value and key
facts. Google may instead use relevant on-page text for a query-dependent snippet.
Treat suggested character counts as editorial heuristics, not Google's hard
ranking thresholds. Do not guarantee exact search-result text.

Use snippet/preview controls only when they serve the user's explicit goal.
Explain the impact on other appearances, including AI search eligibility.

## Structured-data decision procedure

1. Identify the real visible entity and page purpose.
2. Check Google's current supported feature and required/recommended properties.
   Schema.org validity is not the same as Google rich-result support.
3. Reuse the site's existing data and structured-data mechanism. Prefer maintainable
   JSON-LD when suitable; Google also supports valid Microdata and RDFa.
4. Serialize safely using the framework's established escaping/JSON mechanism.
   Keep data synchronized with visible content and the actual product/media.
5. Include accurate applicable fields only. Never invent ratings, stock, price,
   dates, authors, credentials, logos, affiliations, or policy details.
6. Check syntax, vocabulary, visible-content consistency, feature requirements,
   and deployed accessibility. Use Rich Results Test and relevant reports when
   the feature is supported.

Valid markup does not guarantee display, ranking improvements, Knowledge Panels,
Google News inclusion, or an increase in CTR. Case-study percentages are not
predictions for the user's site.

## Common types

| Type | Apply when | Important checks |
| --- | --- | --- |
| Article / NewsArticle / BlogPosting | Real editorial/article content | Accurate headline, bylines, applicable dates, representative accessible images |
| Product snippets | Product/editorial review pages suited to the feature | Current feature-specific requirements; genuine review and offer data |
| Merchant listings | Customers can buy the item on the page | Actual price/currency/stock, identifiers, variants, shipping/returns as applicable |
| Organization / appropriate subtype | Home/about page describing the real organization | Identity, real logo/contact data, relevant profiles and policies |
| BreadcrumbList | Actual navigational hierarchy/user path | At least two ListItems, ordered positions, names and valid destinations |
| VideoObject | Real discoverable embedded video | Correct video/player/thumbnail URLs and accurate metadata |
| QAPage / DiscussionForumPosting | Genuine applicable Q&A/discussion pages | Verify current feature requirements and content structure |

The supplied Article guide has **no required properties**; its documented fields
are recommended where applicable. Do not invent a 110-character headline cutoff
or claim Article markup is required for Top Stories. Include all actual authors
as separate entities rather than combining names into one field.

Breadcrumbs need not mechanically mirror a URL path. The last ListItem's `item`
can be omitted. The supplied guide describes breadcrumb presentation on desktop;
do not promise mobile breadcrumbs from an older example.

Organization is a separate guide. Use the most specific accurate subtype and
current requirements where a specialized feature applies, not fake `sameAs` links.

## FAQ retirement

The local FAQ source actually contains Google's documentation-update history.
It records FAQ rich results being discontinued from **May 7, 2026**, followed by
removal of the FAQ rich-result documentation in June 2026.

Do not recommend FAQPage markup as a current Google rich-result opportunity based
on the historical government/health restriction. Helpful FAQ content can remain
on the page; schema can serve other consumers without a Google display promise.
Q&A/discussion markup is a distinct subject and must be checked independently.

## Primary references and supplemental guidance

- https://developers.google.com/search/docs/appearance/title-link
- https://developers.google.com/search/docs/appearance/snippet
- https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data
- https://developers.google.com/search/docs/appearance/structured-data/search-gallery
- https://developers.google.com/search/docs/appearance/structured-data/article
- https://developers.google.com/search/docs/appearance/structured-data/product
- https://developers.google.com/search/docs/appearance/structured-data/organization
- https://developers.google.com/search/docs/appearance/structured-data/breadcrumb
- https://developers.google.com/search/updates
