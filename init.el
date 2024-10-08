(blink-cursor-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-hl-line-mode 1)
(column-number-mode 1)

(if (eq system-type 'windows-nt)
    (progn (set-message-beep 'silent)
           (setq org-directory "D:/Projects/Writings"))
  (setq org-directory "~/writings"))

(setq org-agenda-files (list org-directory)
      org-default-notes-file (expand-file-name "notes.org" org-directory))

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

(add-to-list 'load-path "~/.emacs.d/lisp")

;; Package list
(load "~/.emacs.d/packages.el")

;; Keymaps
(keymap-global-set "C-c w" #'my-center-current-buffer)
(keymap-global-set "C-c o a" #'org-agenda)
(keymap-global-set "C-c o c" #'org-capture)
(keymap-global-set "C-c o l" #'org-store-link)
(keymap-global-set "C-c o b"
                   (lambda ()
                     (interactive)
                     (dired org-directory)))
(keymap-global-set "C-c o s"
                   (lambda ()
                     (interactive)
                     (find-file (expand-file-name "short.org" org-directory))))

;; Capture templates
(setq org-capture-templates
      '(("t" "Todo"
         entry (file+headline "notes.org" "Tasks")
         "* TODO %?\n  %u")
        ("s" "Short story"
         entry
         (file+headline "short.org"
                        (lambda () (format-time-string "%a, %d %b %Y")))
         "** %?")))
;; Hooks
(add-hook 'org-capture-mode-hook #'evil-insert-state)
(add-hook 'emacs-lisp-mode-hook #'visual-line-mode)
(add-hook 'org-mode-hook #'visual-line-mode)

(setq initial-buffer-choice #'org-agenda-list)

;; On my mac 140 is small
(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :height 180))
