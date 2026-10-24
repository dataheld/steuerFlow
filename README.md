# steuerFlow

Ein paar Mermaid-Flussdiagramme für Steuerzahler.

::: {.callout-note}
Keine Steuer- oder Rechtsberatung.
Keine Haftung für den Inhalt.
:::

Verbesserungen (Pull Requests, Issues) sind herzlich Willkommen!

Website: <https://steuerflow.maxheld.de>.

## Entwicklung

Die Website verwendet den Quarto-Projekttyp `nullkomma-docs` von
[nullkomma](https://github.com/dataheld/nullkomma).
Nix stellt Quarto und die Cloudflare-Werkzeuge bereit.

```sh
nix develop --command generate-files
nix develop --command preview
nix build .#site
nix flake check
```

Die Diagramme bleiben in `diagrams/*.mmd`, die Inhalte in `index.qmd`.
`_quarto.yml` konfiguriert die Website; nullkomma liefert Navigation, Suche,
Inhaltsverzeichnis, Repository-Aktionen und die Datenschutzseite.
Nach Änderungen an `flake.nix` die verwalteten Dateien aktualisieren:

```sh
nix develop --command write-files
nix develop --command generate-files
```

## Deployment

GitHub Actions verwendet nullkommas wiederverwendbare CI und veröffentlicht
nach erfolgreichen Checks auf `main` mit `nix run .#deploy`.
Pull Requests, Tags und manuelle Workflow-Aufrufe deployen nicht.
Der bisherige GitHub-Pages-Workflow wird damit ersetzt.

Im Repository müssen folgende Actions-Variablen gesetzt sein:

- `CLOUDFLARE_ACCOUNT_ID`
- `CLOUDFLARE_STATE_BUCKET`

Außerdem benötigt das Repository Zugriff auf diese vorhandenen
Organisations-Secrets:

- `CLOUDFLARE_API_TOKEN` mit Account / Workers Scripts / Edit
- `CLOUDFLARE_R2_ACCESS_KEY_ID`
- `CLOUDFLARE_R2_SECRET_ACCESS_KEY`

Die R2-Zugangsdaten benötigen Object Read & Write ausschließlich für den privaten
State-Bucket. Die Zone `maxheld.de` muss im selben Cloudflare-Account aktiv sein.
nullkomma verwaltet Worker, DNS und HTTPS für `steuerflow.maxheld.de`;
die Hauptdomain bleibt unverändert. Der Name wird explizit kleingeschrieben,
weil der Repository-Name `steuerFlow` kein gültiger Worker-Name ist.

Lokal mit denselben Umgebungsvariablen:

```sh
nix develop --command terraform
nix run .#deploy
```
