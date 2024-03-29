;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "MeowKing"
      user-mail-address "mr.ziqiyang@gmail.com")

;; Recommend Reading:
;;   Doom Emacs Anti Patterns: https://discourse.doomemacs.org/t/common-config-anti-patterns/119

;; Theme Recommendations:
;; light-theme:
;;      doom-solarized-light doom-grubbox-light
;;      special: doom-fairy-floss doom-flatwhite
;; dark-theme:
;;      doom-material doom-dracula doom-gruvbox doom-one
;; (setq doom-theme 'doom-one)
(setq-default
  tab-width 2)

(setq doom-theme 'doom-solarized-light
      doom-font (font-spec :family "BlexMono Nerd Font" :size 18) ;; :weight 'light
      ;; doom-font (font-spec :family "FiraCode Nerd Font" :size 18) ;; :weight 'light
      doom-big-font (font-spec :family "BlexMono Nerd Font" :size 21)
      doom-variable-pitch-font (font-spec :family "BlexMono Nerd Font")
      ;; don't set size for doom-unicode-font, or the size won't be changed
      doom-unicode-font (font-spec :family "LXGW WenKai") ;; CJK font

      display-line-numbers-type t ;; nil, 'relaive

      evil-escape-delay 1.0
      evil-escape-key-sequence "kk"
      select-enable-clipboard nil

      scroll-margin 14

      ;; +zen-text-scale 1

      company-show-numbers t ;; alt + <num> to choose
      company-minimum-prefix-length 1
      company-idle-delay 0

      ;; which-key-side-window-max-height 0.3
      which-key-use-C-h-commands t
      which-key-idle-delay 0.5

      ;; increase lsp performance
      ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
      read-process-output-max (* 3 1024 1024) ;; 3 mb, doom emacs default is 1 mb
      lsp-idle-delay 0.250

      ;; use xetex engine to better support Chinese in latex
      TeX-engine 'xetex
      )

(global-wakatime-mode)
(global-org-modern-mode) ;; need to be placed before org configuration, otherwise not work?
(beacon-mode 1) ;; highlight the cursor whenever the window scrolls

(load! "lisp/ui.el")
(load! "lisp/lsp.el")
(load! "lisp/debug_settings.el")
(load! "lisp/functions.el")
(load! "lisp/org.el")
(load! "lisp/trivial.el")
(load! "lisp/mapping.el")

;; this line will casuse performance issue in pgtk build on wayland(emacs28,29-native-comp)
;; (add-to-list 'default-frame-alist '(alpha . 90))

(native-compile-prune-cache) ;; remove old version native-compiled files
