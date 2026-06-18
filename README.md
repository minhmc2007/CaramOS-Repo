# CaramOS-Repo

Custom Arch Linux pacman repository for CaramOS.

Hosts packages not available in Arch official repos (or needing custom patches):
fcitx5-lotus, lightdm-slick-greeter, wps-office-cn, google-chrome, zalo,
xed, xviewer, xreader, cinnamon-delight-theme, caramos-keyring.

## Structure

```
PKGBUILDs/           # Source PKGBUILDs (one subdir per package)
  fcitx5-lotus/      # → fcitx5-lotus.pkg.tar.zst
  lightdm-slick-greeter/
  google-chrome/
  wps-office-cn/
  zalo/
  xed/
  xviewer/
  xreader/
  cinnamon-delight-theme/
  caramos-keyring/
repo/                # Generated: pacman database + built packages
  caramos.db.tar.gz
  caramos.files.tar.gz
  *.pkg.tar.zst
```

## Add a new package

```bash
mkdir PKGBUILDs/my-package
# Create PKGBUILD, .install, patches, etc.
# Test build:
cd PKGBUILDs/my-package && makepkg -si
# Then push; CI will build & add to repo
```

## Manual build & add (local testing)

```bash
chmod +x scripts/build-and-release.sh
./scripts/build-and-release.sh
```
