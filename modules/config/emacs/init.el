;; UI

(setq inhibit-startup-message t) ; Remove default starting screen

(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1)   ; Disable the toolbar
(tooltip-mode -1)    ; Disable tooltips
(set-fringe-mode 10) ; Give some breathing room

(menu-bar-mode -1) ; Disable the menu bar

(setq load-prefer-newer t) ; Automatic eval of .el files

;; Set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :family "JetBrains Mono" :height 160)

(load-theme 'wombat)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Home Manager / Packages 

(setq package-enable-at-startup nil) ; important pour Home Manager

;; Eglot + Nix LSP

(require 'eglot)
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'nix-mode-hook #'eglot-ensure)

(add-to-list 'eglot-server-programs '(nix-mode . ("nil")))

;; use-package (installed via Home Manager)

(require 'use-package)

; Company
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  ;; Afficher la signature dans l'écho-area pendant la complétion
  (setq company-frontends
        '(company-pseudo-tooltip-frontend
          company-echo-metadata-frontend))
  (define-key company-active-map (kbd "C-n") #'company-select-next))

; Command-log-mode
(use-package command-log-mode)

; Ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

; Swiper
(use-package swiper)

; Vterm
(use-package vterm)

; Org
(use-package org
  :defer t)

; Relative line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

; Automatic pairs
(electric-pair-mode 1)

; Discord RPC
(use-package elcord)
(elcord-mode)

;; Custom 

(custom-set-variables
 '(auth-source-save-behavior nil)
 '(package-selected-packages nil))

(custom-set-faces)
