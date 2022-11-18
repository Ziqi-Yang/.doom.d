;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Zarkli Leonardo"
      user-mail-address "mr.ziqiyang@gmail.com")

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
      doom-font (font-spec :family "FiraCode Nerd Font" :size 34) ;; :weight 'light
      doom-unicode-font (font-spec :family "LXGW WenKai" :size 34)
      ;; doom-variable-pitch-font (font-spec :family "LXGW WenKai" :size 34)
      ;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
      display-line-numbers-type t ;; nil, 'relaive
      org-directory "~/org/"

      evil-escape-delay 1.0
      evil-escape-key-sequence "kk"
      select-enable-clipboard nil

      scroll-margin 14

      company-idle-delay 0.2

      ;; which-key-side-window-max-height 0.3
      which-key-use-C-h-commands t
      which-key-idle-delay 0.5

      fancy-splash-image "/home/zarkli/.doom.d/assets/avatar_300-300.png"

      company-minimum-prefix-length 1
      company-idle-delay 0

      ;; increase lsp performance
      ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
      read-process-output-max (* 3 1024 1024) ;; 3 mb, doom emacs default is 1 mb
      lsp-idle-delay 0.250

      lsp-headerline-breadcrumb-enable t
      lsp-headerline-breadcrumb-segments '(symbols)

      ;; use xetex engine to better support Chinese in latex
      TeX-engine 'xetex
      )

(use-package! lsp-ltex
  :hook (text-mode . (lambda ()
          (require 'lsp-ltex)
          (lsp)))) ; or lsp-deferred

(after! lsp-ui
  (setq lsp-ui-sideline-diagnostic-max-lines 2))


(use-package! ranger
    :config (setq ranger-override-dired 'ranger))


(load! "lisp/debug_settings.el")
(load! "lisp/functions.el")
(load! "lisp/mapping.el")

(global-wakatime-mode)
