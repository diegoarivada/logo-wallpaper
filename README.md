# Diego Logo Live

Animated Wallpaper Engine web wallpaper. It shows the diegoarivada.dev logo with drifting blue and red glows, a particle network, orbit rings, a light sweep, and a clock in the top right set in Rubik.

## Install or update

On any Windows PC with Steam and Wallpaper Engine installed, paste this into PowerShell:

```powershell
irm https://raw.githubusercontent.com/diegoarivada/logo-wallpaper/main/install.ps1 | iex
```

From a local copy of this folder, double click `install.bat` instead.

The script finds Wallpaper Engine in any Steam library, puts the files in `projects\myprojects\diego-logo-live`, and switches to the wallpaper. It needs no admin rights. Run it again after pushing an edit to update the installed copy.

## Still wallpapers

The `wallpapers` folder has static PNG versions, each in dark and light, for screens without Wallpaper Engine.

| Folder | Files | Size |
|---|---|---|
| `wallpapers/desktop` | `diego-logo-4k-dark.png`, `diego-logo-4k-light.png` | 3840x2160 |
| `wallpapers/phone` | `diego-logo-phone-iphone-*.png` | 1320x2868 |
| `wallpapers/phone` | `diego-logo-phone-android-*.png` | 1440x3200 |

## Options (Wallpaper Engine sidebar)

24-hour clock, show seconds, show date, show day progress bar, clock size, particle network, and mouse parallax. The FPS limit in Wallpaper Engine's settings also caps the animation.

## Preview in a browser

Run the `logo-wallpaper` entry in `Projects/.claude/launch.json`, or run `python -m http.server 5178` from this folder.

The Rubik font is under the SIL Open Font License (`fonts/OFL-LICENSE.txt`).
