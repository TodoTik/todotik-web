# TodoTik Corporate Website — Design Language

**Status:** 🟡 Draft
**Authoritative source:** `todotik-app` §7.7 (design language) and §7.7
"Institutional surface" subsection
**Brand assets:** `assets/brand/` in this repo; served from `todotik-public` R2

---

## Relationship to Other Repos

This document specifies how the TodoTik design language applies to the
corporate website (`todotik.com`).  The design language is defined once and
applied in three contexts:

| Context | Repo | Design language section |
|---------|------|------------------------|
| **Product UI** (card-based) | `todotik-app` §7.7 | Card-based, single-flow, progressive disclosure, lazy filling, smart defaults |
| **Identity screens** | `todotik-identity` I-9.4, I-10 | Quiet precision on auth/account screens; UX card catalogue |
| **Corporate website** | This document | Institutional surface — quiet frame, legal prose, storytelling |
| **Institutional pages within the app** | `todotik-app` §7.7 "Institutional surface" | Settings drawer model; compact footer; shared legal content |

The corporate website and the authenticated app's institutional pages share
the same visual register.  A user moving from `todotik.com/privacy` to the
in-app privacy page must perceive continuity, not a jarring style shift.

---

## Design Principles

### Quiet frame

Every page on the corporate website uses the quiet frame pattern: a
single-column prose container, a muted header, minimal navigation, and a
clear footer.  No cards, no complex grids, no interactive elevation.

```
┌──────────────────────────────────────────────────────┐
│  [Logo]                        [About] [Legal] [Lang]│  ← muted header
├──────────────────────────────────────────────────────┤
│                                                      │
│                                                      │
│     Prose content in a single column,                │
│     60–75 characters per line,                       │
│     generous vertical rhythm.                        │
│                                                      │
│                                                      │
├──────────────────────────────────────────────────────┤
│  © TodoTik SL · TodoTik Riyada Ltd                   │  ← institutional footer
│  Privacy · Terms · Cookies · Imprint                 │
│  todotik.eu · todotik.ae · todotik.uk                │
└──────────────────────────────────────────────────────┘
```

The quiet frame contrasts with the card-based product UI.  Where the app
is spacious and visual, the corporate website is text-dense and traditional.
This is the same distinction as Stripe's dashboard vs. Stripe's legal pages.

### Typography

**Font:** Inter / InterVariable — the same brand font used in the product
app (see `todotik-app` ADR 0003).  No secondary display font.

**Prose styling:**

| Property | Value |
|----------|-------|
| Measure (line length) | 60–75 characters (`max-w-prose` in Tailwind) |
| Body size | 16–18px (1rem–1.125rem) |
| Line height | 1.6–1.75 (generous for readability) |
| Heading weight | Semibold (600); body weight regular (400) |
| Heading scale | h1: 2rem, h2: 1.5rem, h3: 1.25rem |
| Paragraph spacing | 1.5em between paragraphs |
| List style | Standard disc/decimal; nested lists indented |

Use Tailwind's `@tailwindcss/typography` plugin (`prose` class) as the
baseline.  Override only where the brand requires it.

### Colour

The TodoTik brand palette is organised in two layers:

- **Structural** — page chrome (text, surface, border, background).  Each
  surface picks the variant its background calls for.
- **Semantic** — meaning-bearing roles applied across all TodoTik surfaces
  (product app, identity screens, corporate website).  Surfaces SHOULD bind
  page-level design tokens to these semantic names so the visual signal of
  "this is a warning" or "this is a familiar value" is identical wherever it
  appears.

Role names describe **purpose**, never the colour value itself.  A role
called `accent` keeps its meaning if the brand cyan is ever re-tuned; a role
called `cyan` would have to be renamed.

#### Structural roles

| Role | Light | Dark | Usage |
|------|-------|------|-------|
| Primary text | `#1A1A2E` | `#E8E8EC` | Body text, headings |
| Secondary text | `#4A4A6A` | `#999999` | Captions, metadata, footer text |
| Background | `#FFFFFF` | `#1A1A2E` | Page background |
| Surface | `#F8F9FA` | `#252540` | Cards, callout boxes, alternating sections |
| Border | `#E5E7EB` | `#3A3A55` | Horizontal rules, section dividers, footer border |

#### Semantic roles

