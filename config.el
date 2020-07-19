(unless (package-installed-p 'use-package)
      (package-refresh-contents)
      (package-install 'use-package))

    (require 'use-package)
    (setq use-package-always-ensure t)

(use-package htmlize)
    (use-package org-bullets)
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq user-full-name "Drew Ripberger"
      inhibit-startup-screen t
      make-backup-files nil)
(global-prettify-symbols-mode t)

(use-package nord-theme)
(load-theme 'nord t)

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

(use-package all-the-icons)
(unless (member "all-the-icons" (font-family-list))
  (all-the-icons-install-fonts t))

(use-package neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(global-set-key (kbd "C-x <prior>") 'neotree-toggle)

(setq org-todo-keywords
	'((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)")))
(setq initial-major-mode 'org-mode)
(setq org-ellipsis "⤵")
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(global-prettify-symbols-mode t)
(setq org-directory "~/Dropbox/org")
(setq org-agenda-files (directory-files-recursively "~/Dropbox/org/" "\\.org$"))
(setq org-default-notes-file (concat org-directory "/notes.org"))
(global-set-key (kbd "C-c a") 'org-agenda)
(setq initial-buffer-choice (concat org-directory "/notes.org"))

(setq-default tab-width 4)

;;Golang
(use-package go-mode)

;;Rust
(use-package rust-mode)

;;Haskell
(use-package haskell-mode)

;;Latex

(use-package auctex
  :defer t
  :ensure t)
(use-package company-auctex)

(company-auctex-init)
(setq tex-run-command "pdflatex")

(defun flymake-get-tex-args (file-name)
  (list "pdflatex"
		(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

;; YAML
(use-package yaml-mode)
