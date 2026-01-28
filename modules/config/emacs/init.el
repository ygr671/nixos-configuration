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

(load-theme 'modus-vivendi)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Home Manager / Packages 

(setq package-enable-at-startup nil) ; important pour Home Manager

;; Eglot

(require 'eglot)

(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'nix-mode-hook #'eglot-ensure)
(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'typescript-ts-mode-hook #'eglot-ensure)
(add-hook 'js-mode-hook #'eglot-ensure)   
(add-hook 'js-ts-mode-hook #'eglot-ensure)
(add-hook 'rjsx-mode-hook #'eglot-ensure)

(add-to-list 'eglot-server-programs '(nix-mode . ("nil")))

(add-to-list 'eglot-server-programs 
             '((typescript-mode typescript-ts-mode) . ("typescript-language-server" "--stdio")))

(add-to-list 'eglot-server-programs 
             '((js-mode js-ts-mode rjsx-mode) . ("typescript-language-server" "--stdio")))

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

; Org
(use-package org
  :defer t)

; Relative line numbers
(setq display-line-numbers-type 't)
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

;; QoL
(global-visual-line-mode 1)

(custom-set-faces)

;; Web development stuff
(require 'use-package)

(use-package web-mode
  :mode (("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode)
         ("\\.html\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-quoting nil))

(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (eglot-ensure))))

;; Associer les extensions TypeScript / TSX
(add-to-list 'auto-mode-alist '("\\.ts\\'"  . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'"  . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . tsx-ts-mode))
