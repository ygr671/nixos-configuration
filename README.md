# NixOS Configuration

🇫🇷  
Configuration complète de mon système NixOS basée sur les flakes.  
Ce dépôt contient l’ensemble de mes fichiers de configuration, mes modules et mes dotfiles.

🇬🇧  
Complete NixOS system configuration based on flakes.  
This repository contains all my configuration files, modules, and dotfiles.

## Description

🇫🇷  
Ce dépôt regroupe la structure complète de ma configuration NixOS, organisée autour des flakes.  
Il permet une gestion centralisée, reproductible et modulaire de tout mon système :  
- environnement de bureau  
- gestion des paquets  
- services système  
- configuration matérielle  
- Home-Manager  
- dotfiles

🇬🇧  
This repository provides the full structure of my NixOS configuration, organized around flakes.  
It enables centralized, reproducible, and modular management of the entire system:  
- desktop environment  
- package management  
- system services  
- hardware configuration  
- Home-Manager  
- dotfiles

## Installation & Utilisation  
### 🇫🇷 Installation et utilisation

> ⚠️ Cette configuration est pensée pour **ma machine personnelle**.  
> L’utiliser telle quelle peut nécessiter des modifications (GPU, utilisateur, disques…).

1. Clonez le dépôt :
```bash
git clone https://github.com/ygr671/nixos-configuration
cd nixos-configuration
````

2. Activez les flakes (si nécessaire) et appliquez la configuration :

```bash
sudo nixos-rebuild switch --flake .#zenith
```

3. Mettre à jour la configuration :

```bash
sudo nixos-rebuild switch --flake .#zenith
```

4. Mettre à jour les inputs :

```bash
nix flake update
sudo nixos-rebuild switch --flake .#zenith
```

## Manual (FR/EN)

🇫🇷

1. Supprimez `hardware-configuration.nix`
2. Modifiez vos identifiants dans `dotfiles/openfortivpn/config`
3. Lancez :

```bash
sudo nixos-rebuild switch --flake /etc/nixos#zenith
```

4. Profitez de la configuration

🇬🇧

1. Delete `hardware-configuration.nix`
2. Edit your login in `dotfiles/openfortivpn/config`
3. Run:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#zenith
```

4. Enjoy my configuration

## Fonctionnalités / Features

🇫🇷

* Gestion complète du système via flakes
* Modules personnalisés
* Intégration Home-Manager
* Dotfiles versionnés (alacritty, qtile + widgets)
* Configuration propre, modulaire, minimaliste
* Services personnalisés (ex : openfortivpn)
* Support matériel adapté à ma machine

🇬🇧

* Full system management using flakes
* Custom modules
* Integrated Home-Manager
* Versioned dotfiles (alacritty, qtile + widgets)
* Clean, modular, minimalist configuration
* Custom services (e.g., openfortivpn)
* Hardware support tailored to my machine

## Notes

🇫🇷
Ce dépôt évolue régulièrement.
Je documente progressivement mes choix afin de rendre la configuration plus claire et réutilisable.

🇬🇧
This repository evolves frequently.
I progressively document my choices to make the setup clearer and easier to reuse.
