;;; lisp/debug_settings.el -*- lexical-binding: t; -*-
;;; debug
(after! dap-mode
  (setq dap-python-debugger 'debugpy))

;; rust debug
;; source: https://gagbo.net/post/dap-mode-rust/
(with-eval-after-load 'lsp-rust
  (require 'dap-cpptools)) ;; require dap-cpptools to use debug lens on function

(with-eval-after-load 'dap-cpptools
    ;; Add a template specific for debugging Rust programs.
    ;; It is used for new projects, where I can M-x dap-edit-debug-template
    (dap-register-debug-template "Rust::CppTools Run Configuration"
      (list :type "cppdbg"
            :request "launch"
            :name "Rust::Run"
            :MIMode "gdb"
            :miDebuggerPath "rust-gdb"
            :environment []
            :program "${workspaceFolder}/target/debug/hello / replace with binary"
            :cwd "${workspaceFolder}"
            :console "external"
            :dap-compilation "cargo build"
            :dap-compilation-dir "${workspaceFolder}")))

  (with-eval-after-load 'dap-mode
    (setq dap-default-terminal-kind "integrated") ;; Make sure that terminal programs open a term for I/O in an Emacs buffer
    (dap-auto-configure-mode +1))
