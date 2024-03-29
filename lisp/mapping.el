;;; lisp/mapping.el -*- lexical-binding: t; -*-
;;; Key Settings

;;; unmap ========================================
(map! :leader
      :n "w C-h" nil) ;; evil-window-left keybinding(but another keybinding <leader-w-h> also binds to it) conflicts with which-key page next/prev

;;; map ========================================
(map!
  ;; utils
  :i "C-S-v" 'clipboard-yank
  :i "C-s" 'save-buffer

  ;; movement
  :i "C-j" 'evil-next-line
  :i "C-k" 'evil-previous-line
  :i "C-h" 'backward-char ;; conflict, but originally C-h have the same function as :n <SPC-h>
  :i "C-l" 'forward-char)

;; based on doom already mapped leading character(like t, o), but no clash
(map!
  :leader
  :n "tW" 'bh:see-all-whitespace
  :n "o=" #'project-dired)

;; leader =
(map! :leader
      (:prefix ("=" . "open file")
       :desc "Edit agenda file"      "a" #'(lambda () (interactive) (find-file "~/notes/agenda.org"))))

;; leader z
(map!
 :leader
 (:prefix ("z" . "mine")
  :desc "toggle-trans"            :n  "\\"    #'chunyang-toggle-frame-transparency
  :n "v"  #'vterm-other-window
  :n "a"  #'open-alacritty-smart
  :n "x"  #'open-alacritty-here
  :n "t"  #'my-translator-alacritty
  :n "m"  #'+default/man-or-woman

  :prefix ("zb" . "buffer")
  :desc "erase-whole-buffer"      :n   "e"     ":%d"

  :prefix ("zc" . "code")
  ;; cc #'my-code-run-py-interactively
  :n "a" #'my-code-run-alacritty
  :n "c" #'open-in-code
  :n "l" #'lsp-ui-imenu ;; show symbols in the side (try lsp-treemace-symbols also, but it needsd some time to show up)
  :n "s" #'lsp-treemacs-symbols
  :n "h" #'lsp-treemacs-call-hierarchy
  :n "x" #'flycheck-list-errors ;; errors in current file
  :n "X" #'lsp-treemacs-errors-list
  :n "S" #'lsp-ui-sideline-mode ;; toggle sideline mode

  ;; :n "m" #'+make/run
  ;; :n "n" #'+make/run-last

  :prefix ("zl" . "lisp manage")
  :n "r"  #'lsp-workspace-folders-remove
  :n "l"  #'lsp-lens-show

  :prefix ("zn" . "nyan cat")
  :n "s"  #'nyan-start-music
  :n "p"  #'nyan-stop-music
   ))


(map! ;; live web
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
 :n "l" #'live-web-toggle)

;; org mode mapping
(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)

;; dap-mode mapping
(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)
