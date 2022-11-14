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
      doom-unicode-font (font-spec :family "LXGW WenKai" :size 34 :weight 'bold)
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
      )

(use-package! lsp-ltex
  :ensure t
  :hook (text-mode . (lambda ()
                       (require 'lsp-ltex)
                       (lsp)))  ; or lsp-deferred
)



(after! lsp-ui
  (setq lsp-ui-sideline-diagnostic-max-lines 2))

(use-package! ranger
    :config (setq ranger-override-dired 'ranger))

(add-hook! text-mode
  (lambda ()
    (require 'lsp-grammarly)
    (lsp))
  )


;; Key Settings
(map!
 :leader
 (:prefix ("z" . "mine")
  :desc "toggle-trans"             :n  "\\"    #'chunyang-toggle-frame-transparency
  :n "v"  #'vterm-other-window
  :n "z"  #'open-alacritty
  :n "t" #'my-translator-alacritty


  :prefix ("zb" . "buffer")
  :desc "erase-whole-buffer"      :n   "e"     ":%d"

  :prefix ("zc" . "code")
  ;; cc #'my-code-run-py-interactively
  :n "a" #'my-code-run-alacritty
  :n "l" #'lsp-ui-imenu ;; show symbols in the side (try lsp-treemace-symbols also, but it needsd some time to show up)
  :n "s" #'lsp-treemacs-symbols
  :n "h" #'lsp-treemacs-call-hierarchy
  :n "x" #'flycheck-explain-error-at-point ;; enable this mode when error msg is too long (or try flycheck-popup-tip-mode)
  :n "X" #'lsp-treemacs-errors-list

  :n "m" #'+make/run
  :n "n" #'+make/run-last


  :prefix ("zl" . "lisp manage")
  :n "r"  #'lsp-workspace-folders-remove
  ))

(map!
 :leader
 :n "o=" #'project-dired
 )

(map!
 :mode web-mode
 :localleader
 :n "s" #'live-web-start
 :n "k" #'live-web-kill
 :n "l" #'live-web-toggle

 :mode css-mode
 :localleader
 :n "s" #'live-web-start
 :n "k" #'live-web-kill
 :n "l" #'live-web-toggle

 :mode js-mode
 :localleader
 :n "s" #'live-web-start
 :n "k" #'live-web-kill
 :n "l" #'live-web-toggle
 )


(load! "lisp/functions.el")

(global-wakatime-mode)
