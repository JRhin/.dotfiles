<h1 align="center">❄️ JRhin's Dotfiles</h1>

<p align="center">
  <em>NixOS + Home Manager + niri, themed with Catppuccin.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/NixOS-unstable-89b4fa?style=for-the-badge&logo=nixos&logoColor=cdd6f4&labelColor=1e1e2e" alt="NixOS" />
  <img src="https://img.shields.io/badge/WM-niri-cba6f7?style=for-the-badge&labelColor=1e1e2e" alt="niri" />
  <img src="https://img.shields.io/badge/Theme-Catppuccin_Mocha-f5c2e7?style=for-the-badge&labelColor=1e1e2e" alt="Catppuccin Mocha" />
</p>

<hr>

## ✨ Stack

**niri** · **Noctalia** · **kitty** + **zellij** + **zsh** · **Helix** · **Zen** / Firefox · **yazi** · **Stylix**

<hr>

## 📁 Structure

```
.dotfiles/
├── flake.nix
├── hardware/thinkpad/        # hardware-configuration.nix
├── hosts/thinkpad/
│   ├── configuration.nix     # system entry point
│   └── home.nix              # Home Manager entry point
└── modules/
    ├── system/               # NixOS modules
    └── home/                 # Home Manager modules
```

<hr>

## 🚀 Install

```bash
git clone https://github.com/JRhin/.dotfiles ~/.dotfiles
cd ~/.dotfiles
sudo nixos-rebuild switch --flake .#thinkpad
```

<hr>

## 🛠️ Commands

`nh` is installed and `NH_FLAKE` points to this repo, so no path is needed.

```bash
git add -A                # flakes only see tracked files
nh os build               # check that it builds
nh os switch --ask        # apply (shows the diff first)
nh os boot                # apply at next reboot (use for big upgrades)
nh os switch --update     # update inputs, then apply
nh clean all --keep 3     # remove old generations
```

Rollback: `sudo nixos-rebuild switch --rollback`, or hold **Space** at boot to pick an older generation.

<hr>

## ⚠️ Notes

- Run `git add -A` before every build, or new files will not be found.
- Keep `stateVersion` at `23.11`; do not bump it without reading the release notes.
- For themed programs use `programs.<name>.enable = true` so Stylix can style them.

<p align="center">
        <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>
