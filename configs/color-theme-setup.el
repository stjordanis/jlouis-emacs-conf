; Color Theme
(require 'color-theme)
;(color-theme-initialize)


(defun color-theme-jlouis ()
  "Knuth's fvwm colors combined with tweaked deep-blue"
  (interactive)
  (color-theme-install
   '(color-theme-jlouis
     ((background-color . "#00002b")
      (background-mode . dark)
      (border-color . "black")
      (cursor-color . "green")
      (foreground-color . "#ffe97a")
      (mouse-color . "white"))
     ((browse-kill-ring-separator-face . bold)
      (display-time-mail-face . mode-line)
      (help-highlight-face . underline)
      (list-matching-lines-face . secondary-selection)
      (vc-annotate-very-old-color . "#0046FF")
      (view-highlight-face . highlight)
      (widget-mouse-face . highlight))
     (default ((t (:stipple nil :background "#102e4e" :foreground "#eeeeee" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :width normal :family "misc-fixed"))))
     (Info-title-1-face ((t (:bold t :weight bold :family "helv" :height 1.728))))
     (Info-title-2-face ((t (:bold t :family "helv" :weight bold :height 1.44))))
     (Info-title-3-face ((t (:bold t :weight bold :family "helv" :height 1.2))))
     (Info-title-4-face ((t (:bold t :family "helv" :weight bold))))
     (bold ((t (:bold t :weight bold))))
     (bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
     (border ((t (:background "black"))))
     (calendar-today-face ((t (:background "blue"))))
     (change-log-acknowledgement-face ((t (:italic t :slant italic :foreground "CadetBlue"))))
     (change-log-conditionals-face ((t (:foreground "SeaGreen2"))))
     (change-log-date-face ((t (:foreground "#ad7fa8"))))
     (change-log-email-face ((t (:foreground "SeaGreen2"))))
     (change-log-file-face ((t (:bold t :weight bold :foreground "goldenrod"))))
     (change-log-function-face ((t (:foreground "SeaGreen2"))))
     (change-log-list-face ((t (:bold t :weight bold :foreground "#729fcf"))))
     (change-log-name-face ((t (:foreground "gold"))))
     (comint-highlight-input ((t (:bold t :weight bold))))
     (comint-highlight-prompt ((t (:foreground "cyan"))))
     (cursor ((t (:background "green" :foreground "black"))))
     (cvs-filename-face ((t (:foreground "lightblue"))))
     (cvs-handled-face ((t (:foreground "pink"))))
     (cvs-header-face ((t (:bold t :foreground "lightyellow" :weight bold))))
     (cvs-marked-face ((t (:bold t :foreground "green" :weight bold))))
     (cvs-msg-face ((t (:italic t :slant italic))))
     (cvs-need-action-face ((t (:foreground "orange"))))
     (cvs-unknown-face ((t (:foreground "red"))))
     (diary-face ((t (:foreground "orange red"))))
     (diff-added-face ((t (nil))))
     (diff-changed-face ((t (nil))))
     (diff-context-face ((t (:foreground "grey70"))))
     (diff-file-header-face ((t (:bold t :background "grey60" :weight bold))))
     (diff-function-face ((t (:foreground "grey70"))))
     (diff-header-face ((t (:background "grey45"))))
     (diff-hunk-header-face ((t (:background "grey45"))))
     (diff-index-face ((t (:bold t :weight bold :background "grey60"))))
     (diff-nonexistent-face ((t (:bold t :weight bold :background "grey60"))))
     (diff-removed-face ((t (nil))))
     (fixed-pitch ((t (:family "fixed"))))
     (font-latex-bold-face ((t (:bold t :foreground "OliveDrab" :weight bold))))
     (font-latex-italic-face ((t (:italic t :foreground "OliveDrab" :slant italic))))
     (font-latex-math-face ((t (:foreground "#ad7fa8"))))
     (font-latex-sedate-face ((t (:foreground "LightGray"))))
     (font-latex-string-face ((t (:foreground "LightSalmon"))))
     (font-latex-warning-face ((t (:bold t :foreground "Pink" :weight bold))))
     (font-lock-builtin-face ((t (:foreground "LightCoral"))))
     (font-lock-comment-face ((t (:italic t :foreground "CadetBlue" :slant italic))))
     (font-lock-constant-face ((t (:foreground "gold"))))
     (font-lock-doc-face ((t (:foreground "BlanchedAlmond"))))
     (font-lock-doc-string-face ((t (:foreground "BlanchedAlmond"))))
     (font-lock-function-name-face ((t (:bold t :foreground "goldenrod" :weight bold))))
     (font-lock-keyword-face ((t (:bold t :foreground "#729fcf" :weight bold))))
     (font-lock-preprocessor-face ((t (:foreground "gold"))))
     (font-lock-reference-face ((t (:foreground "LightCoral"))))
     (font-lock-string-face ((t (:foreground "#ad7fa8"))))
     (font-lock-type-face ((t (:foreground "CadetBlue1"))))
     (font-lock-variable-name-face ((t (:foreground "SeaGreen2"))))
     (font-lock-warning-face ((t (:foreground "yellow"))))
     (fringe ((t (:background "#405060"))))
     (header-line ((t (:box (:line-width 2 :style released-button) :background "grey20" :foreground "grey90" :box nil))))
     (highlight ((t (:background "darkgreen"))))
     (holiday-face ((t (:foreground "green"))))
     (info-header-node ((t (:foreground "#729fcf"))))
     (info-header-xref ((t (:bold t :weight bold :foreground "SeaGreen2"))))
     (info-menu-5 ((t (:foreground "wheat"))))
     (info-menu-header ((t (:bold t :family "helv" :weight bold))))
     (info-node ((t (:foreground "#729fcf"))))
     (info-xref ((t (:bold t :foreground "SeaGreen2" :weight bold))))
     (isearch ((t (:background "palevioletred2" :foreground "brown4"))))
     (isearch-lazy-highlight-face ((t (:background "#668b8b"))))
     (italic ((t (:italic t :slant italic))))
     (menu ((t (:background "gray" :foreground "black" :family "helvetica"))))
     (modeline ((t (:background "gray" :foreground "black" :box (:line-width 2 :style released-button)))))
     (modeline-buffer-id ((t (:background "gray" :foreground "black" :box (:line-width 2 :style released-button)))))
     (modeline-mousable ((t (:background "gray" :foreground "black" :box (:line-width 2 :style released-button)))))
     (modeline-mousable-minor-mode ((t (:background "gray" :foreground "black" :box (:line-width 2 :style released-button)))))
     (mouse ((t (:background "white"))))
     (region ((t (:background "DarkCyan"))))
     (scroll-bar ((t (:background "gray" :foreground "#506070"))))
     (secondary-selection ((t (:background "yellow" :foreground "gray10"))))
     (show-paren-match-face ((t (:bold t :foreground "yellow" :weight bold))))
     (show-paren-mismatch-face ((t (:bold t :foreground "red" :weight bold))))
     (tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width 1 :style released-button)))))
     (tooltip ((t (:background "lightyellow" :foreground "black"))))
     (trailing-whitespace ((t (:background "#102e4e"))))
     (underline ((t (:underline t))))
     (variable-pitch ((t (:family "helv"))))
     (widget-button-face ((t (:bold t :weight bold))))
     (widget-button-pressed-face ((t (:foreground "red"))))
     (widget-documentation-face ((t (:foreground "lime green"))))
     (widget-field-face ((t (:background "dim gray"))))
     (widget-inactive-face ((t (:foreground "light gray"))))
     (widget-single-line-field-face ((t (:background "dim gray")))))))

(color-theme-jlouis)
