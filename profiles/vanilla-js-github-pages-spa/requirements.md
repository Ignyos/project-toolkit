# vanilla-js-github-pages-spa — Requirements

A correct implementation of this profile must guarantee:

1. **Consistent Version Identity.** Every publish and release uses a UTC timestamp (`yyyy-MM-dd-HH-mm`) applied consistently to asset query parameters (`?v=<timestamp>`), service worker cache names (`CACHE_NAME`), release diff filenames (`release/rel-<timestamp>.txt`), and Git tags.
2. **Dual-Lane Isolation & CNAME Safety.** Production (`main`) and dev (`dev`) lanes MUST publish to separate subdomains via distinct `CNAME` files. Never publish dev code or dev CNAME to the production site.
3. **Branch-Gated Live Release.** Full production releases are allowed ONLY on the `main` branch. Non-main branch runs must operate in test mode (no commit, tag, or push).
4. **Branch-Gated Dev Publish.** Dev publishing is allowed ONLY on the `dev` branch.
5. **Cache Invalidation.** Every dev publish and live release must invalidate client browser caches by updating asset query strings in HTML files and updating the Service Worker `CACHE_NAME`.
6. **Durable Diff Auditing.** Every live release must generate and check in a release diff file (`release/rel-<timestamp>.txt`) recording the exact code changes shipped in that release.
7. **Release Notes Evidence Gate.** Production releases require release notes generated from diff evidence and formatted according to `RELEASE_NOTES_STYLE.md`.
8. **Developer Preview Banner.** Non-production hosted environments must display a prominent visual banner (e.g. "DEVELOPER PREVIEW") to prevent operators or users from confusing dev with live production.
