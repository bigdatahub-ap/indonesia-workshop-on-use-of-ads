# Site for the 2026 Indonesia Workshop on Scanner Data

## Event summary

**Host Country**: Indonesia

**Organizers**:

-   UN Regional Hub on Big Data and Data Science for Asia and the Pacific

-   UN Task Team on Scanner Data

-   Politeknik Statistika STIS

-   BPS – Statistics Indonesia

**Dates**: 21 September – 2 October 2026

**Format**: Fully virtual, combining synchronous and asynchronous activities

**Working Language**: English

## Repository structure

```
├── data/                   # Placeholder for data used in the examples
│
├── notebooks/              # Placeholder for notebooks used in the examples
│
└── content/                # Event site content 
    ├── presentations/      # Store of presentations for each event
    ├── images/             # Folder to store images used for the site
    └── *.qmd               # Quarto files part of event site
```

## Deployment

The site is built and served with Docker. From the repository root:

```
docker compose up --build
```

This starts two containers:

-   `site` — renders the Quarto project and serves the static output with nginx (not published to the host directly).
-   `proxy` — an nginx reverse proxy (config in [nginx/proxy.conf](nginx/proxy.conf)) that publishes the site at [http://localhost:8080/material/workshop-on-scanner-data/](http://localhost:8080/material/workshop-on-scanner-data/), matching the production path `https://hub.bps.go.id/material/workshop-on-scanner-data`.

Run with `-d` to start in the background, and `docker compose down` to stop.

Quarto's HTML output only ever uses relative links, so the rendered site works under any path prefix without modification — the `proxy` service is just an example of the reverse-proxy configuration needed to host it that way in production:

-   Redirect the bare prefix (`/material/workshop-on-scanner-data`) to the trailing-slash form (`/material/workshop-on-scanner-data/`) **before** stripping the prefix, so the browser's URL keeps the prefix and relative links resolve correctly.
-   Strip the prefix when forwarding to the `site` container (`proxy_pass http://site:80/;`), since `site` itself serves from its own root.

If your production reverse proxy passes the `/material/workshop-on-scanner-data` prefix through unchanged instead of stripping it (e.g. a transparent path-based router), point it at the `site` container's root and adjust its own routing/alias rules accordingly rather than using this proxy config as-is.
