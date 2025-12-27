# coffeeknife-overlay

Just some ebuilds I wrote for packages that I couldn't find in any overlays.

To use this overlay:

```bash
eselect repository add coffeeknife-overlay git https://github.com/coffeeknife/coffeeknife-overlay.git
emaint sync -r coffeeknife-overlay
```

## current packages

| package | version | description |
| --- | --- | --- |
| [app-misc/dotter](https://github.com/SuperCuber/dotter) | 0.13.3 ~amd64 | SuperCuber's dotter: A dotfile manager and templater written in rust 🦀 |
| [mail-client/proton-mail-bin](https://proton.me/mail/download) | 1.7.1 ~amd64 | Official desktop client for [proton.me](https://proton.me). Uses their RPM. |