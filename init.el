
;; auto generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-confirm-babel-evaluate nil)
 '(org-default-notes-file (concat org-directory "~/orgfiles/notes.org"))
 '(org-directory "~/orgfiles")
 '(org-export-html-postamble nil)
 '(org-hide-leading-stars t)
 '(org-src-fontify-natively t)
 '(org-startup-folded (quote overview))
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (htmlize noflet web-mode iedit ideit expand-region beacon undo-tree elpy flycheck zenburn-theme which-key use-package try org-bullets counsel color-theme-modern color-theme auto-complete ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))

;; Our stuff

(setq inhibit-startup-message t)

(tool-bar-mode -1)
(setq ring-bell-function 'ignore)

(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Org mode stuff
(use-package org 
      :ensure t
      :pin org)

    (setenv "BROWSER" "chrome")
    (use-package org-bullets
      :ensure t
      :config
      (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
    

    ;; (setq org-file-apps
          ;; (append '(
          ;;           ("\\.pdf\\'" . "evince %s")
          ;;           ("\\.x?html?\\'" . "/usr/bin/firefox %s")
          ;;           ) org-file-apps ))

    (global-set-key "\C-ca" 'org-agenda)
    (setq org-agenda-start-on-weekday nil)
    (setq org-agenda-custom-commands
          '(("c" "Simple agenda view"
             ((agenda "")
              (alltodo "")))))

    (global-set-key (kbd "C-c c") 'org-capture)

    (setq org-agenda-files (list "~/orgfiles/gcal.org"
                                 "~/orgfiles/soe-cal.org"
                                 "~/orgfiles/i.org"
                                 "~/orgfiles/schedule.org"))
    (setq org-capture-templates
          '(("a" "Appointment" entry (file  "~/orgfiles/gcal.org" )
             "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
            ("l" "Link" entry (file+headline "~/orgfiles/links.org" "Links")
             "* %? %^L %^g \n%T" :prepend t)
            ("b" "Blog idea" entry (file+headline "~/orgfiles/i.org" "Blog Topics:")
             "* %?\n%T" :prepend t)
            ("t" "To Do Item" entry (file+headline "~/orgfiles/i.org" "To Do and Notes")
             "* TODO %?\n%u" :prepend t)
            ("m" "Mail To Do" entry (file+headline "~/orgfiles/i.org" "To Do and Notes")
             "* TODO %a\n %?" :prepend t)
            ("g" "GMail To Do" entry (file+headline "~/orgfiles/i.org" "To Do and Notes")
             "* TODO %^L\n %?" :prepend t)
            ("n" "Note" entry (file+headline "~/orgfiles/i.org" "Notes")
             "* %u %? " :prepend t)

	    ("s" "Screencast" entry (file "~/orgfiles/screencasts.org")
	     "* %?\n%i\n")))

    (defadvice org-capture-finalize 
        (after delete-capture-frame activate)  
      "Advise capture-finalize to close the frame"  
      (if (equal "capture" (frame-parameter nil 'name))  
          (delete-frame)))

    (defadvice org-capture-destroy 
        (after delete-capture-frame activate)  
      "Advise capture-destroy to close the frame"  
      (if (equal "capture" (frame-parameter nil 'name))  
          (delete-frame)))  

    (use-package noflet
      :ensure t )
    (defun make-capture-frame ()
      "Create a new frame and run org-capture."
      (interactive)
      (make-frame '((name . "capture")))
      (select-frame-by-name "capture")
      (delete-other-windows)
      (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
        (org-capture)))
;; (require 'ox-beamer)
;; for inserting inactive dates
    (define-key org-mode-map (kbd "C-c >") (lambda () (interactive (org-time-stamp-inactive))))

    (use-package htmlize :ensure t)

    (setq org-ditaa-jar-path "~/emacs.d/ditaa/ditaa.jar")




(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(defalias 'list-buffers 'ibuffer)
;;(defalias 'list-buffers 'ibuffer-other-window)

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

(use-package counsel
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))

(use-package swiper
  :ensure try
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))


(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char-2))


(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

;; (use-package color-theme-modern
;;   :ensure t)

;; (use-package zenburn-theme
;;   :ensure t
;;   ;;  :config (load-theme 'zenburn t))
;;   ;;  :config (load-theme 'subtle-hacker t))
;;   :config (load-theme 'emacs-21 t))

;; flycheck

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))


;; python
(use-package elpy
  :ensure t
  :config
  (elpy-enable))

;; yasnippet
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))


;; undo tree

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

;; Web mode
(use-package web-mode
:ensure t
:config
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
'(("django"    . "\\.html\\'")))
(setq web-mode-ac-sources-alist
'(("css" . (ac-source-css-property))
("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-quoting t))



;; misceleneaous
(global-hl-line-mode t)

;; (use-package beacon
;;   :ensure t
;;   :config
;;   (beacon-mode 1))

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(setq save-interprogram-paste-before-kill t)

(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)
(global-set-key (kbd "<f5>") 'revert-buffer)

					; mark and edit all copies of the marked region simultaniously. 
(use-package iedit
  :ensure t)

					; if you're windened, narrow to the region, if you're narrowed, widen
					; bound to C-x n
(defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun,
whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
	((region-active-p)
	 (narrow-to-region (region-beginning) (region-end)))
	((derived-mode-p 'org-mode)
	 ;; `org-edit-src-code' is not a real narrowing command.
	 ;; Remove this first conditional if you don't want it.
	 (cond ((ignore-errors (org-edit-src-code))
		(delete-other-windows))
	       ((org-at-block-p)
		(org-narrow-to-block))
	       (t (org-narrow-to-subtree))))
	(t (narrow-to-defun))))

;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing keymap, that's
;; how much I like this command. Only copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)



(defun load-if-exists (f)
  ""
  (if (file-readable-p f)
    (load-file f)))

(load-if-exists "nodes.org")

