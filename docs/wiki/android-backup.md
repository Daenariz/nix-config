# Android Backup Workflow (ADB-Sync)

Verfahren zum Synchronisieren von Android-Geräten (Huawei, GrapheneOS) mit NixOS.

## Vorbereitung
1. **Entwickleroptionen** am Handy aktivieren (7x auf Build-Nummer tippen).
2. **USB-Debugging** aktivieren.
3. Handy via USB anschließen und Modus **"Dateien übertragen" (MTP)** wählen.
4. Am Laptop in die Shell mit Tools gehen:
   ```bash
   nix-shell -p android-tools adb-sync
   ```
5. Verbindung autorisieren:
   ```bash
   adb devices
   # Prompt am Handy bestätigen!
   ```

## Synchronisation (Selektiv)
Um nur bestimmte Ordner vom Handy auf die externe SSD zu spiegeln (ohne Duplikate):

```bash
# -t: Zeitstempel erhalten (wichtig für Galerie-Sortierung)
# -R: Reverse Sync (Handy -> PC)
# . : Ziel ist das aktuelle Verzeichnis auf der SSD
adb-sync -t -R /sdcard/DCIM /sdcard/Pictures /sdcard/WhatsApp .
```

## Problembehebung
- **HiSuite wird gemountet**: Handy-Benachrichtigungsleiste -> USB-Modus von "Laden" auf "Dateien übertragen" stellen.
- **Berechtigung verweigert**: `adb kill-server && adb devices` und den RSA-Key Prompt am Handy erneut bestätigen.
- **NTFS Fehler**: Falls die SSD nicht schreibt, `sudo ntfsfix /dev/sdXY` nutzen.

---
Zuletzt aktualisiert: 2026-05-29 (Hermes Agent)
