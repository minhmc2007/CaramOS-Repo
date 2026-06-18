#!/bin/bash
set -euo pipefail

# Build all PKGBUILDs and collect packages into repo/

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OUTPUT_DIR="$REPO_DIR/repo"
mkdir -p "$OUTPUT_DIR"

for pkgdir in "$REPO_DIR/PKGBUILDs/"*/; do
    pkgname="$(basename "$pkgdir")"
    echo ":: Building $pkgname ..."

    cd "$pkgdir"

    # Clean previous build artifacts
    rm -rf pkg/ src/ *.pkg.tar.zst *.pkg.tar.zst.sig 2>/dev/null || true

    # Build package
    makepkg -s --noconfirm --needed 2>&1 || {
        echo ":: WARNING: $pkgname build failed, skipping" >&2
        continue
    }

    # Copy .pkg.tar.zst to repo
    cp *.pkg.tar.zst "$OUTPUT_DIR/" 2>/dev/null || true
    cd "$REPO_DIR"
done

cd "$OUTPUT_DIR"
repo-add --new --remove caramos.db.tar.gz *.pkg.tar.zst 2>/dev/null || \
  repo-add caramos.db.tar.gz *.pkg.tar.zst

echo ":: Repo generated with $(ls *.pkg.tar.zst 2>/dev/null | wc -l) packages"
ls -lh
