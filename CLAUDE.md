# todotik-web — Claude Code Context

Public company website, deployed to Cloudflare Pages.
Org-level standards and full project context: `TodoTik/todotik-ops` → `CLAUDE.md`.

---

## Purpose

Static website for todotik.com. Currently a placeholder; will become the public product/company site.
Deployed automatically via Cloudflare Pages on push to `main`.

---

## Key Files

```
index.html    # Main page (currently: "Coming soon" placeholder)
```

---

## Stack

- **Hosting:** Cloudflare Pages (auto-deploy from this repo's `main` branch)
- **Assets:** Large/binary assets served from `todotik-public` R2 bucket
- **DNS:** todotik.com — currently in AWS Route53 (legacy); migration to Cloudflare DNS planned when retiring AWS stack
- **Build step:** None currently (pure static HTML); add `build.command` in Pages settings if a framework is introduced

---

## Conventions

- Keep `main` always deployable — Cloudflare Pages deploys on every push
- Static assets (images, PDFs, logos) that are large or reused across contexts → `todotik-public` R2, not this repo
- If a framework is added (e.g. Astro, Next.js), update this CLAUDE.md with build/dev instructions
