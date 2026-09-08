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

This renders the Quarto project and serves the static output with nginx, available at [http://localhost:8080](http://localhost:8080). Run with `-d` to start it in the background, and `docker compose down` to stop it.
