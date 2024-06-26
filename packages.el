;; Use `straight.el' with `use-package'
;; Don't use `package.el'

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-demand t)

(use-package elfeed
  :init
  (setq-default elfeed-search-filter "@3-months-ago +unread -news")
  :bind (("C-c e" . elfeed)))

(use-package org-journal
  :custom
  (org-journal-dir (concat (file-name-as-directory org-directory) "journal"))
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

(use-package evil
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
  ;; Turn it on
  (evil-mode))

(use-package catppuccin-theme
  :config
  (when (and (eq system-type 'windows-nt)
             (eq (w32-read-registry
                  'HKCU
                  "SOFTWARE/Microsoft/Windows/CurrentVersion/Themes/Personalize"
                  "AppsUseLightTheme")
                 0))
    (setq catppuccin-flavor 'macchiato)
    (catppuccin-reload)))