| Role | Light | Dark | Conveys |
|------|-------|------|---------|
| **Accent** | `#4CC4DC` | `#4CC4DC` | Brand identity — logo mark, links, focus, hover emphasis |
| **Accent secondary** | `#304050` | `#7C8A9E` | Logo wordmark, heading text alternative (the corporate website uses this in the header) |
| **Success** | `#43A047` | `#66BB6A` | Verified factors, completed actions, confirmations |
| **Caution** | `#E8A838` | `#F0C869` | Recoverable issues, soft warnings — *something might be wrong, proceed carefully*; orange-leaning amber, distinct from attention and familiarity |
| **Attention** | `#A87F00` | `#FFD93D` | "Needs action" / "needs attention" — gold; signals that the user is being prompted to do something **without** implying anything is wrong.  Light-scheme value chosen for legibility on white (≈3.7:1 contrast, large-text AA); dark-scheme value is vivid glow |
| **Danger** | `#C44444` | `#E57373` | Destructive operations, errors, irrecoverable failures |
| **Info** | `#4A6FA5` | `#7B9FCF` | Neutral informational notices — distinct from secondary text; use only when the visual signal "this is information" carries weight |
| **Familiarity** | `#E6A94D` | `#E6B870` | Recognised entities, duplicates, déjà vu — desaturated "old paper" amber |

##### How surfaces apply these

