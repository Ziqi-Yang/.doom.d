;;; lisp/lsp.el -*- lexical-binding: t; -*-
;;; lsp settings

(after! lsp-ui
  (setq lsp-ui-sideline-diagnostic-max-lines 2))

(use-package! lsp-ltex ;; check grammer and syntax. However first time you open a target file, it slows the process.
  :defer t
  :hook ((org-mode . (lambda ()
          (require 'lsp-ltex) (lsp-deferred)))
         (tex-mode . (lambda ()
          (require 'lsp-ltex) (lsp-deferred)))
          )) ; or lsp
