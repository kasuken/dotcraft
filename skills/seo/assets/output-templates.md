# SEO output templates

Choose the smallest format that fits the task. Replace bracketed placeholders
with actual evidence or explicitly mark the item unknown. Never treat a
placeholder as a fact.

## Audit / diagnosis

**Scope:** [URLs/templates/files examined, sample size, market, date].
**Evidence available:** [site responses, code, reports, exports, browser traces].
**Limits:** [not tested, inaccessible data, snapshot-only guidance].

**Main conclusion:** [supported result, not a promised ranking gain].

| Priority | Finding / affected scope | Evidence and source | Fix | Verification | Effort | Confidence |
| --- | --- | --- | --- | --- | --- | --- |
| [P0-P3] | [URL/template/file and observed issue] | [response/report/file:line; source URL or source ID] | [specific action] | [reproducible acceptance check] | [estimate] | [confirmed/high/medium/low] |

**Hypotheses needing evidence:** [hypothesis, missing evidence, discriminating test].
**Monitoring:** [technical baseline, deployment/change date, later reporting window].

## Implementation handoff

**Changed:** [files/mechanism and behavior].
**Preserved:** [public URLs, restrictions, user functionality, intentional exclusions].
**Verification:** [actual checks and observed outcomes].
**Not yet verified:** [live deployment, Google reprocessing, unavailable metrics].
**Risk/rollback:** [only where needed].

Use this format to describe work actually performed, not planned work as complete.

## Content brief

**Audience and intent:** [who, task, locale, likely intent and its evidence].
**Primary question:** [what the page must answer].
**Page decision:** [update existing URL or proposed new page, with rationale].
**Original contribution:** [research, experience, examples, measurement, or tool].
**Evidence needed:** [claims, sources, first-hand work, qualified review].
**Proposed title and summary:** [truthful draft, not guaranteed SERP text].
**Outline:** [sections supporting user tasks, no arbitrary word-count quota].
**Internal links:** [existing relevant destinations and suggested natural anchors].
**Trust/disclosures:** [responsible creator, methods, incentives, automation if relevant].
**Acceptance:** [facts verified, task answered, no fabricated evidence or filler].

## Migration / indexing-control change

**Goal and authorization:** [move/consolidate/restrict/remove; confirmed permission].
**URL map:** [old URL, new URL or intended status/control, relevance of replacement].
**Dependencies:** [routing, canonical, links, sitemap, locale clusters, metadata].
**Acceptance:** [GET status/redirect, final content, control visibility, served output].
**Rollback and monitoring:** [restore mechanism, post-change sample, report timing].

Avoid a blanket home-page redirect or unexplained site-wide noindex/disallow.
