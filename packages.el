;; Use `straight.el' with `use-package'
;; Don't use `package.el'

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-demand t)

(require 'my-util)

(use-package elfeed
  :custom-face
  (elfeed-search-title-face ((t (:foreground "#000" :family "Cascadia Code"))))
  :init
  (setq-default elfeed-search-filter "@3-months-ago +unread -news")
  :bind (("C-c e" . elfeed)))

(use-package elfeed-org
  :config
  (setq rmh-elfeed-org-files (list (expand-file-name "feeds.org" org-directory)))
  (elfeed-org))

(use-package org-journal
  :custom
  (org-journal-dir (concat (file-name-as-directory org-directory) "journal"))
  (org-journal-date-format "%A, %d %B %Y")
  (org-journal-date-prefix "")
  (org-journal-time-prefix "* ")
  :bind (("C-c o j j" . org-journal-new-entry)))

(use-package org-roam
  :config
  (org-roam-db-autosync-mode)
  :custom
  (org-roam-directory (concat (file-name-as-directory org-directory) "roam"))
  :bind (("C-c o r n f" . org-roam-node-find)
         ("C-c o r n i" . org-roam-node-insert)
         ("C-c o r d c t" . org-roam-dailies-capture-today)
         ("C-c o r d g t" . org-roam-dailies-goto-today)))

(use-package catppuccin-theme
  :config
  (when (my-windows-use-dark-theme)
    (setq catppuccin-flavor 'macchiato)
    (catppuccin-reload)))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  ;; Don't use vi keys on these modes
  (let ((modes '(special-mode
                 Info-mode
                 help-mode
                 message-buffer-mode
                 elfeed-search-mode
                 elfeed-show-mode)))
    (dolist (mode modes)
      (evil-set-initial-state mode 'emacs)))
  ;; Mappings
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-define-key 'normal 'global
    (kbd "<leader>u") #'universal-argument)
  ;; Turn it on
  (evil-mode))
