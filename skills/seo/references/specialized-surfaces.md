# International sites, ecommerce, Discover, and AI Search

Source entries: **39, 49-52**, with context from **26, 29, 40-41, 45-46**.

## International SEO

Separate language and country targeting. Prefer stable locale-specific URLs
and explicit links that let users choose a language/region. Do not rely solely
on cookies, geolocation, or automatic browser-language redirects; Googlebot
may not discover those variations and typically sends no Accept-Language header.

Translate main content meaningfully, not just navigation. Keep visible language,
title, navigation, currency, and appropriate local details coherent. HTML `lang`
is valuable for accessibility but is not Google's language-detection mechanism.

For hreflang:

1. Group genuine equivalent localized pages; do not point every alternate to a
   locale home page irrespective of the content.
2. Use valid language/optional region codes, fully qualified URLs, self references,
   and reciprocal return annotations.
3. Include an appropriate generic language option and `x-default` fallback where
   useful. `x-default` is not a required ranking enhancement.
4. Choose a maintainable implementation: HTML head, HTTP headers, or sitemap.
5. Verify destination status, accessibility, language, and canonical consistency
   across the group, not just annotation syntax.

Preserve distinct translated content instead of canonicalizing all languages to
one. For substantially duplicate same-language regional URLs, evaluate appropriate
canonical preferences with hreflang rather than applying one universal rule.

## Ecommerce

Source 50 is an index of ecommerce guides, not a complete specification of facets,
stock management, or pagination. Consult the relevant guide before large changes.

Build crawlable category-to-product paths; a site search form alone is insufficient.
Keep pages useful for buyers with genuine specifications, price, availability,
images, support, shipping, and return information.

Differentiate commercial category intent from individual product and editorial
review intent. Avoid generating unlimited low-value facet combinations.
Decide deliberately which filtered landing pages offer unique value, and use
the appropriate crawl/index/consolidation controls for the rest.

For pagination/infinite scroll, provide unique directly loadable page URLs and
sequential real links. Distinct pagination pages self-canonicalize, not all to
page one. Buttons and scroll events alone are not reliable discovery.

Keep structured data and authorized Merchant Center feeds aligned with actual
offers and variants. Choose Product snippets versus merchant listings according
to whether users can purchase on the page.

For stock changes, preserve useful temporarily unavailable pages when appropriate
and show truthful availability. For permanently removed products, assess whether
there is a genuinely suitable replacement or retained informational purpose
before redirecting, retiring, or noindexing. Do not mass-remove URLs based solely
on a temporary stock flag.

## Discover

Indexed policy-compliant content can be eligible without special schema or tags.
Eligibility does not guarantee appearance. Older content can be useful; publishing
more or changing dates is not a guarantee of feed traffic.

Use accurate, compelling headlines and genuinely useful stories/insights rather
than clickbait or withheld information. Choose relevant high-quality lead images.
The supplied guide recommends at least 1200 px width, more than 300,000 total
pixels, and a suitable landscape/16:9 crop. Permit large previews with
`max-image-preview:large` where authorized and select representative metadata.

Do not apply preview settings that contradict an intentional content restriction.
Monitor the Discover report separately where available. Treat volatile Discover
traffic as supplemental, not a dependable keyword-demand forecast.

## AI-generated content versus AI Search visibility

These are different questions. AI assistance does not automatically violate
Search policies. The content still needs originality, usefulness, accuracy,
appropriate responsibility, and protection against scaled manipulation.

For supporting links in Google AI Overviews and AI Mode, the official AI-features
guide says a page must be indexed and eligible to appear in Search with a snippet.
No additional technical requirement or special schema is specified. Apply the
same crawlability, discoverability, content, experience, and data-consistency
fundamentals.

Explain complex topics with clear useful subanswers and evidence where relevant,
without inventing an "AI citation score," guaranteed citation technique, or special
markup requirement. Query fan-out is a description of these experiences, not
a reason to mass-generate near-duplicate pages.

Googlebot and Search preview/indexing controls govern Search use. Google-Extended
relates to specified other AI uses; blocking it is not a control for AI Overviews
in Search. `nosnippet`, `data-nosnippet`, `max-snippet`, and `noindex` have different
effects; confirm the user's goal and explain tradeoffs before changing them.

The supplied documentation history says `llms.txt` does not improve Google Search
visibility/rankings. Do not promise Google AI inclusion from adding it.

AI-feature traffic is reported within Search Console's Web search totals under
the official guide. Do not invent a separate AI-only measurement from a general
export. Combine appropriate authorized analytics with the documented reporting
to assess meaningful visits and conversions.

## Primary references and supplemental specifications

- https://developers.google.com/search/docs/specialty/international/managing-multi-regional-sites
- https://developers.google.com/search/docs/specialty/international/localized-versions
- https://developers.google.com/search/docs/specialty/ecommerce
- https://developers.google.com/search/docs/specialty/ecommerce/pagination-and-incremental-page-loading
- https://developers.google.com/search/docs/appearance/google-discover
- https://developers.google.com/search/docs/appearance/ai-features
- https://developers.google.com/search/blog/2023/02/google-search-and-ai-content
