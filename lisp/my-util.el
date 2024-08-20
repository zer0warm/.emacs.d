(defun my-windows-use-dark-theme ()
  "Query registry and check if windows is using dark theme. Returns t if it is,
nil otherwise."
  (if (and (eq system-type 'windows-nt)
           (eq (w32-read-registry
                'HKCU
                "SOFTWARE/Microsoft/Windows/CurrentVersion/Themes/Personalize"
                "AppsUseLightTheme")
               0))
      t
    nil))

(defun my-macos-use-dark-theme ()
  "Query defaults and check if macOS is using dark theme. Returns t if it is,
nil otherwise."
  (if (and (eq system-type 'darwin)
           (string-equal (shell-command-to-string
                          "defaults read -g AppleInterfaceStyle 2>/dev/null")
                         "Dark\n"))
      t
    nil))

(defun my-linux-use-dark-theme ()
  "Query GTK settings and use its value. Returns t if true, nil otherwise."
  (if (and (eq system-type 'gnu/linux)
           (string-equal (shell-command-to-string
                          "gtk-query-settings | grep 'prefer-dark-theme' | grep -o TRUE")
                         "TRUE\n"))
      t
    nil))

(defun my-center-current-buffer ()
  "Center the current buffer in the current frame, limiting width to
`fill-column'."
  (interactive)
  (let ((margin (/ (- (frame-width) fill-column) 2)))
    (set-window-margins nil margin margin)))

(provide 'my-util)
