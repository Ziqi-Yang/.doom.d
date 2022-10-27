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
(setq doom-theme 'doom-flatwhite
      doom-font (font-spec :family "FiraCode Nerd Font" :size 34) ;; :wight light
      ;; + `doom-variable-pitch-font'
      ;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
      ;; fancy-splash-image "/home/zarkli/.doom.d/resources/2_mod.png"
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
      )

;; Key Settings
(map!
 ;; :n "qweqweq" "asdasda"
 :leader
 (:prefix ("z" . "mine")
  :desc "toggle-trans"             :n  "\\"    #'chunyang-toggle-frame-transparency
  :n "v"  #'vterm-other-window
  :n "z"  #'open-alacritty-in-folder
  :n "t" #'my-translator-alacritty

  :prefix ("zb" . "buffer")
  :desc "erase-whole-buffer"      :n   "e"     ":%d"

  :prefix ("zc" . "code")
  ;; cc #'my-code-run-py-interactively
  :n "a" #'my-code-run-alacritty
  :n "l" #'lsp-ui-imenu
  ))

(map!
 :mode web-mode
 :localleader
 :n "s" #'live-web-start
 :n "k" #'live-web-kill
 :n "l" #'live-web-toggle
 )


(load! "lisp/functions.el")
