{
  description = "steuerFlow: Mermaid-Flussdiagramme fuer Steuerzahler";

  inputs = {
    nullkomma.url = "https://flakehub.com/f/dataheld/nullkomma/0.1.*";
    nixpkgs.follows = "nullkomma/nixpkgs";
  };

  outputs =
    inputs:
    inputs.nullkomma.lib.mkFlake { inherit inputs; } {
      nullkomma.quarto.enable = true;
      nullkomma.cloudflare = {
        enable = true;
        domain = "maxheld.de";
        name = "steuerflow";
      };
      nullkomma.privacy = {
        title = "Datenschutz";
        languages = [
          {
            code = "de";
            label = "Deutsch";
          }
        ];
      };
      # Keep CI and its dependent production deployment in one workflow.
      nullkomma.github.enable = false;
      nullkomma.gitignore = [
        "index.html"
        "index_files/"
      ];
      # typos only supports English, not the site's German prose and node names.
      perSystem.treefmt.settings.formatter.typos.excludes = [
        "README.md"
        "index.qmd"
        "diagrams/*.mmd"
      ];
    };
}
