;;; lisp/org.el -*- lexical-binding: t; -*-
;;; org mode settings

;; basic org
(setq!
  org-directory "~/notes/"
  org-hide-emphasis-markers t
  org-pretty-entities t
  org-ellipsis "…"
  org-log-done 'time
  ;; org-priority-faces
  ;;   '((?A :foreground "#ff6c6b" :weight bold)
  ;;     (?B :foreground "#98be65" :weight bold)
  ;;     (?C :foreground "#c678dd" :weight bold))
  org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
    '(("google" . "http://www.google.com/search?q=")
      ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
      ("wiki" . "https://en.wikipedia.org/wiki/"))
  org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
    '((sequence
        "TODO(t)"           ; A task that is ready to be tackled
        "BLOG(b)"           ; Blog writing assignments
        "GYM(g)"            ; Things to accomplish at the gym
        "PROJ(p)"           ; A project that contains other tasks
        "VIDEO(v)"          ; Video assignments
        "WAIT(w)"           ; Something is holding up this task
        "|"                 ; The pipe necessary to separate "active" states and "inactive" states
        "DONE(d)"           ; Task has been completed
        "CANCELLED(c)" )))

;; org-agenda
(setq!
  org-agenda-files '("~/notes/agenda.org")
  org-agenda-block-separator 8411 ;; use <SPC-h-'>(describe-char) to show a character's code
  org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags "customtag"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo "")))))
