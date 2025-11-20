final: prev:

{
  mautrix-whatsapp = prev.mautrix-whatsapp.overrideAttrs (oldAttrs: {
    version = "25.11";  # Beispielversion
    src = prev.fetchFromGitHub {
      owner = "mautrix";
      repo = "whatsapp";
      tag = "v0.2511.0";
      hash = "sha256-0Jpod9/mZ9eGFvPxki6Yz0KL1XQ4HTtZ7Zv7WvamuC0=";
    };
    vendorHash = "sha256-n25j2uM3e5/5PYs2jwH+iclaU/p/MhctCAhPninz2HI=";

    # Falls zusätzliche Build-Änderungen nötig sind:
    # buildInputs = oldAttrs.buildInputs ++ [ ... ];
  });
}
