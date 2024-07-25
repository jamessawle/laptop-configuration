# James' nix-darwin System Configuration

This repository contains a [nix flake](./flake.nix) for managing my work laptop profile.

This uses [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager) to drive the configuration of the user and applications that are installed.

## Installation

### Install Nix
Install Nix on the host machine, if it is not already there, using the following installer. The reason for using this over the nix standard installer, is due to it creating a build recipt allowing for a clean uninstall.

```bash
https://github.com/DeterminateSystems/nix-installer
```

### Checkout configuration
Checkout the configuration from the following repository, to any folder on the host machine, such as `~/.config/nix`. Remember the location, as it will be used every time that the configuration is updated.

```bash
https://github.com/jamessawle/laptop-configuration
```

### Applying the configuration
To apply the configuration, and install `nix-darwin`, run the following command:

```bash
nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake <path-to-config>
```

If `nix-darwin` is already installed on the machine, run this instead:

```bash
darwin-rebuild switch --flake <path-to-config>
```

### neovim configuration
This repository does not currently contain any neovim configuration, and instead requires you to bring your own; however, this might change in the future.

The recommendation is to use a neovim distribution such as [lazyvim](https://www.lazyvim.org/) as the basis of your configuration.

