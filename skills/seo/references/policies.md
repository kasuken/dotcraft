# Search policies and safe optimization

Source entries: **19-24, 48, 52**, with quality context from **14**.

## Identify the behavior and evidence

Check for intentional manipulation or deception, not superficial similarities
alone. Google policies can affect ranking, eligibility, or specific surfaces
through automated systems or manual review. A manual action requires actual
Search Console evidence; a suspected risk is not a confirmed action.

Do not recommend:

- Cloaking or search-engine-only text intended to mislead users.
- Hidden text/links placed solely for ranking manipulation.
- Doorway pages that funnel similar queries through low-value intermediates.
- Paid links, private networks, automated placements, or exchanges for ranking credit.
- Low-value scaled content, copied feeds, synonym rewrites, or translated scraping.
- Expired-domain repurposing primarily to exploit old ranking signals.
- Third-party pages hosted mainly to exploit an established site's ranking signals.
- Click manipulation, automated Google queries without permission, deceptive
  functionality, browser-history trapping, or policy circumvention.

## Important legitimate cases

Accordions, tabs, accessible screen-reader text, and progressive disclosure are
not hidden-text abuse merely because some information is initially hidden.
Legitimate site moves, duplicate consolidation, and authenticated navigation
can use redirects. The relevant question is intent, content parity, and users'
reasonable expectations.

Paywalls can be legitimate when implemented according to Google's applicable
sampling and paywall guidance. Do not remove access controls or expose private
content to satisfy an SEO checklist. Do not deploy a bot-specific alternate site
as a shortcut for broken JavaScript rendering.

Not every sponsored page, freelancer article, UGC discussion, affiliate program,
or third-party section is abusive. Assess actual purpose, original value,
presentation, responsibility, and integration.

## Site reputation: snapshot and regional differences

The **October 2026 supplied policy text** differs from the 2024 announcement.
It describes editorial integration/responsibility factors and an August 2026
change in how the policy is applied for users in the EEA:

- Outside the EEA, relevant pages may be subject to a manual action.
- Within the EEA, affected portions may be categorized and ranked independently
  of the main domain rather than being subject to the same manual-action impact.
- The text describes notification, reconsideration, and possible mediation.

Verify the current policy, user's market, and actual notification before giving
remediation instructions. Do not reduce it to "all third-party content is banned"
or reuse a historical blanket rule about editorial oversight as current guidance.
Do not shift pages to new hosts simply to evade an action.

## Link qualification

Use `rel="sponsored"` for paid placements and affiliate compensation; `nofollow`
is also acceptable under the documentation. Use `ugc` for user-contributed links,
and `nofollow` when no more specific relationship applies and association is
unwanted. Multiple values can be combined.

Ordinary trustworthy editorial links need not be nofollowed. These attributes
do not guarantee that a destination cannot be discovered or crawled elsewhere.
Do not use internal nofollow "PageRank sculpting" instead of sensible navigation
and the appropriate crawling/indexing controls.

## Remediation

Document the observed behavior, affected scope, user impact, and applicable rule.
Prefer legitimate content and functionality fixes. For confirmed manual actions,
follow the named report's remediation and reconsideration procedure. If a private
report is unavailable, request an export or exact message rather than guessing.

## Primary references

- https://developers.google.com/search/docs/essentials/spam-policies
- https://developers.google.com/search/docs/crawling-indexing/qualify-outbound-links
- https://developers.google.com/search/blog/2023/02/google-search-and-ai-content
