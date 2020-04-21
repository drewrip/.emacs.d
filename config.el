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

(package-install 'solarized-theme)
(require 'solarized-theme)
(load-theme 'solarized-dark t)

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

(setq initial-major-mode 'org-mode)
(setq org-ellipsis "⤵")
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(setq-default tab-width 4)

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

	    ;; YAML
	    (package-install 'yaml-mode)
(require 'yaml-mode)
