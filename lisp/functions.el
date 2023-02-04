;;; lsp/functions.el --- custom functions -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defun chunyang-toggle-frame-transparency ()
  "Toggle the Emacs window opacity. Not working in emacs29-pgtk."
  (interactive)
  (if (equal (frame-parameter nil 'alpha) 90)
      (set-frame-parameter nil 'alpha 100)
    (set-frame-parameter nil 'alpha 90)))

(defun open-in-code ()
  "Open Current file or project in Code Oss(Vs Code)."
  (interactive)
  (if (projectile-project-p) ;;; start browser-sync in the project root if in a project
      (start-process-shell-command "code oss"
                                   "*code oss*"
                                   (concat "code " (projectile-project-p)))
      (start-process-shell-command "code oss"
                                   "*code oss*"
                                   (concat "code " (buffer-file-name))))
  (message "done"))


(defun live-web-start()
  "Start live web server process using browser-sync."
  (interactive)

  (condition-case nil
      (delete-process "live-web")
    (error nil))

  (if (projectile-project-p) ;;; start browser-sync in the project root if in a project
      (start-process-shell-command "live-web"
                                   "*my-buffer*"
                                   (concat "browser-sync start --server " (projectile-project-p) " --files '*.html,*.css,*.js,**/*.html,**/*.css,**/*.js'"))
    (start-process-shell-command "live-web"
                                 "*my-buffer*"
                                 "browser-sync start --server --files '*.html,*.css,*.js,**/*.html,**/*.css,**/*.js'"))

  (message "live web start"))

(defun live-web-kill()
  "End live web server process."
  (interactive)
  (condition-case nil
      (delete-process "live-web")
    (error nil))
  (message "live web killed")
  )

(defun live-web-toggle()
  "Toggle live web"
  (interactive)
  (if (get-process "live-web")
      (live-web-kill)
    (live-web-start))
  )

;; run single file
(defun my-code-run-alacritty()
  "Run code in external terminal(alacritty)."
  (interactive)
  (if (equal major-mode 'python-mode)
      ;; python language
      (let
        ((shell "/usr/bin/fish")
          (tmpSourceFile (expand-file-name ".my-code-run-alacritty.py"))
          (command (concat "time python " (expand-file-name ".my-code-run-alacritty.py") " ; echo ------------------------------ ; echo -e [Use \033[33mCtrl-Shift-Space\033[0m to toggle vi mode] ; read -P '[Press \033[33mENTER\033[0m key to exit]'"))
          )
        ;; (write-region "import time\nSTARTTIME=time.time()\n\n" nil tmpSourceFile)
        (write-region "" nil tmpSourceFile)
        (write-region nil (point-max) tmpSourceFile t)
        ;; (write-region "\nENDTIME=time.time()\nprint('\\n\\n')\nprint('-'*30)\nprint('\033[33mTotal Time\033[0m: {}\033[33ms\033[0m'.format(ENDTIME-STARTTIME))\n" nil tmpSourceFile t)
        (start-process-shell-command "my-code-run-alacritty" "*my-buffer*"
          (concat "alacritty --class fullscreen -e " shell " -c \"" command "\"" "; rm " tmpSourceFile))
        ))
  ;; golang
  (if (equal major-mode 'go-mode)
      ;;   go run *.go
      (start-process-shell-command "my-code-run-alacritty" "*my-buffer*"
        (concat "alacritty --class fullscreen -e " "/usr/bin/fish" " -c \"" (concat "go run " (file-name-directory buffer-file-name)) "/*.go"  " ; echo \n;echo ------------------------------ ; echo -e [Use \033[33mCtrl-Shift-Space\033[0m to toggle vi mode] ; read -P '[Press \033[33mENTER\033[0m key to exit]'" "\""))
    )
  (if (equal major-mode 'c++-mode)
      (let ((shell "/usr/bin/fish")
            (tmpExecutefile "/tmp/my-code-run-cpp-alacritty")
            (tmpSourceFile (expand-file-name ".my-code-run-alacritty.cpp"))
            (command (concat "clang++ " (expand-file-name ".my-code-run-alacritty.cpp") " -fsanitize=undefined -o  /tmp/my-code-run-cpp-alacritty && time /tmp/my-code-run-cpp-alacritty; echo ------------------------------ ; echo -e [Use \033[33mCtrl-Shift-Space\033[0m to toggle vi mode] ; read -P '[Press \033[33mENTER\033[0m key to exit]'")))
        (write-region "" nil tmpSourceFile)
        (write-region nil (point-max) tmpSourceFile)
        ;; (shell-command (concat "alacritty --command " tmpfile))
        (start-process-shell-command "my-code-run-alacritty" "*my-buffer*"
          (concat "alacritty --class fullscreen -e " shell " -c \"" command "\"" "; rm " tmpSourceFile))
        )
    )
  (if (equal major-mode 'c-mode)
      (let ((shell "/usr/bin/fish")
            (tmpExecutefile "/tmp/my-code-run-c-alacritty")
            (tmpSourceFile (expand-file-name ".my-code-run-c-alacritty.c"))
            (command (concat "clang " (expand-file-name ".my-code-run-c-alacritty.c")
                       " -fsanitize=undefined -o  /tmp/my-code-run-c-alacritty && time /tmp/my-code-run-c-alacritty; echo ------------------------------ ; echo -e [Use \033[33mCtrl-Shift-Space\033[0m to toggle vi mode] ; read -P '[Press \033[33mENTER\033[0m key to exit]'")))
        (write-region "" nil tmpSourceFile)
        (write-region nil (point-max) tmpSourceFile)
        ;; (shell-command (concat "alacritty --command " tmpfile))
        (start-process-shell-command "my-code-run-alacritty" "*my-buffer*"
          (concat "alacritty --class fullscreen -e " shell " -c \"" command "\"" "; rm " tmpSourceFile))
        )
    )
  (if (equal major-mode 'java-mode)
    (let (
           (command (concat "time java " (buffer-file-name) "; echo ------------------------------ ; echo -e [Use \033[33mCtrl-Shift-Space\033[0m to toggle vi mode] ; read -P '[Press \033[33mENTER\033[0m key to exit]'")))
      (start-process-shell-command "my-code-run-alacritty" "*my-buffer*"
        (concat "alacritty --class fullscreen -e /usr/bin/fish -c \"" command "\""))
      )
    )
  (if (equal major-mode 'web-mode)
      (live-web-start))
  (if (equal major-mode 'css-mode)
      (live-web-start))
  )


(defun my-translator-alacritty()
  "Translate words at the point by using ydicy in the external terminal alacritty."
  (interactive)
  (setq my-tmpV-translator-bounds (bounds-of-thing-at-point 'word))
  (setq my-tmpV-translator-pos1 (car my-tmpV-translator-bounds))
  (setq my-tmpV-translator-pos2 (cdr my-tmpV-translator-bounds))
  (setq my-tmpV-translator-mything (buffer-substring-no-properties my-tmpV-translator-pos1 my-tmpV-translator-pos2))
  (setq my-tmpV-translator-commands (concat "echo " my-tmpV-translator-mything " ; source $HOME/.config/fish/functions/t.fish && t " my-tmpV-translator-mything " ; echo ------------------------------ ; echo [Use Ctrl-Shift-Space to toggle vi mode] ; read -P '[Press ENTER key to exit]'"))
  (start-process-shell-command "my-translator" "*my-buffer*" (concat "alacritty --class floating -e /usr/bin/fish -c \"" my-tmpV-translator-commands "\""))
  )

(defun open-alacritty-smart()
  "Open alacritty terminal at project root if in a project, otherwise current folder."
  (interactive)
  (if (projectile-project-p)
      (start-process-shell-command "open-alacritty-in-folder" "*alacritty*"
                                   (concat "alacritty --class floating --working-directory " (projectile-project-p) ))
    (start-process-shell-command "open-alacritty-in-folder" "*alacritty*"
                                 (concat "alacritty --class floating --working-directory " (file-name-directory buffer-file-name) )) ))


(defun open-alacritty-here()
  "Open alacritty terminal at the current folder."
  (interactive)
  (start-process-shell-command "open-alacritty-in-folder" "*alacritty*"
                                (concat "alacritty --class floating --working-directory " (file-name-directory buffer-file-name) )) )

(defun bh:see-all-whitespace ()
  "You may need to invoke the function twice to make it work."
  (interactive)
  (setq whitespace-style (default-value 'whitespace-style))
  (setq whitespace-display-mappings (default-value 'whitespace-display-mappings))
  (whitespace-mode 'toggle))

(provide 'functions)
;;; functions.el ends here
