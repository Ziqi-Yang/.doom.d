;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Leonardo Zarkli"
      user-mail-address "ziqi-yang@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-gruvbox-light)
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/notes/org/")
(setq org-noter-notes-search-path '("~/Documents/notes/org/"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(setq doom-font (font-spec :family "Fira Code" :size 45))
(setq initial-frame-alist (quote ((fullscreen . maximized))))
;; (add-hook! python-mode
;;   (setq python-shell-interpreter "ipython"))
(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))

(setq evil-escape-key-sequence "jj") ;; use jj to exit insert mode
(setq x-select-enable-clipboard nil) ;; make registers work like vim,but emacs C-y doesn't work

(setq org-plot/gnuplot-default-options
      '(
        (:plot-type . 2d)
        (:with . histograms) ;;lines, points, boxes, impulses, histograms ...
        (:ind . 1))
      )

(setq deft-directory "/home/zarkli/Documents/notes/org/mynotes"
      deft-extensions '("org")
      deft-recursive t)

;; (setq scroll-margin 14) ;; like scrolloff in vim
;; (setq scroll-conservatively 1) ;; it seems already opened in doom emacs

(global-visual-line-mode t) ;; word wrap

(defun chunyang-toggle-frame-transparency ()
  (interactive)
  (if (equal (frame-parameter nil 'alpha) 75)
      (set-frame-parameter nil 'alpha 100)
    (set-frame-parameter nil 'alpha 75)))

(add-hook 'org-mode-hook 'org-hide-block-all) ;; hide code/quote/... blocks
(after! ispell (setq ispell-alternate-dictionary "~/.doom.d/ispell/english-words.txt"))
(setq which-key-idle-delay 0.5)
;; (setq yas-triggers-in-field t) ;; :editor snippets ; allow nested snippets

(defun my-hugo-new-file()
  (interactive)
  ;; you only need to change the two variables hugo-root-path and hugo-section
  (let ((newFilename (s-replace " " "_" (read-from-minibuffer "new blog filename(without suffix):")))
        (hugo-root-path "~/Documents/blog/exotic")
        (hugo-section "post")
        )
        (setq absoluteFilePath (concat (file-name-as-directory hugo-root-path) (format "content/%s/%s.org" hugo-section newFilename)))
  (shell-command (format "cd %s && hugo new %s/%s.org" hugo-root-path hugo-section newFilename))
  (find-file absoluteFilePath)
    ))
(defun chunyang-toggle-frame-transparency ()
  (interactive)
  (if (equal (frame-parameter nil 'alpha) 75)
      (set-frame-parameter nil 'alpha 100)
    (set-frame-parameter nil 'alpha 75)))


(map! :n "<SPC>\\" #'my-hugo-new-file)
(map! :n "<SPC>zp" "\"+P")
(map! :v "<SPC>zy" "\"+y")
(map! :n "<SPC>zbe" ":%d")
(map! :n "<SPC>zt" #'go-translate)
(map! :v "<SPC>zes" #'evil-surround-edit)
(map! :n "<SPC>z<SPC>" #'chunyang-toggle-frame-transparency)

(defun my-org-re-reveal-init-and-export-and-browse()
  (interactive)
  (org-re-reveal-version)
  (org-re-reveal-export-to-html-and-browse))
;; for better inline math(latex) experience
(defun my-org-complete-dollar()(interactive)(insert "$$")(left-char 1))
(defun my-org-complete-brackets()(interactive)(insert "{}")(left-char 1))
(defun my-org-complete-squre-brakcets()(interactive)(insert "[]")(left-char 1))
(defun my-org-complete-underline()(interactive)(insert "_{}")(left-char 1))
(defun my-org-complete-z()(interactive)(insert "z"))
(defun my-org-complete-lrbrackets()(interactive)(insert "\\left(   \\right)")(left-char 9))

(after! org
  (map! :n "<SPC>zop" #'my-org-re-reveal-init-and-export-and-browse)
  (map! :n "<SPC>zol" #'org-latex-preview)
  (map! :i "$" #'my-org-complete-dollar)
  (map! :i "{" #'my-org-complete-brackets)
  (map! :i "[" #'my-org-complete-squre-brakcets)
  (map! :i "_" #'my-org-complete-underline)
  (map! :i "zlb" #'my-org-complete-lrbrackets)
  (map! :i "zz" #'my-org-complete-z)
  )

(use-package! which-key
  :config
  (which-key-add-key-based-replacements
    "<SPC>z" "mine"
    "<SPC>zp" "paste(clip)"
    "<SPC>zy" "copy(clip)"
    "<SPC>zb" "buffer"
    "<SPC>zbe" "erase-buffer"
    "<SPC>ze" "evil"
    "<SPC>zo" "org"
    "<SPC>zop" "reveal.js"
    "<SPC>zol" "latex-preview"))
(use-package! go-translate
  :config
  (setq go-translate-base-url "https://translate.google.cn")
  (setq go-translate-local-language "zh-CN")
  (setq go-translate-token-current (cons 430675 2721866130)))

(use-package org-latex-impatient
  :defer t
  :hook (org-mode . org-latex-impatient-mode)
  :init
  (setq org-latex-impatient-tex2svg-bin
        ;; location of tex2svg executable
        "/home/zarkli/node_modules/mathjax-node-cli/bin/tex2svg")
  (setq org-latex-impatient-scale 6.0))
(use-package! asymbol
  ;; try it out
  ;; use ` key to pop up help window
  ;; use ; key to pop up help window (another function)
  :init
  ;; a little customization
  (setq asymbol-help-symbol-linewidth 100
        asymbol-help-tag-linewidth 300
        asymbol-help-tag-count 20
        asymbol-help-symbol-count 20)
  ;; enable in org-mode and tex-mode
  (add-hook 'org-mode-hook #'asymbol-mode)
  (add-hook 'tex-mode-hook #'asymbol-mode)
)

(after! org
  (add-to-list 'org-capture-templates
               '("z" "mine"))
  (add-to-list 'org-capture-templates
               '("zm" "math" entry (file "/home/zarkli/Documents/notes/org/math/1.org") "* %t %?" :prepend t :kill-buffer t))
)

(after! org
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 5.0))
)
