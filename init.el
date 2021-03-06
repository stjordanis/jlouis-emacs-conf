;; init.el --- Initialization file for my Emacs setup
;;; Commentary:
;;;
;;; One large configuration file
;;;
;;; Things to check out:
;;;
;;; - phi-search
;;; - multiple-cursors
;;; - mc-extras
;;; - phi-search-mc
;;; - nix-mode nix-sandbox nix-buffer
;;; - edts (Erlang)
;;; - winner
;;; 

;; Set up system-specific stuff first.

(defconst emacs-start-time (current-time))

(defvar erlang-root-dir "/usr/local/lib/erlang"
  "Root directory of the Erlang subsystem.")
(defvar erlang-tools-version "3.0.1"
  "Version of the Erlang Tools.")

;;; package.el configuration
;;; Code:
(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(cond
 ((eq system-type 'gnu/linux)
  (progn
    (setq erlang-root-dir "/home/jlouis/.nix-profile/lib/erlang")
    (setq erlang-tools-version "3.0.1")
    ((lambda (font)
       (set-frame-font font)
       (set-face-attribute 'default nil
                           :font font
                           :height 140
                           :weight 'normal)
       (set-face-font 'default font))
     "Go Mono")))
 ((eq system-type 'darwin)
  (progn
    (setq erlang-tools-version "3.0.1")
    (setq ocaml-ver "4.05.0")
    (push "/usr/local/bin" exec-path)
    (push "/usr/local/sbin" exec-path)
    (push "/Library/TeX/texbin" exec-path)
    (push "/usr/bin" exec-path)
    (push "/usr/sbin" exec-path)
    (push (concat "/Users/jesperlouisandersen/.opam/" ocaml-ver "/bin") exec-path)
    (push "/Users/jesperlouisandersen/.cabal/bin" exec-path)
    (push "/Users/jesperlouisandersen/bin" exec-path)
    (push "/Users/jesperlouisandersen/go/bin" exec-path)
    (setenv "PATH"
            (concat "/usr/local/bin:/usr/local/sbin:"
                    "/Users/jesperlouisandersen/go/bin:"
                    "/Users/jesperlouisandersen/.cabal/bin:"
                    (concat "/Users/jesperlouisandersen/.opam/" ocaml-ver "/bin:")
                    "/Users/jesperlouisandersen/.opam/4.05.0/bin:"
                    "/Users/jesperlouisandersen/bin:"
                    "/usr/texbin:" (getenv "PATH")))
    (setenv "ERL_LIBS"
            (concat "/Users/jesperlouisandersen/lib/erlang"))
    ((lambda (font)
       (set-frame-font font)
       (set-face-attribute 'default nil
                           :font font
                           :height 160
                           :weight 'normal)
       (set-face-font 'default font))
     "Go Mono"))))

;; Paths, sir, paths!
(setq emacs-config-dir (file-name-directory
                        (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path (concat emacs-config-dir "/lisp/"))
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")

(setq autoload-file (concat emacs-config-dir "loaddefs.el"))
(setq site-root (concat emacs-config-dir "/site/"))
(setq custom-file (concat emacs-config-dir "custom.el"))
(setq package-user-dir (concat emacs-config-dir "elpa"))
(setq abbrev-file-name (concat emacs-config-dir "abbrev_defs"))
(defconst *emacs-config-dir* (concat emacs-config-dir "/configs/" ""))

(setq exec-path (cons (concat erlang-root-dir "/bin")
                      exec-path))

;; Setup a theme, it is a solarized variant
(add-to-list 'custom-theme-load-path
	     (concat emacs-config-dir "themes/"))
(setq custom-safe-themes t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; ----------------------------------------------------------------------
;; USE-PACKAGE

(require 'use-package)

(if init-file-debug
      (setq use-package-verbose t
            use-package-expand-minimally nil
            use-package-compute-statistics t
            debug-on-error t)
    (setq use-package-verbose nil
          use-package-expand-minimally t))

(use-package emacs
  :delight
  (visual-line-mode))

(use-package server
  :unless (or noninteractive)
  :no-require
  :hook (after-init . server-start))

(use-package material-theme
  :ensure t)

;; Personal configuration package
(use-package personal
  :demand t
  :bind
  (("C-x C-c" . dont-kill-emacs)
   ("M-g" . goto-line)
   ("M-'" . jump-to-mark)
   ("C-'" . push-mark-no-activate)
   ("C-w" . backward-kill-word)
   ("C-x C-k" . kill-region)
   ("C-c C-k" . kill-region)
   ("C-x C-i" . imenu)

   ("C-c c" . compile)
   ("C-c j" . join-line)
   ("C-c |" . align))

  :config
  (setq compilation-skip-threshold 2)
  (delete-selection-mode 1))

;; ------------------------------------------------------------
;; General packages
(use-package abbrev
  :delight)

(use-package align
  :defer 5)

(use-package autorevert
  :delight auto-revert-mode)

(use-package avy
  :ensure t
  :bind* ("C-." . avy-goto-char-timer)
  :config
  (avy-setup-default))

(use-package avy-zap
  :ensure t
  :bind (("M-z" . avy-zap-up-to-char-dwim)
         ("M-Z" . avy-zap-to-char-dwim)))

(use-package change-inner
  :ensure t
  :bind (("M-i" . change-inner)
         ("M-o M-o" . change-outer)))

(use-package company
  :ensure t
  :delight

  :config
  (setq company-idle-delay 0.5)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)

  (setq company-tooltip-flip-when-above t)
  (global-company-mode 1)
  (define-key company-active-map [tab] nil)
  (define-key company-active-map (kbd "TAB") nil)
  (define-key company-active-map (kbd "C-w") 'backward-kill-word) )

(use-package company-erlang
  ;; Will call up a file-search dialog if it cannot find the project
  ;; I really dislike this as it has interfered with my general workflow
  ;; more than once, so it is disabled for now
  :disabled t)

(use-package counsel
  :ensure t
  :after (ivy)

  :bind
  ("C-c r" . counsel-git-grep)
  ("C-c C-r" . ivy-resume)
  ("C-c f" . counsel-git)
  ("M-x" . counsel-M-x)
  ("M-s f" . counsel-file-jump)
  ("C-x C-f" . counsel-find-file)
  ("C-x C-r" . counsel-recentf))

(use-package delight
  :ensure t

  :config
  (delight '((auto-fill-function " AF" t))))

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode))

(use-package eldoc
  :delight eldoc-mode)

(use-package eshell
  :commands (eshell eshell-command))

(use-package expand-region
  :ensure t
  :bind
  (("C-=" . er/expand-region)))

(use-package ffap
  :bind ("C-c v" . ffap))

(use-package fill-column-indicator
  :ensure t)

(use-package flx
  :ensure t)

(use-package flycheck
  :ensure t
  :delight

  :init (global-flycheck-mode)
  :config

  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

(use-package flycheck-color-mode-line
  :ensure t
  :delight

  :after (flycheck)
  :hook (flycheck-mode-hook . flycheck-color-mode-line-mode))

(use-package hippie-expand
  :init
  (setq hippie-expand-try-functions-list
        '(try-complete-file-name-partially
          try-complete-file-name
          try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill))
  :bind
  ("M-/" . hippie-expand))

(use-package iedit
  :ensure t)

(use-package imenu
  :demand t)

(use-package ivy
  :ensure t
  :delight

  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package magit
  :ensure t
  :after (diff-hl)

  :bind
  ("C-c g" . magit-status)

  :hook
  (magit-post-refresh-hook . diff-hl-magit-post-refresh)

  :config
  (setq-default magit-diff-refine-hunk 1))

(use-package magit-popup
  :ensure t)

(use-package magit-todos
  :ensure t
  :after (magit)

  :config
  (magit-todos-mode))

(use-package midnight
  :bind ("C-c z" . clean-buffer-list))

(use-package multi-line
  :ensure t

  :bind
  ("C-c d" . multi-line))

(use-package perspective
  :ensure t
  :config
  (persp-mode 1))

(use-package powerline
  :ensure t)

(use-package recentf
  :config
  (recentf-mode 1))

(use-package restclient
  :mode ("\\.rest\\'" . restclient-mode)
  :ensure t)

(use-package saveplace
  :demand t
  :config
  (save-place-mode 1))

(use-package smart-mode-line
  :ensure t
  :config
  ;; See https://github.com/Malabarba/smart-mode-line/issues/217
  (setq mode-line-format (delq 'mode-line-position mode-line-format))
  (sml/setup)
  (sml/apply-theme 'dark)
  (remove-hook 'display-time-hook 'sml/propertize-time-string))

(use-package smart-mode-line-powerline-theme
  :ensure t
  :disabled t
  :after smart-mode-line
  :config
  (sml/apply-theme 'powerline))

(use-package smartparens-config
  :ensure smartparens
  :delight

  :commands smartparens-mode)

(use-package smex
  :ensure t

  :config
  (setq smex-save-file
      (concat user-emacs-directory ".smex-items")))

(use-package swiper
  :ensure t
  :after (ivy)

  :bind
  ("C-s" . swiper))

(use-package thingatpt
  :demand t)

(use-package tramp
  :config
  (setq tramp-default-method "sshx")

  (add-to-list 'tramp-default-method-alist
	       '("\\`localhost\\'" "\\`root\\'" "su"))
  (add-to-list 'tramp-default-method-alist '("" "jlouis" "ssh"))
  (add-to-list 'tramp-default-method-alist '("" "jla" "ssh"))
  (add-to-list 'tramp-default-method-alist '("" "root" "ssh"))

  (tramp-set-completion-function "ssh"
			         '((tramp-parse-sconfig "/etc/ssh_config")
				   (tramp-parse-sconfig "~/.ssh/config"))))

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'reverse
        uniquify-separator "/"
        uniquify-after-kill-buffer-p t
        uniquify-ignore-buffers-re "^\\*"))

(use-package wgrep
  :ensure t)

(use-package whitespace-cleanup-mode
  :ensure t
  :delight

  :config
  (global-whitespace-cleanup-mode t))

(use-package yasnippet
  :ensure t
  :delight yas-minor-mode

  :config
  (progn
    (yas-global-mode 1)
    (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
    (defun yas/goto-end-of-active-field ()
      (interactive)
      (let* ((snippet (car (yas-active-snippets)))
             (position (yas--field-end (yas--snippet-active-field snippet))))
        (if (= (point) position)
            (move-end-of-line 1)
          (goto-char position))))

    (defun yas/goto-start-of-active-field ()
      (interactive)
      (let* ((snippet (car (yas-active-snippets)))
             (position (yas--field-start (yas--snippet-active-field snippet))))
        (if (= (point) position)
            (move-beginning-of-line 1)
          (goto-char position))))

    (define-key yas-keymap (kbd "C-e") 'yas/goto-end-of-active-field)
    (define-key yas-keymap (kbd "C-a") 'yas/goto-start-of-active-field)
    ;;(setq yas-prompt-functions '(yas-ido-prompt yas-completing-prompt))
    ;;(setq yas-verbosity 1)
    (setq yas-wrap-around-region t)))

;; ------------------------------------------------------------
;; File Modes

(use-package csv-mode
  :mode "\\.csv\\'")

(use-package dockerfile-mode
  :ensure t)

(use-package elm-mode
  :ensure t)

(use-package erlang-start
  :load-path (lambda ()
               (concat erlang-root-dir "/lib/tools-" erlang-tools-version "/emacs"))
  :config
  (add-hook 'erlang-mode-hook #'smartparens-mode))

(use-package ess
  :ensure t)

(use-package go-mode
  :ensure t
  ;; go get -u github.com/x/tools/cmd/...
  ;; go get -u github.com/rogpeppe/godef/...
  ;; go get -u github.com/nsf/gocode
  ;; go get -u golang.org/x/tools/cmd/goimports
  ;; go get -u golang.org/x/tools/cmd/guru
  ;; go get -u github.com/dougm/goflymake

  :hook (before-save-hook . gofmt-before-save)
  :config
  (setq-local compile-command "go build -v && go test -v && go vet")
  (set
   (make-local-variable 'company-backends)
   '(company-go))
  (subword-mode 1)
  (setq gofmt-command "goimports"))

(use-package go-eldoc
  :ensure t

  :config
  (go-eldoc-setup))

(use-package graphql-mode
  :ensure t

  :config
  (setq graphql-indent-level 4)
  (subword-mode 1))

(use-package idris-mode
  :ensure t)

(use-package json
  :ensure t)

(use-package js2-mode
  :ensure t

  :config
  (autoload 'js2-mode "js2" nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)) )

(use-package markdown-mode
  :ensure t)

(use-package merlin
  :ensure t
  :after (tuareg)

  :config
  (let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
    (when (and opam-share (file-directory-p opam-share))
      ;; Register Merlin
      (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
      (autoload 'merlin-mode "merlin" nil t nil)
      ;; Automatically start it in OCaml buffers
      (add-hook 'tuareg-mode-hook 'merlin-mode t)
      (add-hook 'caml-mode-hook 'merlin-mode t)
      ;; Use opam switch to lookup ocamlmerlin binary
      (setq merlin-command 'opam))) )

(use-package tuareg
  :ensure t)

;; ------------------------------------------------------------
;; Org
(use-package org
  :ensure t

  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c n" . org-iswitchb)
  ("C-c s" . org-capture)

  :config
  (add-to-list 'auto-mode-alist '("\\.org$'" . org-mode))
  (setq org-directory "~/org")
  (setq org-agenda-files '("~/org"))
  (setq org-default-notes-file (concat org-directory "/todo.org"))

  (setq org-todo-keywords '((type "TODO" "NEXT" "WAITING" "DONE")))

  ;; #+SEQ_TODO: TODO | DONE
  ;; #+SEQ_TODO: REPORT BUG KNOWNCAUSE | FIXED
  ;; #+SEQ_TODO: | CANCELLED

  (setq org-agenda-custom-commands
        '(("w" todo "WAITING" nil)
          ("n" todo "NEXT" nil)
          ("d" "Agenda + Next Actions" ((agenda) (todo "NEXT")))))

  (setq org-archive-location "%s_archive::")

  (setq org-reverse-note-order t)         ; Dump notes at the beginning by def.
  (setq org-default-notes-file "~/org/remember.org")
  (setq remember-annotation-functions '(org-remember-annotation))
  (setq remember-handler-functions '(org-remember-handler))

  (setq org-refile-use-outline-path 'file)
  (setq org-refile-targets '((org-agenda-files :level . 1)))

  (setq org-capture-templates
        '(("i" "Inbox" entry (file+headline "inbox.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("j" "Journal" entry (file+datetree "journal.org")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("k" "Kwotes" item (file+headline "quotes.org")
           "Unsorted Quotes")))

  (setq org-return-follows-link t)
  (setq org-hide-leading-stars t)
  (setf org-tags-column -65)
  (setf org-special-ctrl-a/e t)

  (setq org-log-done t)
  (setq org-deadline-warning-days 14)
  (setq org-fontify-emphasized-text t)
  (setq org-fontify-done-headline t)
  (setq org-agenda-include-all-todo nil)
  (setq org-export-with-section-numbers nil)
  (setq org-export-with-toc nil)
  (setq org-adapt-indentation nil)

  ;; widen category field a little
  (setq org-agenda-prefix-format "  %-17:c%?-12t% s") )

;; Get our custom configuration loaded
(load custom-file 'noerror)
(load-theme 'material)

(add-hook 'after-init-hook
          `(lambda ()
             (let ((elapsed
                    (float-time
                    (time-subtract (current-time) emacs-start-time))))
               (message "Loading %s...done (%.3fs)) [after-init]"
                        ,load-file-name elapsed)))
          t)

;;; init.el ends here
