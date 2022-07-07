;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;NOTE the default note lines are removed, but they can be viewed by using git
(setq user-full-name "Leonardo Zarkli"
      user-mail-address "ziqi-yang@gmail.com")

;; (setq doom-theme 'doom-gruvbox-light)
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-gruvbox
      doom-font (font-spec :family "Fira Code" :size 40) ;; :wight light
      ;; + `doom-variable-pitch-font'
      ;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
      )
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t) ;; frameless
;; (setq initial-frame-alist (quote ((fullscreen . maximized))))
;; (add-hook 'window-setup-hook 'toggle-frame-maximized t)
;; (add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; also works with emacsclient
(setq fancy-splash-image "/home/zarkli/.doom.d/resources/2_mod.png")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/notes/org/")
(setq org-noter-notes-search-path '("~/Documents/notes/org/"))

(setq display-line-numbers-type 'relative)




;; (add-hook! python-mode
;;   (setq python-shell-interpreter "ipython"))
(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))


(setq evil-escape-delay 1.0)
(setq evil-escape-key-sequence "kk") ;; use kk to exit insert mode
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

(setq scroll-margin 14) ;; like scrolloff in vim
(setq scroll-conservatively 1) ;; it seems already opened in doom emacs

;; 在 init.el 下的 completion 栏目下的 vertico 开启了之后
;; which-key 的 c-h 变成了 竖直列出按键，感觉不如分页好，这里做下修改
;; (setq which-key-side-window-max-height 0.3) ;; 使得一页可以容下主菜单所有分类
(setq which-key-use-C-h-commands t) ;; 变回c-h用作分页


(global-visual-line-mode t) ;; word wrap

(setq company-idle-delay 0.2) ;; 自动补全延迟时间

(plist-put! +ligatures-extra-symbols
  :true          "✓"
  :false         "✗"
  :str           "⟆"
  :list          "⧻"
)

(add-hook 'org-mode-hook 'org-hide-block-all) ;; hide code/quote/... blocks
(after! ispell (setq ispell-alternate-dictionary "~/.doom.d/ispell/english-words.txt"))
(setq which-key-idle-delay 0.5)
;; (setq yas-triggers-in-field t) ;; :editor snippets ; allow nested snippets


(defun chunyang-toggle-frame-transparency ()
  (interactive)
  (if (equal (frame-parameter nil 'alpha) 75)
      (set-frame-parameter nil 'alpha 100)
    (set-frame-parameter nil 'alpha 75)))

(defun my-code-run-alacritty()
  (interactive)
  (if (equal major-mode 'python-mode)
      ;; python language
      (let (
        (shell "/usr/bin/fish")
        (tmpSourceFile (expand-file-name ".my-code-run-alacritty.py"))
        (command (concat "time python " (expand-file-name ".my-code-run-alacritty.py") " ; echo ------------------------------ ; echo -e [Use \033[33mCtrl-Shift-Space\033[0m to toggle vi mode] ; read -P '[Press \033[33mENTER\033[0m key to exit]'"))
        )
        ;; (write-region "import time\nSTARTTIME=time.time()\n\n" nil tmpSourceFile)
        (write-region "" nil tmpSourceFile)
        (write-region nil (point-max) tmpSourceFile t)
        ;; (write-region "\nENDTIME=time.time()\nprint('\\n\\n')\nprint('-'*30)\nprint('\033[33mTotal Time\033[0m: {}\033[33ms\033[0m'.format(ENDTIME-STARTTIME))\n" nil tmpSourceFile t)
        (start-process-shell-command "my-code-run-alacritty" "*my-buffer*" (concat "alacritty -e " shell " -c \"" command "\"" "; rm " tmpSourceFile))
        ))
   ;; golang
  (if (equal major-mode 'go-mode)
      ;;   go run *.go
      (start-process-shell-command "my-code-run-alacritty" "*my-buffer*" (concat "alacritty -e " "/usr/bin/fish" " -c \"" (concat "go run " (file-name-directory buffer-file-name)) "/*.go"  " ; echo \n;echo ------------------------------ ; echo -e [Use \033[33mCtrl-Shift-Space\033[0m to toggle vi mode] ; read -P '[Press \033[33mENTER\033[0m key to exit]'" "\""))
    )
    ;; c language
    (if (equal major-mode 'c-mode)
        (let ( (tmpfile "/tmp/my-code-run-alacritty.sh")
               (tmpExecutefile "/tmp/my-code-run-py-alacritty")
               (tmpSourceFile "/tmp/my-code-run-alacritty.c"))
          (write-region nil (point-max) tmpSourceFile)
          (write-region (concat "clang " tmpSourceFile " -o " tmpExecutefile " -fcolor-diagnostics\n" tmpExecutefile "\necho\necho -----------------------------\necho [Use Ctrl-Shift-Space to toggle vi mode]\nread -p \"[Press ENTER key to exit]\"\n") nil tmpfile)
          (shell-command (concat "chmod +x " tmpfile))
          ;; (shell-command (concat "alacritty --command " tmpfile))
          (start-process-shell-command "my-code-run-alacritty" "*my-buffer*" (concat "alacritty --command " tmpfile))
          )
                )
    (if (equal major-mode 'c++-mode)
        (let ((shell "/usr/bin/fish")
              (tmpExecutefile "/tmp/my-code-run-cpp-alacritty")
               (tmpSourceFile (expand-file-name ".my-code-run-alacritty.cpp"))
               (command (concat "clang++ " (expand-file-name ".my-code-run-alacritty.cpp") " -o  /tmp/my-code-run-cpp-alacritty && time /tmp/my-code-run-cpp-alacritty; echo ------------------------------ ; echo -e [Use \033[33mCtrl-Shift-Space\033[0m to toggle vi mode] ; read -P '[Press \033[33mENTER\033[0m key to exit]'")))
                (write-region "" nil tmpSourceFile)
                (write-region nil (point-max) tmpSourceFile)
                ;; (shell-command (concat "alacritty --command " tmpfile))
                (start-process-shell-command "my-code-run-alacritty" "*my-buffer*" (concat "alacritty -e " shell " -c \"" command "\"" "; rm " tmpSourceFile))
                        )
      )
)


(defun my-translator-alacritty()
  (interactive)
  (setq my-tmpV-translator-bounds (bounds-of-thing-at-point 'word))
  (setq my-tmpV-translator-pos1 (car my-tmpV-translator-bounds))
  (setq my-tmpV-translator-pos2 (cdr my-tmpV-translator-bounds))
  (setq my-tmpV-translator-mything (buffer-substring-no-properties my-tmpV-translator-pos1 my-tmpV-translator-pos2))
  (setq my-tmpV-translator-commands (concat "echo " my-tmpV-translator-mything " ; ydict -c -v 1 " my-tmpV-translator-mything " ; echo ------------------------------ ; echo [Use Ctrl-Shift-Space to toggle vi mode] ; read -P '[Press ENTER key to exit]'"))
  (start-process-shell-command "my-translator" "*my-buffer*" (concat "alacritty -e /usr/bin/fish -c \"" my-tmpV-translator-commands "\""))
    )

(defun my-code-test-file()
  (interactive)
  (if (equal major-mode 'python-mode)
      ;; python mode
      (message "[python test file]")
      (find-file "/home/zarkli/test/1.py")
      )
  )

(defun open-alacritty-in-folder()
  (interactive)
  (start-process-shell-command "open-alacritty-in-folder" "*alacritty*" (concat "alacritty --working-directory " (file-name-directory buffer-file-name))
                               )
  )

;; Key Settings
(map!
 (:after org
  :leader
  (:prefix "z"
  :n "oh" #'my-org-hight-math-keywords))
  ;; :n "qweqweq" "asdasda"
 :leader
 (:prefix "z"
  :n
  "p" "\"+P"
  "yw" ":%y+"
  "be" ":%d"
  "\\" #'chunyang-toggle-frame-transparency
  "v" #'vterm-other-window
  "z" #'open-alacritty-in-folder
  ;; cc #'my-code-run-py-interactively
  "ca" #'my-code-run-alacritty
  "ct" #'my-code-test-file
  "cc" #'conda-env-activate
  "cl" #'lsp-ui-imenu
  "tt" #'my-translator-alacritty
  "ta" #'my-translator-alacritty
  "ty" #'popweb-dict-youdao-pointer
  "tb" #'popweb-dict-bing-pointer

  :v
  "yy" "\"+y"
  "es" #'evil-surround-edit
))

(use-package! which-key
  :config
  (which-key-add-key-based-replacements
    "<SPC>z" "mine"
    "<SPC>zt" "translate"
    "<SPC>zc" "code"
    "<SPC>zp" "paste(clip)"
    "<SPC>zy" "copy"
    "<SPC>zyy" "copy(clip)"
    "<SPC>zyw" "copy-whole-buffer(clip)"
    "<SPC>zb" "buffer"
    "<SPC>zbe" "erase-buffer"
    "<SPC>ze" "evil"
    "<SPC>zo" "org"
    "<SPC>zo" "my-org-map"
    "<SPC>zop" "reveal.js"
    "<SPC>zol" "latex"))



(add-hook! 'python-mode-hook #'rainbow-delimiters-mode)


;; c/c++
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