Surface stylesheets MAY define page-level design tokens (e.g. a card's
verified-state border colour, a button's hover ring) — those are page-design
names, not brand roles.  Their **values** SHOULD be sourced from semantic
roles wherever the meaning matches:

```css
/* Page-level design token, value comes from a semantic role */
--card-recognised-border: var(--familiar);
--check-color:            var(--success);
.acct-badge.warn          { color: var(--caution); }
```

The brand guideline does not need a "success border" or "verified card
fill" role — those are surface-specific applications.  The brand guideline
publishes the **palette**; surfaces decide how to spend it.

##### Naming and provenance

- Add new semantic roles only when an existing role can't carry the meaning.
  "Highlight" and "needs attention" share `--attention`; "warning" and
  "caution" share `--caution`; recognition and duplication share
  `--familiar`.
- Light/dark pairs are mandatory for every semantic role.  The pair
  preserves the same perceived saturation against each background, not the
  same hex.
- Hexes here are the canonical reference; surface stylesheets MUST cite
  this section when they define their CSS-variable defaults.

#### Corporate website subset

The corporate website is light-only and uses a restrained subset of the
brand palette: structural roles plus `accent`, `accent secondary`, and a
flat decoration philosophy (no gradients, no shadows, no elevation).  Links
use the brand accent; visited links use a darker shade.  Interactive states
(hover, focus) are subtle — underline weight change or opacity shift, never
colour animation.

The full semantic palette is intended primarily for the product app and
identity screens, where status indication (success, caution, attention,
danger) is part of the user task.

### Brand Identity

The logo appears once in the header — either the combined lockup
(`logo-with-text.svg`) on desktop or the mark alone (`logo.svg`) on mobile.
The logo is not repeated in content areas.

Brand colours appear in the logo and in functional UI (links, focused
inputs).  They do not appear as decorative backgrounds, borders, or section
highlights.  The corporate website earns trust through restraint, not through
brand saturation.

### No Animation

No CSS transitions, no scroll animations, no hover effects beyond standard
interactive states (underline, opacity).  Pages load and display immediately.
Motion is reserved for the product UI; the corporate website is still.

---

## Page Types

### Landing page (`/`)

The entry point for todotik.com.  Bridges marketing and institutional:

- Hero: one-sentence value proposition, product screenshot or illustration
- Brief feature highlights (may use a restrained card pattern — flat, no
  shadows, no interaction)
- Call to action: "Open TodoTik" → sovereign redirect
- Footer (full)

The landing page is the only corporate page that may borrow the card
metaphor — and only visually, without interactive behaviour.

### About (`/about`)

Storytelling page bridging product and brand:

- Company narrative in prose
- Team member cards (if used): flat, name + role + photo, no hover/expand
- Milestone timeline (optional): vertical list, not an interactive timeline
- Entity information: TodoTik SL (Spain), TodoTik Riyada Ltd (UAE, RAK ICC)

The About page is the one institutional surface where card patterns are
permitted — sparingly, and only for layout grouping (team, milestones), not
for interaction.

### Legal pages (`/privacy`, `/terms`, `/cookies`, `/imprint`)

Legal prose style:

- Table of contents (anchor links) at the top
- Clear hierarchical headings (h2 for sections, h3 for subsections)
- Generous margins (quiet frame pattern)
- Last-updated date at the top
- Version history link (if applicable)
- Content authored as Markdown, rendered with `prose` styling

Legal pages are the canonical source of legal content.  The authenticated
app (`todotik-app`) and the identity service (`todotik-identity`) link to
these pages rather than duplicating content.  In-app views may embed
the content in an iframe or render the same Markdown source, but the
canonical URL is on `todotik.com`.

### Press / Media (`/press`)

If present:

- Press releases in reverse chronological order
- Logo and brand asset download links (→ R2 bucket)
- Contact information for press enquiries
- Same quiet frame layout

---

## Navigation

### Header

Minimal.  Desktop: logo (left), navigation links (right), locale switcher.
Mobile: logo (left), hamburger menu (right).

Navigation items:

| Item | Desktop | Mobile |
|------|---------|--------|
| About | Visible | In menu |
| Legal | Visible (dropdown: Privacy, Terms, Cookies, Imprint) | In menu |
| Open TodoTik | Visible (primary action, cyan accent) | In menu |
| Locale | Visible (compact selector) | In menu |

"Open TodoTik" links to the sovereign entry point — `todotik.com` redirect
logic (see `todotik-app` §3.1) determines the correct sovereign TLD.

### Footer

The institutional anchor.  Present on every page.  Full-width, low-contrast
background (light grey or white with border-top).

Content:

```
© 2026 TodoTik SL                                     [Logo mark]
TodoTik SL (Spain) · TodoTik Riyada Ltd (UAE, RAK ICC)

Privacy · Terms · Cookies · Imprint

todotik.eu · todotik.ae · todotik.uk · todotik.us
```

Footer uses secondary text colour and smaller type (14px / 0.875rem).  Links
are monochromatic — same secondary colour, underlined on hover.  No brand
cyan in the footer; it remains neutral and authoritative.

---

## Responsive Behaviour

The corporate website follows a content-first responsive approach:

| Breakpoint | Layout |
|------------|--------|
| < 640px (mobile) | Single column, full-width prose, hamburger nav, stacked footer |
| 640–1024px (tablet) | Single column, prose with side margins, inline nav |
| > 1024px (desktop) | Single column centred (max-w-3xl), full nav, horizontal footer |

No multi-column layouts.  The single-column prose container scales through
margin adjustment, not grid restructuring.

---

## Accessibility

WCAG 2.1 Level AA — same baseline as the product app (`todotik-app` §6.5,
`todotik-identity` I-9.3).

Corporate-specific requirements:

- **Contrast:** All text meets 4.5:1 against its background.  The
  low-contrast footer text (secondary colour on light grey) must be verified.
- **Link identification:** Links in prose must be distinguishable by more
  than colour alone (underline default).
- **Heading hierarchy:** Legal pages must have correct heading nesting
  (no skipped levels).
- **Landmark regions:** `<header>`, `<main>`, `<footer>`, `<nav>` used
  correctly.  Legal page table of contents is a `<nav>` with
  `aria-label="Table of contents"`.
- **Language:** `<html lang="...">` set per-page from locale.

---

## Internationalisation

Same 34 locales as the product app (`todotik-identity` I-9.1).

- RTL layout support: `dir="rtl"` on `<html>` for Arabic, Hebrew, Persian.
  Logical CSS properties throughout (no physical `left`/`right`).
- Legal content: translated professionally (XLIFF interchange, per I-9.1.3).
  Legal translations are jurisdiction-sensitive — the EU privacy policy may
  differ from the UAE version.
- Locale switcher: shows native language names (e.g. "العربية" not "Arabic").

---

## Technical Stack

The corporate website currently has no framework (`todotik-web` CLAUDE.md).
When a framework is introduced, it should align with the platform decisions:

**Recommended:** Astro — static-first, Markdown content support, Tailwind
integration, Cloudflare Pages deployment, partial hydration for interactive
elements (locale switcher).  This was identified as a candidate in
`todotik-app` ADR 0003 context.

**Styling:** Tailwind CSS with `@tailwindcss/typography` plugin.  Same
utility class approach as the product app; shared design tokens (colours,
fonts, spacing) extracted into a shared Tailwind preset or CSS custom
properties.

**Brand assets:** SVGs in `assets/brand/`.  Raster exports and large assets
in `todotik-public` R2 bucket.

---

## Design Token Alignment

These tokens must be consistent across `todotik-web`, `todotik-app`, and
`todotik-identity`:

| Token | Value | Source |
|-------|-------|--------|
| `--brand-cyan` | `#4CC4DC` | `assets/brand/logo.svg` |
| `--brand-navy` | `#304050` | `assets/brand/logo-text.svg` |
| `--font-family` | `'Inter', 'InterVariable', system-ui, sans-serif` | ADR 0003 |
| `--prose-measure` | `65ch` | This document |
| `--prose-line-height` | `1.7` | This document |

When a shared Tailwind preset is created, it should live in a shared
package or be duplicated with a cross-reference comment.

---

## How the Two Design Languages Coexist

A user moves between the lively card-based product UI and the quieter
institutional pages within a single session.  The transition must feel
intentional — a tonal shift, not a broken experience.

### Side-by-side comparison

```
 PRODUCT SURFACE (card-based)          INSTITUTIONAL SURFACE (quiet frame)
 ──────────────────────────────        ──────────────────────────────
┌─────────────────────────────┐       ┌─────────────────────────────┐
│ ■ TodoTik        [+] [☰]   │       │ ■ TodoTik     About  Legal  │
├─────────────────────────────┤       ├─────────────────────────────┤
│                             │       │                             │
│  ┌─────────┐ ┌─────────┐   │       │   Privacy Policy             │
│  │ ░░░░░░░ │ │ ░░░░░░░ │   │       │   Last updated: 2026-03-20  │
│  │ Card  1 │ │ Card  2 │   │       │                             │
│  │ ░░░░░░░ │ │ ░░░░░░░ │   │       │   1. Introduction           │
│  │  [Act]  │ │  [Act]  │   │       │   2. Data we collect        │
│  └─────────┘ └─────────┘   │       │   3. How we use it          │
│                             │       │   4. Your rights            │
│  ┌─────────┐ ┌─────────┐   │       │                             │
│  │ ░░░░░░░ │ │ ░░░░░░░ │   │       │   ─────────────────         │
│  │ Card  3 │ │ Card  4 │   │       │                             │
│  │ ░░░░░░░ │ │ ░░░░░░░ │   │       │   1. Introduction           │
│  │  [Act]  │ │  [Act]  │   │       │                             │
│  └─────────┘ └─────────┘   │       │   TodoTik SL ("we", "us")   │
│                             │       │   operates the TodoTik      │
│  Shadows · Elevation        │       │   platform. This policy     │
│  Rounded corners · Colour   │       │   explains how we collect   │
│  Micro-interactions         │       │   and process your data.    │
│  Swipe · Tap · Expand       │       │                             │
│                             │       │   Flat · No shadows         │
│                             │       │   No animation · Dense text │
│                             │       │   Generous margins          │
├─────────────────────────────┤       ├─────────────────────────────┤
│ [Home] [Search] [+] [Mail]  │       │ © TodoTik SL                │
│           [More]            │       │ Privacy · Terms · Imprint   │
└─────────────────────────────┘       └─────────────────────────────┘
```

### Shared elements (continuity)

These elements are identical across both surfaces, providing continuity:

- **Logo:** Same mark, same position (top-left), same size
- **Font:** Inter / InterVariable throughout
- **Brand colours:** Cyan `#4CC4DC` for interactive elements (links, focused
  inputs); Navy `#304050` for headings
- **Footer links:** Same destinations (privacy, terms, etc.) regardless of
  surface
- **Locale switcher:** Same behaviour, same position
- **WCAG 2.1 AA:** Same accessibility baseline

### Distinguishing elements (tonal shift)

These elements differ, creating the visual register shift:

| Element | Product surface | Institutional surface |
|---------|----------------|----------------------|
| **Layout** | Multi-column card grid | Single-column prose |
| **Containers** | Cards with shadow, rounded corners, elevation | No containers; text flows directly |
| **Typography** | Short labels, large type, bold headings | Long prose, regular weight, size hierarchy |
| **Colour density** | Cyan accents, coloured status badges, icons | Near-monochrome; cyan only on links |
| **Whitespace** | Between and within cards (visual drama) | Between paragraphs (readability) |
| **Interaction** | Swipe, tap, expand, micro-animations | Click links, scroll; nothing else |
| **Navigation** | Tab bar (mobile), sidebar (desktop) | Minimal header links + footer |

### Transition points

Users encounter institutional pages from specific touchpoints:

| From | To | Transition |
|------|----|------------|
| Registration form (identity) | Terms / Privacy | Link opens quiet frame page (in-app or todotik.com) |
| Settings tab (app) | Legal section | List/disclosure nav → quiet frame page |
| Footer link (any surface) | Legal page | Direct navigation to todotik.com |
| Error state (identity) | Help / support | Link opens quiet frame help content |
| About (app settings) | About page | Quiet frame with optional card-style team section |

The transition is never jarring because the shared elements (logo, font,
colours, accessibility) maintain continuity while the layout and density
shift signals the change in context.

---

## Cross-References

| Topic | Location |
|-------|----------|
| Platform design language (card-based, progressive disclosure) | `todotik-app` §7.7 |
| Institutional surface definition | `todotik-app` §7.7 "Institutional surface" |
| Identity screen design alignment | `todotik-identity` I-9.4 |
| Identity UX card catalogue | `todotik-identity` I-10 |
| Component stack (React, shadcn/ui, Tailwind) | `todotik-app` ADR 0003 |
| i18n, RTL, autofill requirements | `todotik-identity` I-9 |
| Brand assets | `todotik-web` `assets/brand/` |
| Accessibility baseline | `todotik-app` §6.5, `todotik-identity` I-9.3 |
| Client upgrade safety | `todotik-app` §7.10 |
| Sovereign TLD and DNS strategy | `todotik-app` §3.1.1 |
