# TodoTik brand assets

Canonical source of truth for the TodoTik logo. Anything downstream
(favicons, app icons, press kits, slide templates) is generated or
derived from these three SVGs.

Full specifications:

- Visual language, tone, type, colour usage — `../../docs/design-language.md`
- Icon rendering pipeline (favicon, apple-touch-icon, PWA) — `../../docs/icon-rendering.md`

## Files

| File | Contains | ViewBox | Fill colour(s) |
|------|----------|--------:|----------------|
| `logo.svg` | Mark only (TT glyph) | 223.56 × 270.47 | `#4cc4dc` |
| `logo-text.svg` | Wordmark only | 1007.54 × 223.81 | `#304050` |
| `logo-with-text.svg` | Full lockup (mark + wordmark) | 1312.23 × 288.28 | `#4cc4dc` + `#304050` |

All three are single-path, single-colour-per-element SVGs with no
embedded fonts, no filters, no scripts. They render identically in
every modern renderer and rasteriser.

## Colour tokens

| Token | Hex | Where it appears |
|-------|-----|------------------|
| Brand cyan | `#4cc4dc` | Mark, interactive accents, `theme-color` meta, dark-mode UI accents |
| Brand navy | `#304050` | Wordmark, heading text, institutional footer |

These two values are the only brand colours. Any other accent (status
badges, warnings, sandbox markers) is functional, not brand.

## Clear space

