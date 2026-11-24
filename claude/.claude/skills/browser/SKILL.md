---
name: browser
description: Token-lean browser automation. Use before any web page work with Claude in Chrome, Playwright or preview tools: reading page text, clicking, screenshots, canvas/Flutter apps.
---

# Browser Automation (Claude in Chrome, Playwright, preview)

Screenshots are the most expensive way to see a page. Escalate cheapest-first and stop at the first step that works.

## Reading a page — cheapest first

1. `get_page_text` — plain article/text.
2. `javascript_tool` returning only what is needed, e.g. `document.body.innerText.slice(0, 3000)` or a `.map()` over specific selectors.
3. `find` with a precise query, or `read_page` with `filter: "interactive"` and a small `depth`/`max_chars`.
4. Screenshot with `scale: 0.5` (or `zoom` on a region). Full-scale only to read fine print.

Canvas apps (Flutter web: `flt-glass-pane` / `flutter-view`; no `innerText`):
- Try enabling semantics: click `flt-semantics-placeholder`, then read `flt-semantics` aria-labels.
- If content still missing, check `read_network_requests` for the JSON API behind the page before falling back to scaled screenshots.

## Acting

- MUST group navigate/click/type/screenshot sequences in one `browser_batch`.
- MUST NOT screenshot after every action; screenshot only to locate an element or verify an outcome.
- SHOULD click by `ref` from `find`/`read_page` instead of coordinates from a screenshot.
- MUST NOT open `chrome://` pages; the extension refuses them.
