;;; init.el --- Initialization file for my Emacs setup

;; Copyright (C) 2009  Jesper Louis Andersen

;; Author: Jesper Louis Andersen <jesper.louis.andersen@gmail.com>
;; Keywords: local

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
(defun load-cfg-files (files)
  (dolist (f files)
    (load (expand-file-name
	   (concat emacs-config-dir f)))
    (message "Loaded config file: %s" file)))

(defun extend-load-path (path)
  (setq load-path (cons (expand-file-name path) load-path)))

(add-to-list 'load-path "~/.emacs.d/vendor")
(progn (cd "~/.emacs.d/vendor")
       (normal-top-level-add-subdirs-to-load-path))

(defconst emacs-config-dir "~/.emacs.d/configs/" "")
(setq load-path (cons "~/.emacs.d" load-path))

(load-cfg-files '("global"
		  "local-site"
		  "c-mode-setup"
		  "color-theme-setup"
		  "diredx-setup"
		  "epa-setup"
		  "hippie-expand-setup"
		  "ido-setup"
		  "js2-setup"
		  "nxml-setup"
		  "org-setup"
		  "proof-general-setup"
		  "sml-setup"
		  "tex-code"
		  "tramp-setup"
		  "tuareg-setup"
		  "twelf-setup"
		  "dpaste-setup"
		  "gist-setup"
		  "browse-kill-ring-setup"))

(setq custom-file "~/.emacs.d/custom.el")

;;; init.el ends here
