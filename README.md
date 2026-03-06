# todotik-web

Public company website source, hosted on **Cloudflare Pages**.

## Cloudflare Pages Setup

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com) → Pages
2. Create new project → Connect to Git → Select `TodoTik/todotik-web`
3. Build settings:
   - Build command: *(none — static site)*
   - Output directory: `/`
4. Deploy

Static assets served from `todotik-public` R2 bucket where needed.