Reserve clear space equal to the height of the mark's inner cyan stroke
(approximately 20 % of the mark's overall height) on all four sides of
the logo. No text, rule, edge, image, or other mark may enter that
zone. When in doubt, use more space rather than less.

## Minimum size

| Asset | Minimum rendered width |
|-------|-----------------------|
| `logo.svg` (mark) | 16 px (favicon lower bound) |
| `logo-text.svg` (wordmark) | 120 px |
| `logo-with-text.svg` (lockup) | 160 px |

Below these sizes, use the mark alone or drop the logo entirely.

## Which asset to use

| Context | Asset |
|---------|-------|
| Website header, desktop | `logo-with-text.svg` |
| Website header, mobile (< 640 px) | `logo.svg` |
| App header, app icon, favicon, PWA icon | `logo.svg` (mark only) |
| Legal / institutional footer | `logo.svg` (muted, secondary text colour area) |
| Email signature, press release header | `logo-with-text.svg` |
| Social profile image | `logo.svg` over white or navy |
| Social share preview / OG image | `logo-with-text.svg` on white or navy background |

## Mark colour: prominent display vs chrome

Brand cyan is for the mark's **prominent displays** — where the mark is
presented as the brand rather than doing a job: splash and hero
placements, marketing surfaces, share images, an about screen.  There
the cyan is the point, and it is used as-is.

Where the mark appears as **chrome** — a navigation control, a title
bar, a footer — it takes the surrounding text colour (`currentColor` in
a web frontend) rather than cyan.  Chrome is furniture: the mark is
identifying the product, not advertising it, and matching the text it
sits beside is what keeps it legible on both light and dark themes
without a per-theme exception.  This is not a recolouring in the sense
the *Don't* list forbids: the mark is not being restyled to a new
palette, it is inheriting the one already governing that surface, the
same licence the institutional-footer row above has always carried.

Cyan measures 2.05:1 on white — a decorative value, adequate for a
logotype and inadequate for anything a user must read or click.  That
is why chrome does not lean on it: in chrome the control's own surface
supplies the affordance, never the glyph's colour.

## Do

- Scale proportionally. SVG is resolution-independent — use it wherever possible.
- Use the cyan-on-white or cyan-on-navy combinations in the SVGs as-is.
- Keep the lockup (`logo-with-text.svg`) as a single unit; do not re-space the mark and wordmark.
- Derive raster exports (PNG, JPG) through `todotik-identity/scripts/generate-icons.mjs` or the same Sharp + librsvg pipeline documented in `../../docs/icon-rendering.md` — gamma-correct, premultiplied, Lanczos3.

## Don't

- Do not recolour the mark or wordmark outside of the two brand tokens.
- Do not add drop shadows, gradients, outlines, strokes, 3-D effects, or animation.
- Do not rotate, shear, or distort the logo. No "playful" variants.
- Do not place the logo on busy photography, on colours that clash with cyan (orange, red), or on backgrounds below 4.5:1 contrast against cyan.
- Do not reconstruct the wordmark in Inter or any other font; use the SVG.
- Do not embed the logo as a raster where an SVG will do.
- Do not export new raster sizes through screenshot tools, ImageMagick, or browser canvas — use the documented pipeline (see `icon-rendering.md` §Rendering pipeline for the reasons).

## Raster and derivative assets

Large binaries (press-kit ZIPs, high-resolution PNG exports, background
illustrations) live in the `todotik-public` R2 bucket, not in this
repo. Generated favicons and PWA icons live in `todotik-identity`
`src/assets/icons.ts` (base64, bundled at build time). This folder
holds vector source plus the historical originals described below.

## Historical originals

Two subfolders hold preserved 2023-11 originals.  They are reference
material, not part of the canonical generation path.

`source-components/` — eight SVG components from 23 Nov 2023: the
three shape parts (`logochevron.svg`, `logocheckmark.svg`,
`logoparallelogram.svg`) and the five distinct letters of
T-O-D-O-T-I-K (`logotext_d.svg`, `logotext_i.svg`, `logotext_k.svg`,
`logotext_o.svg`, `logotext_t.svg`).  These are the source pieces
that were composited into the three top-level SVGs above.

`maskable-icons/` — two PWA maskable PNGs (192 × 192 and 512 × 512),
generated 2023-11-24.  Likely produced by
[maskable.app](https://maskable.app/) based on the PNG chunk
fingerprint: only `IHDR`, `sRGB`, `IDAT`, `IEND` chunks present (no
`Software`, `Author`, `Comment`, `tIME`, or `pHYs` tags); both files
share an identical creation timestamp; both sizes match maskable.app's
default exports.  This rules out Photoshop / Sketch / Figma /
Illustrator (would embed `Software` or `Adobe`), ImageMagick (would
embed `Software: ImageMagick`), Real Favicon Generator (would embed
`Comment`), and PWA Builder (would embed `tEXt` + `tIME`).  For new
maskable variants prefer the Sharp + librsvg pipeline in
`todotik-identity/scripts/generate-icons.mjs` (see
`../../docs/icon-rendering.md`); these PNGs are kept only as
historical originals.

## Where the mark lives

Copies of the logo are permitted where a repository cannot depend on
this folder, on one condition: **brand knows about every one of them.**
This register is that knowledge — the checklist a logo change walks, so
no copy is left showing yesterday's mark.  A copy that is not listed
here is a defect in this file, not in the copy; add the row.

Consuming a shared package is **not** a copy and earns no row: a
frontend that renders `<BrandMark />` from `@todotik/react-components`
follows this folder automatically.

| Location | Holds | Kept in step by |
|----------|-------|-----------------|
| `todotik-web/assets/brand/` (this folder) | The three canonical SVGs | It is the authority |
| `todotik-common` — `packages/react-components` `<BrandMark />` | The mark's path data, inline in a shared component | Update the component from `logo.svg`; every product frontend follows by version bump |
| `todotik.com/src/assets/logo.svg` | Byte-identical copy of `logo.svg` | Copy the file again |
| `todotik.com/public/favicon.ico`, `favicon16.png`, `favicon32.png` | Generated rasters | The Sharp + librsvg pipeline (`../../docs/icon-rendering.md`) |
| `todotik-identity/src/assets/icons.ts` | Generated favicons and PWA icons, base64, bundled at build | `node scripts/generate-icons.mjs` |
| `www.todotik.com/favicon.ico`, `favicon-16x16.png`, `favicon-32x32.png` | Generated rasters in a deployed-copy repo | Regenerate through the pipeline and redeploy — never hand-edited |

## Changing the logo

1. Update the SVG(s) in this folder.
2. Regenerate downstream icons: `cd ../../../todotik-identity && node scripts/generate-icons.mjs`.
3. Review the diff in `todotik-identity/src/assets/icons.ts`.
4. Walk every remaining row of *Where the mark lives* above and update it
   by the means its row names.
5. Commit the SVG change and the regenerated icons module together, in that order, with a commit message noting the logo change.  Each other repository's update is its own commit, referencing the same change.
