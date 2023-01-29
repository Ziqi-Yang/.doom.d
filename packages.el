;;; utils
(package! lsp-ltex) ;; I bind it to org mode and latex to do grammar check, however, it costs at sometimes
(package! wakatime-mode) ;; interact with wakatime to record your programming stastics
(package! beacon) ;; highlight the cursor whenever the window scrolls
;; (package! screenshot ;;; doesn't work well on my computer
;;   :recipe (:host github :repo "tecosaur/screenshot"))

;; org
(package! org-modern)
(package! org-auto-tangle) ;; add '#+auto_tangle: t' to automatically tangle file when saving

;; programming language
(package! yuck-mode) ;; edit yuck file (eww)

;; UI
(package! nyan-mode) ;; bottom bar nyan cat
(package! circadian) ;; theme-switching based on daytime
