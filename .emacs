;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)

;; Rinari
(add-to-list 'load-path "~/.emacs.d/rinari")
(require 'rinari)
(require 'magit)

;; back up directory
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)

;; font
;;(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-11"))
(add-to-list 'default-frame-alist '(font . "Bitstream Vera Sans Mono-11"))

(setq pqh-emacs-init-file "~/.emacs.d/")
(setq pqh-emacs-config-dir
      (file-name-directory pqh-emacs-init-file))

;; Set up 'custom' system
(setq custom-file (expand-file-name "emacs-customizations.el" pqh-emacs-config-dir))
(load custom-file)

;; line numbers
(add-hook 'pqh-code-modes-hook
          (lambda () (linum-mode 1)))
(add-hook 'ruby-mode-hook
          (lambda () (run-hooks 'pqh-code-modes-hook)))

;; color
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))
;; Rake files are ruby, too, as are gemspecs, rackup files, etc.
(add-to-list 'auto-mode-alist '("\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))

;; ack
(add-to-list 'load-path "~/.emacs.d/full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; gogle nav
(add-to-list 'load-path "~/.emacs.d/emacs-nav-20110220/")
(require 'nav)

;; vi-ish
(defun vi-open-line-above ()
  "Insert a newline above the current line and put point at beginning."
  (interactive)
  (unless (bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))

(defun vi-open-line-below ()
  "Insert a newline below the current line and put point at beginning."
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))

(defun vi-open-line (&optional abovep)
  "Insert a newline below the current line and put point at beginning.
With a prefix argument, insert a newline above the current line."
  (interactive "P")
  (if abovep
      (vi-open-line-above)
    (vi-open-line-below)))

(define-key global-map [(meta p)] 'vi-open-line-above)
(define-key global-map [(meta n)] 'vi-open-line-below)

;; code formatting
(defun indent-file ()
  "Format whole file."
  (interactive)
  (indent-region (point-min) (point-max)))
(define-key global-map [(meta return)] 'indent-file)


