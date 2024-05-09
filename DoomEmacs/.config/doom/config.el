;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Markoh Pabellano"
      user-mail-address "markohblpabellano@gmail.com")

(setq bookmark-default-file "~/.config/doom/bookmarks")

(setq doom-theme 'doom-lantern)
(map! :leader
      :desc "Load new theme" "h t" #'load-theme)

(add-hook 'after-init-hook #'marks/org-colors-gruvbox-light)

;; Tab Bar Settings
(setq tab-bar-new-tab-choice "*doom*")


;; Centaur Tabs

;; (setq centaur-tabs-set-bar 'left
;;       centaur-tabs-set-icons t
;;       centaur-tabs-gray-out-icons 'buffer
;;      centaur-tabs-height 24
;;      centaur-tabs-set-modified-marker t
;;      centaur-tabs-style "bar"
;;      centaur-tabs-modified-marker "•")
;; (map! :leader
;;      :desc "Toggle tabs globally" "t c" #'centaur-tabs-mode
;;      :desc "Toggle tabs local display" "t C" #'centaur-tabs-local-mode)
;; (evil-define-key 'normal centaur-tabs-mode-map (kbd "g <right>") 'centaur-tabs-forward        ; default Doom binding is 'g t'
;;                                               (kbd "g <left>")  'centaur-tabs-backward       ; default Doom binding is 'g T'
;;                                               (kbd "g <down>")  'centaur-tabs-forward-group
;;                                              (kbd "g <up>")    'centaur-tabs-backward-group)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face

;; Fonts

(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font Mono" :size 15)
      doom-big-font (font-spec :family "Iosevka Nerd Font Mono" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))


;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; Theme

(after! org
(defun marks/org-colors-gruvbox-light ()
  "Enable Gruvbox Light colors for Org headers."
  (interactive)
  (dolist
     (face
       '((org-level-1 1.4"#fb4934" ultra-bold)
         (org-level-2 1.3 "#fe8019" extra-bold)
         (org-level-3 1.2 "#8ec07c" bold)
         (org-level-4 1.2 "#98971a" semi-bold)
         (org-level-5 1.1 "#83a598" normal)
         (org-level-6 1.1 "#458588" normal)
         (org-level-7 1.1 "#d3869b" normal)
         (org-level-8 1.0 "#b16286" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf")))

;; Load our desired markoh/org-colors-* theme on startup


;; )

(add-hook 'org-mode-hook 'variable-pitch-mode)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; Org-Fonts
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 15)
      doom-big-font (font-spec :family "Iosevka Nerd Font" :size 24))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq org-hide-emphasis-markers t)
(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
;; Org-Mode
(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)
(after! org
  (setq org-directory "~/Org/"
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ⮷ "
        ;;org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-startup-folded t
        org-hide-emphasis-markers t
        org-return-follows-link t
        org-deadline-warning-days 30
        org-use-speed-commands t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "NEXT(n)"           ; Task Ready Soon
             "DONE(d!)"           ; Task has been completed
             "ONPROGRESS(o!)"     ; Task is on progress
             "WAITING(w@/!)"     ; Waiting something for the task
             "HOLD(h@/!)"        ; Task on Hold
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "CANCELLED(c@/!)" )))) ; Task has been cancelled

;; Org-Agenda
;;
(after! org
  (setq org-agenda-span 90
   org-agenda-tags-column 7
   org-agenda-start-day nil  ; today
))

(after! org
  (defun my/org-roam-filter-by-tag (tag-name)
    (lambda (node)
    (member tag-name (org-roam-node-tags node))))
  (defun my/org-roam-list-notes-by-tag (tag-name)
    (mapcar #'org-roam-node-file
    (seq-filter
        (my/org-roam-filter-by-tag tag-name)
        (org-roam-node-list))))
  (defun my/org-roam-refresh-agenda-list ()
        (interactive)
    (setq org-agenda-files (my/org-roam-list-notes-by-tag "Project")))

;; Build the agenda list the first time for the session
(my/org-roam-refresh-agenda-list))

(setq
   ;; org-fancy-priorities-list '("[A]" "[B]" "[C]")
   ;; org-fancy-priorities-list '("❗" "[B]" "[C]")
   org-fancy-priorities-list '("🟥" "🟧" "🟨")
   org-priority-faces
   '((?A :foreground "#ff6c6b" :weight bold)
     (?B :foreground "#98be65" :weight bold)
     (?C :foreground "#c678dd" :weight bold))
   org-agenda-block-separator 8411)

(setq org-refile-targets '((org-agenda-files :maxlevel . 4)))

(setq org-agenda-custom-commands
      '((" " "Agenda"
         ((agenda ""
                  ((org-agenda-span 'day)))
          (todo "TODO"
                ((org-agenda-overriding-header "Unscheduled tasks")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'deadline 'timestamp))
                 ))
          (todo "TODO"
                ((org-agenda-overriding-header "Unscheduled project tasks")
                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'deadline 'timestamp))
                 ))
          (todo "TODO"
                ((org-agenda-overriding-header "Goals")
                 (org-agenda-files '("~/org/roam/favorites/20230325182525-marks_purpose_goals" ))))))))

;; Org-Roam & Org-Roam-Ui graph
(after! org
  (setq org-roam-directory "~/org/roam"
       ;;org-roam-graph-viewer "/usr/bin/brave"
        org-roam-completion-everywhere t
        org-roam-db-autosync-mode t
        org-roam-capture-templates
                '(
                  ("d" "default" plain "%?"
                   :if-new(file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                        "#+title: ${title}\n#+date: %U\ \n#+filetags: \n#+category:")
                       r:unnarrowed t)
                  )))

(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

;; Org Noter

(add-to-list 'load-path "/home/marks/DoomPackages/org-noter/")
(require 'org-noter)

;; Org-Download
(require 'org-download)
;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

(defun marks/org-download-paste-clipboard (&optional use-default-filename)
  (interactive "P")
  (require 'org-download)
  (let ((file
         (if (not use-default-filename)
             (read-string (format "Filename [%s]: "
                                  org-download-screenshot-basename)
                          nil nil org-download-screenshot-basename)
           nil)))
    (org-download-clipboard file)))

(after! org
  (setq org-download-method 'directory)
  (setq org-download-image-dir "/home/marks/Org/Attachments")
  (setq org-download-heading-lvl nil)
  (setq org-download-timestamp "%Y%m%d-%H%M%S_")
  (setq org-image-actual-width 300))


;; Keybindings
;;; Org-Roam
(map! :leader
      (:prefix ("n r" . "org-roam")
       :desc "Graph-UI" "G" #'org-roam-ui-open
       :desc "org-noter" "N" #'org-noter
       :desc "Insert Immediate Node" "I" #'org-roam-node-insert-immediate))

;;; Org-Download
(map! :leader
      (:prefix ("d" . "org-download")
       :desc "clipboard image" "c" #'org-download-clipboard))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
