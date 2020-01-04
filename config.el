(package-refresh-contents)
(package-install 'htmlize)
(require 'htmlize)
(package-install 'org-bullets)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq user-full-name "Drew Ripberger"
      inhibit-startup-screen t
      make-backup-files nil)
(global-prettify-symbols-mode t)

(setq custom-theme-directory (concat user-emacs-directory "themes"))
(load-theme 'oceanic t)
(add-hook 'after-make-frame-functions
        (lambda (frame)
	    (set-frame-parameter frame 'background-mode 'dark)
	    (set-terminal-parameter frame 'background-mode 'dark)
          (enable-theme 'oceanic)))

(if (display-graphic-p)
  (progn
    (tool-bar-mode -1)
    (scroll-bar-mode -1))
    (horizontal-scroll-bar-mode -1))
(menu-bar-mode -1)
(setq make-backup-files nil)
(setq auto-save-default nil)
(fringe-mode 12)
;; Line Numbers
(add-hook 'prog-mode-hook 'linum-mode)
;; Removing Fringes
(set-face-attribute 'fringe nil
                    :foreground (face-foreground 'default)
                    :background (face-background 'default))

;;Golang
  (package-install 'go-mode)
  (require 'go-mode)

  ;;Rust
  (package-install 'rust-mode)
  (require 'rust-mode)

  ;;Haskell
  (package-install 'haskell-mode)
  (require 'haskell-mode)

  ;;Latex

      (package-install 'auctex)
      (package-install 'company-auctex)

      (require 'tex)
      (require 'company-auctex)

      (company-auctex-init)
  (setq tex-run-command "pdflatex")

(defun flymake-get-tex-args (file-name)
(list "pdflatex"
(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))
