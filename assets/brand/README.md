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
holds vector source only.

## Changing the logo

1. Update the SVG(s) in this folder.
2. Regenerate downstream icons: `cd ../../../todotik-identity && node scripts/generate-icons.mjs`.
3. Review the diff in `todotik-identity/src/assets/icons.ts`.
4. Commit the SVG change and the regenerated icons module together, in that order, with a commit message noting the logo change.
