;;; lisp/trivial.el -*- lexical-binding: t; -*-
;;; Trivial Settings

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
