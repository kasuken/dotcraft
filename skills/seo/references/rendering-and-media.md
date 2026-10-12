# JavaScript rendering, links, images, and video

Source entries: **43-48**, with technical context from **01, 26, 29**.

## JavaScript diagnosis

Google crawls, renders with Chromium, and indexes the rendered content where
eligible. All eligible `200` pages may be queued for rendering; do not assume
SSR pages bypass it or describe a rigid, guaranteed "two-wave" timetable.

Compare a direct initial HTTP response with the rendered page and, where
authorized, Google's URL Inspection/Rich Results Test rendering.

Check:

- Main content, metadata, and actual links are present and correct.
- Direct deep-route visits work without prior client navigation.
- Missing/error routes have meaningful server statuses, not an empty `200` shell.
- Critical scripts, styles, content APIs, images, and embeds are accessible.
- Content does not require permissions, a preceding session, stored cookies,
  local/session storage, clicks, or scrolling to become discoverable.
- Errors, hydration, resource caching, unsupported APIs, and data fetching do not
  remove or replace important content.

Googlebot does not grant camera/geolocation permissions or preserve browsing
state between page loads. Content delivered solely over WebSocket/WebRTC needs
a suitable HTTP-accessible path. JS error analytics alone is not a complete
record of Google's rendering.

Do not serve initial `noindex` and rely on JS to remove it; rendering may be
skipped. Keep titles/canonicals consistent, avoid duplicate conflicting tags,
and use content-fingerprinted assets where stale rendering resources are an issue.

Prefer SSR/SSG or reliable equivalent content delivery when appropriate to the
existing architecture. Do not prescribe a wholesale framework rewrite before
proving the failure. Do not introduce bot-only deceptive prerendering.

## Link architecture

Use real `<a href="...">` destinations that resolve to crawlable HTTP URLs.
Client routers can intercept navigation while retaining a genuine href.
Click handlers, `routerLink` alone, empty anchors, and `javascript:` URLs are
not dependable discovery links.

Use descriptive, concise anchor text with useful surrounding context. Important
pages should have at least one link from another relevant page; use sensible
category/detail and related-content paths to avoid orphaning.

Use History API routes instead of fragments for distinct page content. In-page
anchors remain fine for navigation within the same page. Do not enforce a magical
link count or force exact-match keywords into every anchor.

## Images

Use `<img src>` with a real fallback source, including inside `picture` or with
`srcset`. CSS background images may be decorative, but should not be the sole
method of making important images discoverable in Google Images.

Use appropriate compression/format, responsive delivery, and dimensions. Keep
important image URLs stable and accessible, including CDN-hosted images.
Use relevant filenames, placement, captions, and context-sensitive alt text.
Decorative images can use empty alt text according to accessibility guidance;
do not keyword-stuff or fabricate what an image shows.

Select a representative high-quality preview image via appropriate schema or
`og:image` when useful. An image sitemap can help discovery. Match images and
metadata to the actual page rather than a generic logo on every article.

## Video

Distinguish:

| URL | Meaning |
| --- | --- |
| Watch-page URL | Page where the user watches the video |
| `embedUrl` | Player URL |
| `contentUrl` | Actual video-file/stream bytes |
| `thumbnailUrl` | Stable representative image |

For video features, evaluate a dedicated, indexed watch page where watching one
video is the primary purpose. A complementary video on an article/product page
does not automatically make it a watch page. Indexed page status does not
guarantee video indexing.

Ensure a discoverable video container without required clicks, an unobscured
video, stable accessible thumbnail, consistent metadata, and enough host/CDN
capacity. Use genuine VideoObject fields and video sitemaps where applicable.
Check current property requirements before implementation.

Actual video bytes must be fetchable for features that require them, such as
previews and key moments. Verify URL/thumbnail access rather than substituting
the page URL into `contentUrl`. Use valid expiration/region controls only when
needed; accidental past expiration dates can suppress an available video.

For third-party embeds, review both the user's watch page and host constraints.
Do not promise that the embedding page will outrank or replace the platform.
Use Video Indexing and applicable enhancement/performance reports for validation.

## Primary references

- https://developers.google.com/search/docs/crawling-indexing/javascript/javascript-seo-basics
- https://developers.google.com/search/docs/crawling-indexing/javascript/fix-search-javascript
- https://developers.google.com/search/docs/crawling-indexing/links-crawlable
- https://developers.google.com/search/docs/appearance/google-images
- https://developers.google.com/search/docs/appearance/video
- https://developers.google.com/search/docs/appearance/structured-data/video
