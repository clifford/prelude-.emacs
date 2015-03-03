;;; personal.el -- personal settings for Emacs prelude

;;; Commentary:

;;; Code:

;; package manager
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; Borrowed by Emacs Prelude
(defvar enocom-packages
  '(clj-refactor markdown-mode paredit paxedit rainbow-delimiters)
  "A list of packages to ensure are installed at launch.")

(dolist (p enocom-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'enocom-packages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; general settings

;; show full screen ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; auto indent
(electric-indent-mode)

;; line numbers in gutter
(global-linum-mode t)
(setq linum-format "%d ")


(custom-set-variables
 '(backup-directory-alist (quote (("." . "/tmp/emacs-backups"))))
;; '(cider-popup-stacktraces nil)
;; '(column-number-mode t)
 ;; '(delete-old-versions t)
 ;; '(fringe-mode 0 nil (fringe))
 '(global-auto-complete-mode t)
 ;; '(magit-set-upstream-on-push t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key bindings

(global-set-key (kbd "<f5>") 'cider-switch-to-current-repl-buffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Font
(add-to-list 'default-frame-alist '(font . "Anonymous Pro 11"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CLOJURE/LISP/NREPL/CIDER

(require 'cider)

(show-paren-mode 1)

(autoload 'clojure-mode "clojure-mode" nil t)
(autoload 'align-cljlet "align-cljlet" nil t)

(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'cider-repl-mode))

(eval-after-load 'clojure-mode
  '(progn
     (require 'paredit)
     (require 'paxedit)
     (require 'clj-refactor)
     ;; (require 'ac-nrepl)
     (defun clojure-paredit-hook () (paredit-mode +1))
     (defun clj-refactor-hook ()
       (clj-refactor-mode 1)
       (cljr-add-keybindings-with-prefix "C-c C-m"))
     (add-hook 'clojure-mode-hook 'clojure-paredit-hook)
     (add-hook 'clojure-mode-hook 'clj-refactor-hook)
     ;; (add-hook 'clojure-mode-hook 'auto-complete-mode)
     ;; (add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
     ;; (add-hook 'cider-mode-hook 'ac-nrepl-setup)
     ))

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Unicode character support
(define-abbrev-table 'global-abbrev-table '(
                                            ("alpha" "α")
                                            ("beta" "β")
                                            ("gamma" "γ")
                                            ("theta" "θ")
                                            ("inf" "∞")

                                            ("ar1" "⟶")
                                            ("ar2" "⇒")
                                            ))

(abbrev-mode 1)
;; type abbreviation, followed by, C-x a e     to expand the abbreviation
;; to add new unicode characters see: http://www.johndcook.com/blog/emacs_unicode/
;; to get list of unicode hex codes, see: http://www.unicode.org/charts/#symbols

(provide 'personal)
;;; personal.el ends here
