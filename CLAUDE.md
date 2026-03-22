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

## Design Language

The corporate website uses the **institutional surface** design language
defined in `todotik-app` §7.7.  This is the quiet, text-dense, trust-signalling
counterpart to the card-based product UI.

Full specification: [`docs/design-language.md`](docs/design-language.md)

Key principles: quiet frame (single-column prose), legal prose style,
restrained brand identity, no animation.  Same Inter font, same Tailwind
base, same 24 locales and RTL support as the product app.

## Sister Repos

| Repo | Relationship |
|------|-------------|
| `TodoTik/todotik-app` | Product app — card-based UX; §7.7 defines the platform design language including the institutional surface that this site implements |
| `TodoTik/todotik-identity` | Identity & trust service — I-9 (i18n, RTL, autofill), I-9.4 (institutional pages in auth context), I-10 (UX card catalogue) |
| `TodoTik/todotik-ops` | Infrastructure, deployment, operational context |

## Conventions

- Keep `main` always deployable — Cloudflare Pages deploys on every push
- Static assets (images, PDFs, logos) that are large or reused across contexts → `todotik-public` R2, not this repo
- If a framework is added (e.g. Astro, Next.js), update this CLAUDE.md with build/dev instructions
