(setq user-full-name "Drew Ripberger"
      inhibit-startup-screen t
      make-backup-files nil)
(global-prettify-symbols-mode t)

(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq make-backup-files nil)
(setq auto-save-default nil)
(when window-system (add-hook 'prog-mode-hook 'hl-line-mode))
;; Line Numbers
(global-linum-mode t)
;; Removing Fringes
(set-face-attribute 'fringe nil
                    :foreground (face-foreground 'default)
                    :background (face-background 'default))
(set-face-background 'linum "#7e9bbb")

(add-to-list 'custom-theme-load-path "./themes")
(set-frame-parameter nil 'background-mode 'dark)
(load-theme 'oceanic t)
(add-hook 'after-make-frame-functions
        (lambda (frame)
	    (set-frame-parameter frame 'background-mode 'dark)
	    (set-terminal-parameter frame 'background-mode 'dark)
          (enable-theme 'oceanic)))
