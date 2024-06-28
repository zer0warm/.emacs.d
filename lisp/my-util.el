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

(defun my-center-current-buffer ()
  "Center the current buffer in the current frame, limiting width to
`fill-column'."
  (interactive)
  (let ((margin (/ (- (frame-width) fill-column) 2)))
    (set-window-margins nil margin margin)))

(provide 'my-util)
