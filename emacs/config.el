;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kade Allen"
      user-mail-address "kadeallenprofessional@gmail.com")

;; --- Appearance ---
;; Font
(setq doom-font (font-spec :family "Source Code Pro" :size 14 :weight 'medium)
      doom-big-font (font-spec :family "Source Code Pro" :size 16)
      doom-variable-pitch-font (font-spec :family "Source Code Variable" :size 14))

(setq doom-theme 'doom-one) ; Theme
(setq display-line-numbers-type 'relative) ; Line numbers
(custom-set-faces! '(doom-modeline-buffer-modified :foreground "orange")) ; Modified file colour
(setq doom-fallback-buffer-name "► Doom" +doom-dashboard-name "► Doom") ; Change doom window name

;; --- Evil ---
(setq evil-vsplit-window-right t evil-vsplit-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))
(map! :map evil-window-map "SPC" #'rotate-layout)
(after! evil
  (setq evil-ex-substitute-global t
        evil-mode-cursor-back nil
        evil-kill-on-visual-paste nil))


;; --- Completion ---
(after! company
  (setq company-minimum-prefix-length 2)
  (add-hook 'evil-normal-state-entry-hook #'company-abort))
(set-company-backend!
  '(text-mode
    markdown-mode
    gfm-mode)
  '(:sperate
    company-ispell
    company-files
    company-yasnippet))

;; --- Tabs ---
(after! centaur-tabs
  (setq
   centaur-tabs-height 25
   centaur-tabs-style "chamfer"
   centaur-tabs-set-bar 'under
   x-underline-at-descent-line t)
  (centaur-tabs-group-by-projectile-project)
  (map! :leader
        :desc "Toggle tabs globally" "t c" #'centaur-tabs-mode
        :desc "Toggle tabs local display" "t C" #'centaur-tabs-local-mode)
  (evil-define-key 'normal centaur-tabs-mode-map
    (kbd "SPC g n") 'centaur-tabs-forward
    (kbd "SPC g p") 'centaur-tabs-backward
    (kbd "SPC g k") 'centaur-tabs-forward-group
    (kbd "SPC g j") 'centaur-tabs-backward-group))

;; -- Dired ---
(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump))
(after! dired
  (map! :map dired-mode-map :desc "Dired view file" "d v" #'dired-view-file))

;; TreeMacs ---
(after! treemacs
  (setq treemacs-width 25)
  (map! "C-c C-s" #'lsp-treemacs-symbols)
  (map! "C-c C-e" #'lsp-treemacs-errors-list))

;; --- Clang Format ---
(after! clang-format
  (setq clang-format-style "file")
  (map! :leader :nv "C-c f" #'clang-format-buffer))
;; Java formatting
;; (setq-hook! 'java-mode-hook +format-with-lsp nil)
;; (setq-hook! 'java-mode-hook +format-with 'clang-format)

;; --- Other Variables ---
(setq which-key-idle-delay 0.3)
(setq inferior-lisp-program "sbcl")
(setq
 web-mode-markup-indent-offset 4
 web-mode-code-indent-offset 4
 web-mode-css-indent-offset 4
 js-indent-level 4
 typescript-indent-level 4
 json-reformat:indent-width 4
 css-indent-offset 4)

(map! :leader "o c" #'ranger)

;; Make scratch buffers in org mode
(setq initial-major-mode 'org-mode)

(setq doom-modeline-height 20
      doom-modeline-icon t
      doom-modeline-buffer-encoding nil)

;; --- Org ---
;; Variables
(setq org-directory "~/.org/")
(setq
 org-hidden-keywords '(title)
 org-ellipsis " ▾ "
 org-bullets-bullet-list '("·")
 org-tags-column -80
 org-agenda-files (ignore-errors (directory-files +org-dir t))
 org-log-done 'time
 org-capture-templates '(("x" "Note" entry
                          (file+olp+datatree "journal.org")
                          "**** [ ] %U %?" :prepend t :kill-buffer t)
                         ("t" "Task" entry
                          (file+headline "tasks.org" "Inbox")
                          "* [ ] %?\n%i" :prepend t :kill-buffer t))
 +org-capture-todo-file "tasks.org"
 org-super-agenda-groups '((:name "Today"
                            :time-grid t
                            :scheduled today)
                           (:name "Due today"
                            :deadline today)
                           (:name "Important"
                            :priority "A")
                           (:name "Overdue"
                            :deadline past)
                           (:name "Due soon"
                            :deadline future)
                           (:name "Big Outcomes"
                            :tag "bo")))
(add-hook! 'org-mode-hook (lambda () (org-superstar-mode 1))) ; Start superstar with org
;; Fonts
(after! org
  (set-face-attribute 'org-link nil :weight 'normal :background nil)
  (set-face-attribute 'org-code nil :foreground "#a9a1e1" :background nil)
  (set-face-attribute 'org-date nil :foreground "#5B6268" :background nil)
  (set-face-attribute 'org-level-1 nil :foreground "steelblue2" :background nil :height 1.2 :weight 'normal)
  (set-face-attribute 'org-level-2 nil :foreground "slategray2" :background nil :height 1.0 :weight 'normal)
  (set-face-attribute 'org-level-3 nil :foreground "SkyBlue2" :background nil :height 1.0 :weight 'normal)
  (set-face-attribute 'org-level-4 nil :foreground "DodgerBlue2" :background nil :height 1.0 :weight 'normal)
  (set-face-attribute 'org-level-5 nil :weight 'normal)
  (set-face-attribute 'org-level-6 nil :weight 'normal)
  (set-face-attribute 'org-document-title nil :foreground "SlateGray1" :background nil :height 1.75 :weight 'bold))
;; set basic title font
;; (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
;; Low levels are unimportant => no scaling
;; (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
;; (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
;; (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
;; (set-face-attribute 'org-level-4 nil :inherit 'org-level-8)
;; ;; Top ones get scaled the same as LaTeX (\large, \Large, \LARGE)
;; (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.2) ;\large
;; (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.44) ;\Large
;; (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.728) ;\LARGE
;; Only use the first 4 styles and do not cycle
(setq org-cycle-level-faces nil)
(setq org-n-level-faces 4)
;; Document Title, (\huge)
;; (set-face-attribute 'org-document-title nil :height 2.074 :foreground 'unspecified :inherit 'org-level-8)
;; --- Deft ---
(after! deft
  (setq deft-directory "~/.deft"
        deft-extensions '("org")))

;; --- Other Packages ---
(use-package! info-colors :commands (info-colors-fontify-node))
