;;; lisp/lsp.el -*- lexical-binding: t; -*-
;;; lsp settings

(after! lsp-ui
  (setq lsp-ui-sideline-diagnostic-max-lines 2))

(use-package! lsp-ltex ;; check grammer and syntax
  :hook ((org-mode . (lambda ()
          (require 'lsp-ltex) (lsp)))
         (tex-mode . (lambda ()
          (require 'lsp-ltex) (lsp)))
          )) ; or lsp-deferred
