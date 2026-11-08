#!/usr/bin/env python3
"""Download the font files of Flutter Fonts Kit from the official Google Fonts repository.

Usage:  python3 tool/fetch_fonts.py
Safe to re-run: existing files are skipped.
"""
import json
import os
import sys
import urllib.request

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FONTS = os.path.join(ROOT, "assets", "fonts")
LIC = os.path.join(ROOT, "licenses")
BASE = "https://raw.githubusercontent.com/google/fonts/main"

# family -> (license_dir, folder_slug, [files])
PLAN = {
    "Cairo": ("ofl", "cairo", ["Cairo[slnt,wght].ttf"]),
    "Tajawal": ("ofl", "tajawal", [
        "Tajawal-ExtraLight.ttf", "Tajawal-Light.ttf", "Tajawal-Regular.ttf",
        "Tajawal-Medium.ttf", "Tajawal-Bold.ttf", "Tajawal-ExtraBold.ttf",
        "Tajawal-Black.ttf",
    ]),
    "Almarai": ("ofl", "almarai", [
        "Almarai-Light.ttf", "Almarai-Regular.ttf", "Almarai-Bold.ttf",
        "Almarai-ExtraBold.ttf",
    ]),
    "IBM Plex Sans Arabic": ("ofl", "ibmplexsansarabic", [
        "IBMPlexSansArabic-Thin.ttf", "IBMPlexSansArabic-ExtraLight.ttf",
        "IBMPlexSansArabic-Light.ttf", "IBMPlexSansArabic-Regular.ttf",
        "IBMPlexSansArabic-Medium.ttf", "IBMPlexSansArabic-SemiBold.ttf",
        "IBMPlexSansArabic-Bold.ttf",
    ]),
    "Noto Kufi Arabic": ("ofl", "notokufiarabic", ["NotoKufiArabic[wght].ttf"]),
    "Reem Kufi": ("ofl", "reemkufi", ["ReemKufi[wght].ttf"]),
    "Amiri": ("ofl", "amiri", [
        "Amiri-Regular.ttf", "Amiri-Bold.ttf", "Amiri-Italic.ttf",
        "Amiri-BoldItalic.ttf",
    ]),
    "Aref Ruqaa": ("ofl", "arefruqaa", ["ArefRuqaa-Regular.ttf", "ArefRuqaa-Bold.ttf"]),
    "Scheherazade New": ("ofl", "scheherazadenew", [
        "ScheherazadeNew-Regular.ttf", "ScheherazadeNew-Medium.ttf",
        "ScheherazadeNew-SemiBold.ttf", "ScheherazadeNew-Bold.ttf",
    ]),
    "Poppins": ("ofl", "poppins", [
        "Poppins-Regular.ttf", "Poppins-Medium.ttf", "Poppins-SemiBold.ttf",
        "Poppins-Bold.ttf",
    ]),
    "Montserrat": ("ofl", "montserrat", ["Montserrat[wght].ttf"]),
    "Inter": ("ofl", "inter", ["Inter[opsz,wght].ttf"]),
    "Roboto": ("ofl", "roboto", ["Roboto[wdth,wght].ttf"]),
}


def fetch(url, dest):
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    req = urllib.request.Request(url, headers={"User-Agent": "flutter-fonts-kit"})
    with urllib.request.urlopen(req, timeout=120) as r, open(dest, "wb") as f:
        f.write(r.read())


def main():
    manifest = {}
    for family, (lic_dir, folder, files) in PLAN.items():
        slug = family.lower().replace(" ", "-")
        dirname = os.path.join(FONTS, slug)
        for name in files:
            dest = os.path.join(dirname, name)
            if not os.path.exists(dest):
                url = f"{BASE}/{lic_dir}/{folder}/{name.replace(' ', '%20')}"
                fetch(url, dest)
            with open(dest, "rb") as fh:
                head = fh.read(4)
            assert head in (b"\x00\x01\x00\x00", b"OTTO", b"true", b"ttcf"), (
                f"bad font {dest}: {head!r}"
            )
        lic_name = "OFL.txt" if lic_dir == "ofl" else "LICENSE"
        fetch(f"{BASE}/{lic_dir}/{folder}/{lic_name}", os.path.join(LIC, f"{slug}.txt"))
        manifest[family] = {
            "dir": slug,
            "files": files,
            "license": "OFL-1.1" if lic_dir == "ofl" else "Apache-2.0",
            "size_kb": round(
                sum(os.path.getsize(os.path.join(dirname, f)) for f in files) / 1024
            ),
        }
        print(f"OK  {family:24s} {manifest[family]['size_kb']:5d} KB")
    total = sum(m["size_kb"] for m in manifest.values())
    with open(
        os.path.join(ROOT, "assets", "fonts", "manifest.json"), "w", encoding="utf-8"
    ) as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)
    print(f"\nTotal: {total} KB across {len(manifest)} families")
    return 0


if __name__ == "__main__":
    sys.exit(main())
