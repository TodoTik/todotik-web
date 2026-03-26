# TodoTik Icon & Favicon Rendering Requirements

**Status:** ✅ Active
**Location:** `todotik-web/docs/icon-rendering.md`
**Related:** `docs/design-language.md` — brand colours, typography, asset locations
**Implementation:** `todotik-identity/scripts/generate-icons.mjs`

---

## Brand colours (reference)

| Token | Hex | Usage |
|-------|-----|-------|
| Brand cyan | `#4cc4dc` | Logo mark fill, theme colour, interactive accents |
| Brand navy | `#304050` | Logo wordmark, heading text |
| White | `#ffffff` | Apple touch icon background (iOS home screen) |

Source of truth: `assets/brand/logo.svg` (cyan mark), `assets/brand/logo-text.svg`
(navy wordmark), `assets/brand/logo-with-text.svg` (full lockup).

---

## Required icon artefacts

| File | Size | Background | Purpose |
|------|------|-----------|---------|
| `favicon.svg` | vector | transparent | Modern browsers (Chrome 80+, Firefox 41+, Safari 12+) |
| `favicon.ico` | 16 × 16 + 32 × 32 | transparent | Legacy browsers, OS taskbar/dock |
| `apple-touch-icon.png` | 180 × 180 | **white** | iOS home screen, Safari reader |
| `icon-192.png` | 192 × 192 | transparent | Android PWA, Chrome install prompt |
| `icon-512.png` | 512 × 512 | transparent | Android high-DPI, splash screen |

### Why white background for apple-touch-icon?

iOS clips the icon to a rounded super-ellipse and composites it over a coloured
background of its own choosing.  If the source icon is transparent, iOS fills the
void with black, which makes the cyan mark nearly invisible in dark mode and wrong
in light mode.  A white background produces a consistent, legible result at all
iOS display modes.  The same principle applies to any context where the rendering
environment controls the background and transparency is not honoured.

The other icons remain transparent so they compose correctly over any surface —
browser chrome, Android launcher, Windows taskbar — each of which supplies its own
background.

---

## Rendering pipeline

### Why these choices matter

A naïvely exported icon looks soft, dark-fringed, or muddy at small sizes for
two independent reasons:

1. **Resampling in the wrong colour space.**  Most image exporters operate on
   gamma-encoded sRGB values (`sRGB = linear^(1/2.2)` approximately).  Scaling down
   a bright object in gamma space makes it appear too dark because the average of
   two gamma values is not the same as the gamma of their linear average.  Correct
   downsampling works in linear light, then re-encodes to sRGB for storage.

2. **Straight (un-associated) alpha compositing.**  When a partially transparent
   edge pixel is stored as `(R, G, B, A)` where R/G/B are the icon colour, blending
   it over a background naïvely computes `dest = src_rgb * src_a + dst * (1 - src_a)`.
   If the stored R/G/B values are unrelated to the background, fringing occurs —
   typically a dark halo for icons on light backgrounds.  **Premultiplied alpha**
   stores `(R*A, G*A, B*A, A)` so the blend is always correct regardless of
   background.

### Required pipeline steps

```
SVG source
    │
    ▼
1. Vector rasterisation at 4× target size
   Tool:    librsvg ≥ 2.58 (via Sharp)
   Reason:  librsvg uses Cairo's anti-grain geometry rasteriser.  Running at 4×
            means more sub-pixel samples per output pixel → smoother curves.
   Setting: density=300 (DPI hint for librsvg's internal grid).
    │
    ▼
2. Optional: composite over background (apple-touch-icon only)
   Tool:    libvips composite, blend=over
   Reason:  Compositing at oversample resolution means the blend calculation has
            more samples, producing a cleaner edge where the mark meets the
            white background.  Compositing after downsampling would introduce
            fringing.
    │
    ▼
3. Lanczos3 downsample to target size, in linear light
   Tool:    libvips resize, kernel=lanczos3, fastShrinkOnLoad=false
   Reason:  Lanczos3 is the industry-standard resampling kernel for downscaling
            photographic and icon content.  It preserves sharpness better than
            bilinear or box filters.  fastShrinkOnLoad=false forces libvips
            through the full-quality pipeline rather than the fast integer
            shrink path.  libvips performs the resize in linear light
            automatically when the source is a standard PNG.
    │
    ▼
4. PNG output with maximum compression
   compressionLevel=9, adaptiveFiltering=true
   Reason:  Deterministic, lossless output.  adaptiveFiltering lets the encoder
            choose the best PNG filter per scanline, reducing file size by
            10–20% with no quality cost.
```

### Recommended toolchain

