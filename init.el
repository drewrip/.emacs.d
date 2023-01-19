;;; init.el --- Global settings -*- lexical-binding: t; -*-

;;; Commentary:

;; Here be dragons

;;; Code:

;; List package archives and initialize them
;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)


;; (package-initialize)
;; (when (not package-archive-contents)
;;   (package-refresh-contents))

;; Make sure use-package is installed
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))


(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Simple UI Tweaks => Scroll bar, tool bar, etc
;; Do not show the startup screen.
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq initial-scratch-message "") ; When opening a new buffer, don't show the scratch message.
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq ring-bell-function 'ignore)

;; Stopping the litter of backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; Highlight current line.
(global-hl-line-mode t)

;; Show line numbers
(global-linum-mode 1)

;; All the icons dependency for treemacs
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

;; Treemacs for file navigation
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(with-eval-after-load 'doom-themes
  (doom-themes-treemacs-config))

;; Theme
;; Using the Doom Colors theme from Doom Emacs
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
          
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


;; Programming and Markup Languages!

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :config
  (add-to-list 'company-backends 'company-capf)
  (global-company-mode))

(use-package company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends))

(use-package flycheck :ensure)

;; Rust
(use-package rustic :ensure
  :custom
  (rustic-lsp-server 'rust-analyzer)
  :bind (:map rustic-mode-map
    ("M-j" . lsp-ui-imenu)
    ("M-?" . lsp-find-references)
    ("C-c C-c l" . flycheck-list-errors)
    ("C-c C-c a" . lsp-execute-code-action)
    ("C-c C-c r" . lsp-rename)
    ("C-c C-c q" . lsp-workspace-restart)
    ("C-c C-c Q" . lsp-workspace-shutdown)
    ("C-c C-c s" . lsp-rust-analyzer-status)))

;; Go
(use-package go-mode)

;; Python

(use-package python-mode
  :ensure)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
    (require 'lsp-pyright)
    (lsp))))

;; C

(setq-default c-basic-offset 4)

;; Markdown
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "pandoc"))

;; YAML
(use-package yaml-mode)

;; Setting up LSP
(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  ;; I believe that we should only need hooks for packages/languages that don't
  ;; provide their own
  ;; :hook
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

(setq lsp-keymap-prefix "c-c l")
(add-hook 'python-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (doom-themes use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
