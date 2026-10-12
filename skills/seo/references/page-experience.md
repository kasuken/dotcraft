# Page experience and performance

Source entries: **31-36**.

## Measure before prescribing

Use real-user data from CrUX, Search Console, or authorized RUM to evaluate Core
Web Vitals. Use lab traces to reproduce and diagnose problems, not to substitute
for field results. Identify the URL/template, device class, time window, source,
and URL-level versus origin-level scope.

| Metric | Good | Needs improvement | Poor |
| --- | --- | --- | --- |
| LCP | <= 2.5 s | > 2.5 to 4 s | > 4 s |
| INP | <= 200 ms | > 200 to 500 ms | > 500 ms |
| CLS | <= 0.1 | > 0.1 to 0.25 | > 0.25 |

Assess the **75th percentile of field page visits**, separately for mobile and
desktop, with all three metrics meeting their good thresholds. Lack of field
data is unknown, not a pass. INP may be absent if no qualifying interaction occurs.

INP replaced FID as a Core Web Vital in 2024. A load-only Lighthouse test cannot
measure real user INP. Its Total Blocking Time is a diagnostic proxy, not the
same metric. Lab CLS may miss shifts that happen after page load.

Metric definitions evolve; verify current documentation before asserting that
old reports and new measurements are directly comparable.

## Diagnose each metric

### LCP: loading

Identify the actual largest contentful element rather than assuming the hero
image is responsible. LCP includes navigation/connection/server delays in the
field and is not `DOMContentLoaded` or the window load event.

Separate server response, resource discovery, transfer, and render delays.
Depending on the evidence, improve caching/TTFB, image encoding and responsive
delivery, discoverability of the critical resource, render-blocking styles/scripts,
or fonts. Do not lazy-load the observed above-the-fold LCP image. Use targeted
priority/preload changes only when the trace supports them; overpreloading competes
with other critical resources.

### INP: responsiveness

Observe representative clicks, taps, and keyboard interactions throughout the
visit, including during loading. Ordinary scroll and hover do not themselves
count as INP interactions.

Break a slow interaction into input delay, processing time, and presentation
delay. Use a trace to locate long tasks, excessive handlers, synchronous work,
layout thrashing, heavy DOM updates, or third-party scripts. Reduce unnecessary
work, split/yield appropriate tasks, and display prompt visual feedback.
Do not optimize only the first input or mistake network completion time for INP.

### CLS: stability

Locate unexpected moving elements in real user flows: late images, ads, embeds,
font changes, banners, and asynchronously inserted content. CLS uses the largest
session-window burst, not the total sum over a page's lifetime.

Reserve media/ad space, provide dimensions or aspect ratios, stabilize font
metrics where possible, and avoid injecting content above existing content
without space. Use transforms for suitable animation while respecting reduced
motion. Check delayed shifts after load, not just the initial viewport.

## Holistic experience

Check mobile readability, usable controls, clear main content, intrusive dialogs,
and distracting ads. Provide HTTPS with a valid matching certificate and secure
resources. For HTTP-to-HTTPS changes, align redirects, canonical URLs, links,
sitemaps, and locale annotations; adopt HSTS only after understanding its scope.

The supplied current page-experience guide says Core Web Vitals are used in ranking;
it does not make every UX recommendation a standalone ranking factor. A good
experience cannot compensate for irrelevant or unreliable content, and a perfect
Lighthouse score is not a ranking guarantee.

## Validation

Reproduce the identified issue and repeat the same trace/flow after the change.
Check other affected templates and states for regressions. Later compare field
data after its reporting window updates; do not claim immediate CrUX recovery
from a single faster local test.

## Primary references

- https://developers.google.com/search/docs/appearance/page-experience
- https://web.dev/articles/vitals
- https://web.dev/articles/inp
- https://web.dev/articles/lcp
- https://web.dev/articles/cls
- https://web.dev/articles/why-https-matters