| Layer | Tool | Version | Why |
|-------|------|---------|-----|
| SVG rasteriser | librsvg | ≥ 2.58 | Cairo backend, precise Bézier, correct premultiplied alpha |
| Image processing | libvips | ≥ 8.15 | Linear-light pipeline, Lanczos3, premultiplied throughout |
| Node.js binding | Sharp | ≥ 0.33 | Bundles both; correct linear/gamma handling by default |
| ICO assembly | custom (see script) | — | PNG-in-ICO format; no legacy BMP needed |

**Do not use:**
- ImageMagick for downsampling (gamma handling inconsistent across versions)
- Canvas API / browser-based export (gamma correction varies by browser)
- Pillow/PIL default resize (bilinear, not Lanczos; straight alpha by default)
- Squoosh CLI (lossy by default; alpha handling lossy at low quality)

### Reference implementation

`todotik-identity/scripts/generate-icons.mjs` is the canonical implementation
of this pipeline.  It is the authoritative source for how icons are generated
across all TodoTik surfaces.

To regenerate all icons after a logo update:

```sh
cd todotik-identity
node scripts/generate-icons.mjs
# Review src/assets/icons.ts, commit both the updated SVG and the generated file.
```

The script reads from `../todotik-web/assets/brand/logo.svg` (relative to the
script location) and writes `src/assets/icons.ts` — a TypeScript module of
base64-encoded constants that is bundled into the Cloudflare Worker at build time.

---

## favicon.ico format

The `.ico` file uses **PNG-in-ICO** encoding, not the legacy BMP (DIB) encoding.
PNG-in-ICO has been supported by all major browsers since 2006 and all Windows
versions since Vista.  Using PNG rather than BMP:

- Preserves full 32-bit alpha (BMP alpha support in ICO is erratic)
- Is significantly smaller (PNG compression vs raw BMP)
- Is the format Chrome, Firefox, and Windows Explorer all prefer

The ICO contains two embedded PNGs: 16 × 16 and 32 × 32.  No 48 × 48 or
256 × 256 is included because:
- 48 × 48 is only needed for Windows legacy shell (pre-Vista)
- 256 × 256 is only useful when the `.ico` is used as a Windows application
  icon (not a web favicon); browsers never use it

---

## HTML head reference

Every page that should show the favicon must include exactly this head block:

```html
<meta name="theme-color" content="#4cc4dc" />
<link rel="icon" type="image/svg+xml" href="/favicon.svg" />
<link rel="icon" href="/favicon.ico" sizes="any" />
<link rel="apple-touch-icon" href="/apple-touch-icon.png" />
<link rel="manifest" href="/site.webmanifest" />
```

**Order matters:**
- SVG first — modern browsers stop here and use it
- ICO with `sizes="any"` — legacy fallback; the `sizes="any"` attribute
  signals to modern browsers that it is a fallback, not a preferred icon
- apple-touch-icon — Safari and iOS only use this; they ignore `<link rel="icon">`

`theme-color` sets the browser UI chrome colour on Android Chrome and
controls the title bar colour on macOS Safari in reader mode.  Use brand cyan.

---

## Serving strategy

**SVG** is served inline from the Worker response — it is 1.8 KB and changes
only when the logo changes.

**Raster artefacts** (ICO, PNG) are pre-generated and stored as base64 constants
in `src/assets/icons.ts`, bundled into the Worker at build time.  This avoids
a runtime R2 fetch for well-known paths where latency would be visible.  Total
bundle impact: ~60 KB base64, ~40 KB gzip.

If raster assets grow beyond ~150 KB gzip, move them to the `todotik-public`
R2 bucket and serve via a Worker fetch.  The `todotik-web` design-language doc
specifies R2 as the canonical home for large binary assets.

---

## When to regenerate

Regenerate icons whenever:

- `assets/brand/logo.svg` is modified (shape, colour, proportions)
- The brand cyan (`#4cc4dc`) changes
- A new platform requires a new icon size

Add `node scripts/generate-icons.mjs` to the `todotik-web` commit message
guidance for logo changes so downstream consumers are prompted to regenerate.

---

## Cross-references

| Topic | Location |
|-------|----------|
| Brand colours and typography | `todotik-web/docs/design-language.md` |
| Design token alignment | `todotik-web/docs/design-language.md` §Design Token Alignment |
| Institutional surface (quiet frame) | `todotik-web/docs/design-language.md` §Quiet frame |
| Icon generation script | `todotik-identity/scripts/generate-icons.mjs` |
| Generated icon constants | `todotik-identity/src/assets/icons.ts` |
| Static asset serving | `todotik-identity/src/routes/static.ts` |
| Security contact (per-sovereign) | `todotik-identity/wrangler.toml` → `SECURITY_CONTACT` |
