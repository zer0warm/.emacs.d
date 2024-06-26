(blink-cursor-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(global-hl-line-mode 1)
(visual-line-mode 1)
(column-number-mode 1)
(auto-fill-mode 1)

(if (eq system-type 'windows-nt)
    (progn (set-message-beep 'silent)
           (setq org-directory "D:/Projects/Writings"
                 org-agenda-files (list "D:/Projects/Writings")))
  (progn (setq org-directory "~/writings"
               org-agenda-files (list "~/writings"))))

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

(keymap-global-set "C-c w" #'my-center-current-buffer)
