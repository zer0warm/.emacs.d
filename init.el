(blink-cursor-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(set-message-beep 'silent)
(global-hl-line-mode)

(defun edit-init-el ()
  "Find and open init.el"
  (interactive)
  (find-file (locate-user-emacs-file "init.el")))
(keymap-global-set "C-c i" #'edit-init-el)

;; Custom options and faces
(load "~/.emacs.d/emacs-custom.el")

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Package list
(load "~/.emacs.d/packages.el")

;; Elfeed's feed list
(load "~/.emacs.d/feeds.el")

(require 'evil)
(evil-mode t)

;; Don't use vi keys
(let ((modes '(special-mode
               Info-mode
               help-mode
               message-buffer-mode
               elfeed-search-mode
               elfeed-show-mode)))
  (dolist (mode modes)
    (evil-set-initial-state mode 'emacs)))

(require 'org-roam)
(require 'org-journal)

(if (eq system-type 'windows-nt)
    (setq org-directory "D:/Projects/Writings")
  (setq org-directory "~/writings"))

(setq org-roam-directory (concat org-directory "/roam")
      org-journal-dir (concat org-directory "/journal"))

;; Automatically keep org-roam session in sync
(org-roam-db-autosync-mode)

(keymap-global-set "C-c j j" #'org-journal-new-entry)
(keymap-global-set "C-c r n i" #'org-roam-node-insert)
(keymap-global-set "C-c r n f" #'org-roam-node-find)
(keymap-global-set "C-c r d c t" #'org-roam-dailies-capture-today)
(keymap-global-set "C-c r d g t" #'org-roam-dailies-goto-today)
(keymap-global-set "C-c e" #'elfeed)
