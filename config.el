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
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 40)
      doom-variable-pitch-font (font-spec :family "LXGW WenKai Mono")
      ;; don't set size for doom-unicode-font, or the size won't be changed
      doom-unicode-font (font-spec :family "LXGW WenKai") ;; CJK font

      display-line-numbers-type t ;; nil, 'relaive
      org-directory "~/org/"

      evil-escape-delay 1.0
      evil-escape-key-sequence "kk"
      select-enable-clipboard nil

      scroll-margin 14

      +zen-text-scale 1

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

      ;; use xetex engine to better support Chinese in latex
      TeX-engine 'xetex
      )


;; lsp
(after! lsp-ui
  (setq lsp-ui-sideline-diagnostic-max-lines 2))

(use-package! lsp-ltex ;; check grammer and syntax
  :hook ((org-mode . (lambda ()
          (require 'lsp-ltex) (lsp)))
         (tex-mode . (lambda ()
          (require 'lsp-ltex) (lsp)))
          )) ; or lsp-deferred

;; mode line
(after! doom-modeline
  (custom-set-variables
    '(doom-modeline-buffer-file-name-style 'relative-to-project)
    '(doom-modeline-major-mode-icon t))
  (nyan-mode t))

(use-package! nyan-mode
  :config
  (setq nyan-animate-nyancat t
        nyan-wavy-trail t
        nyan-cat-face-number 4
        nyan-bar-length 20
        nyan-minimum-window-width 100))

(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")

(use-package! ranger
    :config (setq ranger-override-dired 'ranger))

;; use sioyek as default latex pdf viewer
(setq TeX-view-program-list
      '(("Sioyek"
        ("sioyek %o"
         (mode-io-correlate " --forward-search-file %b --forward-search-line %n --inverse-search \"emacsclient --no-wait +%2:%3 %1\""))
        "sioyek"))
      TeX-view-program-selection
      '(((output-dvi has-no-display-manager)
         "dvi2tty")
        ((output-dvi style-pstricks)
         "dvips and gv")
        (output-dvi "xdvi")
        (output-pdf "Sioyek")
        (output-html "xdg-open")
        (output-pdf "preview-pane"))
      +latex-viewers '(sioyek))

(load! "lisp/debug_settings.el")
(load! "lisp/functions.el")
(load! "lisp/mapping.el")

(add-to-list 'default-frame-alist '(alpha . 90))

(global-wakatime-mode)
