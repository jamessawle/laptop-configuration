# James' nix-darwin System Configuration
This repository contains a [nix flake](./flake.nix) for managing my work laptop profile.

This uses [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager) to drive the configuration of the user and applications that are installed.

## Installation

### Pre-requirements
The following software needs to be installed before running this installation process:
- Git - Run `git` command in `Terminal` app
- Homebrew - [website](https://brew.sh/)

### Install Nix
Install Nix on the host machine, if it is not already there, using the following installer. The reason for using this over the nix standard installer, is due to it creating a build recipt allowing for a clean uninstall.

```bash
https://github.com/DeterminateSystems/nix-installer
```

As the configuration uses `nix-darwin`, the `nix.conf` file will need to be moved to allow Mac specific configuration to be used in the next step.

```bash
mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
```

### Checkout configuration
Checkout the configuration from the [here](https://github.com/jamessawle/laptop-configuration), to any folder on the host machine, such as `~/.config/nix`. Remember the location, as it will be used every time that the configuration is updated.

As 1Password is yet to be installed, a temporary access token will be needed to download the Github repository. This can be accessed via the `Developers` section within Github's account menu.

### Applying the configuration
The machine name defined within `flake.nix` (under `darwinConfigurations`) will need to be updated to match that of the machine that this is to be run on.

To apply the configuration, and install `nix-darwin`, run the following command:

```bash
nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake <path-to-config>
```

If `nix-darwin` is already installed on the machine, run this instead:

```bash
darwin-rebuild switch --flake <path-to-config>
```

### Setup SSH keys

### neovim configuration
This repository does not currently contain any neovim configuration, and instead requires you to bring your own; however, this might change in the future.

The recommendation is to use a neovim distribution such as [lazyvim](https://www.lazyvim.org/) as the basis of your configuration.
