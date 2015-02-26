;; Time-stamp: <2012-03-08 11:34:25 Administrator>
;; Description: this is a emacs config file which I created from scratch.
;;    tip 1: you can add a comment string "Time-stamp:" and "<>"
;;	 then run the "time-stamp" function to update the date.

;; EMACS Basic Introduction
;; file op: open C-x C-f          close C-x k         exit C-x C-c
;; buff op: switch C-x b          list C-x C-b        <ibuffer>
;; wind op: close others C-x 1    Close this C-x 0    other window C-x o
;; dir  op: dired-jump C-x C-j    list dir C-x C-d    switch dir C-x d
;; move op: C-p C-n C-a C-e M-a M-e
;; you can visit http://www.emacswiki.org to learn more
;; http://xahlee.org/emacs/elisp.html
;; delete-trailing-whitespace

;;** 1.1 general information setting
(setq user-full-name "mooling")
(setq user-mail-address "liushaolin@gmail.com")

;; you can use <ispell-word ispell-buffer ispell-region> to correct the spell.
(setq-default ispell-program-name "aspell")
(setq-default ispell-local-dictionary "american")

(setq bookmark-default-file "~/.emacs.d/.emacs.bmk")
(setq abbrev-file-name "~/.emacs.d/.abbrev_defs")
(setq default-directory  "~/ls/")

;;** 1.2 basic configuration
;; (set-foreground-color "Gray")
;; (set-background-color "Black")

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(show-paren-mode t)
(setq show-paran-style 'parentheses)

(global-linum-mode t)
;; (setq default-fill-coloum 60)

(setq indent-tabs-mode t)
(setq tab-width 4)

(setq inhibit-startup-screen t)
(fset 'yes-or-no-p 'y-or-n-p)

(auto-image-file-mode)

;; use shift+space to replace the ctrl+space to mark the region
(global-set-key [?\S- ] 'set-mark-command)  ;; REMEMBER

;;** 1.3 mode line setting
;;    http://www.emacswiki.org/emacs/ModeLineConfiguration

;;  Enable the display of the current time, see DisplayTime
(display-time-mode t)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 10)
(setq display-time-format "%Y/%m/%d/%A--%H:%M")

;; Enable or disable the display of the current line number, see also LineNumbers
(line-number-mode t)

;; Enable or disable the display of the current column number
(column-number-mode t)

;; Enable or disable the current buffer size, Emacs 22 and later, see Manual:size-indication-mode
(size-indication-mode t)

;; Enable or disable laptop battery information, see DisplayBatteryMode.
(display-battery-mode t)

;; default binding is dabbrev-expand, so change it to useful expand.
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-line
	try-expand-line-all-buffers
	try-expand-list
	try-expand-list-all-buffers
	try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name
	try-complete-file-name-partially
	try-complete-lisp-symbol
	try-complete-lisp-symbol-partially
	try-expand-whole-kill)
)

(global-set-key "\C-c9" (lambda() (interactive) (find-file "~/.emacs")))
(global-set-key "\C-c5" (lambda() (interactive) (dired "~/ls/")))
(global-set-key "\C-c1" (lambda() (interactive) (dired "/plink:mooling@33.33.33.5:/home/mooling/ls/org/")))
(global-set-key "\C-c0" 'eshell)

;; Also, now you can hold down the Shift key then press arrows
;;   key to select text. To turn this off, put:
(setq shift-select-mode t) ; "t" for true, "nil" for false

(mapc (lambda (hook)
        (add-hook hook
		  (lambda () (setq show-trailing-whitespace t))))
      '(text-mode-hook
        emacs-lisp-mode-hook
        python-mode-hook
        js2-mode-hook
        c-mode-hook
        c++-mode-hook
        python-mode-hook
        ruby-mode-hook
        ))
        
(when window-system
  ;; Setting English Font
  ;;(set-face-attribute 'default nil :font "Courier New-11")
  (set-face-attribute 'default nil :font "Terminus (TTF)-15")
  ;; use this font to set org mode's column is align, cos the chinese font
  ;;   is not same with english font, use [consolas-11 and Microsoft YaHei-16]
  ;; (set-face-attribute 'default nil :font "Consolas-12")

  ;; Chinese Font
  (dolist (charset '(kana han symbol cjk-misc bopomofo gb18030))
    (set-fontset-font
     (frame-parameter nil 'font) charset
     ;; (font-spec :family "Microsoft JhengHei" :size 16)))
     ;; (font-spec :family "WenQuanYi Bitmap Song" :size 14)))
     (font-spec :family "SimSun" :size 16)))
     ;; (font-spec :family "Microsoft YaHei" :size 16)))
)

;;* 2.1 C && C++ Programming
(add-hook 'c-mode-hook    'imenu-add-menubar-index)
(add-hook 'c++-mode-hook  'imenu-add-menubar-index)

(add-hook 'c-mode-hook    'hs-minor-mode)
(add-hook 'c++-mode-hook  'hs-minor-mode)

(add-hook 'c-mode-hook     (function (lambda()(interactive)
          (c-set-style "bsd")
          (setq c-basic-offset 4)
          (setq tab-width 4)
	  (c-toggle-auto-hungry-state 1)                    ; Turn on hungry delete
          (define-key c-mode-map [(control =)] (lambda()(interactive)(insert " == ")))
          (modify-syntax-entry ?_ "w")
          )))

(add-hook 'c++-mode-hook   (function (lambda()(interactive)
          (c-set-style "bsd")
          (setq c-basic-offset 4)
          (setq tab-width 4)
	  (c-toggle-auto-hungry-state 1)                    ; Turn on hungry delete
          (define-key c++-mode-map "=" (lambda()(interactive)(insert " = ")))
          (define-key c++-mode-map [(control =)] (lambda()(interactive)(insert " == ")))
          (modify-syntax-entry ?_ "w")
          )))
(setq compile-command "nmake -f makefile.vc")

;;*** 2.2 tags operation
;; ctags -e -R --c++-kinds=+p --fields=+iaS --extra=+q  <dir>

(defun ls/visit-tags-table ()
  "Build tags table list based on a filename"
    ;; Search up
  (interactive)
  (let ((depth 10)
	(dir (file-name-directory (buffer-file-name))))
        (while (and (>= depth 0) dir)
	  (prin1 dir)
          (when (file-exists-p (concat dir "TAGS"))
            (visit-tags-table (concat dir "TAGS"))
            (setq depth 0))
          (setq dir (file-name-directory (directory-file-name dir)))
          (setq depth (1- depth)))))

(defun lev/find-tag (&optional show-only)
  "Show tag in other window with no prompt in minibuf."
  (interactive)
  (let ((default (funcall (or find-tag-default-function
                              (get major-mode 'find-tag-default-function)
                              'find-tag-default))))
    (if show-only
        (progn (find-tag-other-window default)
               (shrink-window (- (window-height) 12))
               (recenter 1)
               (other-window 1))
      (find-tag default))))


(global-set-key [(f7)] 'ls/visit-tags-table)
(global-set-key [(meta .)] '(lambda () (interactive) (lev/find-tag t)))
;;(global-set-key [(meta ,)] 'delete-other-windows)
;;(global-set-key [(control .)] 'lev/find-tag)
;;(global-set-key [(control ,)] 'pop-tag-mark)
;;(global-set-key (kbd "C-M-,") 'find-tag)


;;** 2.2 script programming
;;*** 2.2.1 run script
(defun run-current-file ()
  "Execute or compile the current file.
For example, if the current buffer is the file x.pl,
then it'll call 'perl x.pl' in a shell.
The file can be PHP, Perl, Python, Ruby, javascript, Bash, ocaml, vb, elisp.
File suffix is used to determine what program to run."
  (interactive)
  (save-buffer)
  (let
      (ext-map file-name file-ext prog-name cmd-str)
    (setq ext-map
	  '(
	    ("php" . "php")
	    ("pl" . "perl")
	    ("py" . "python")
	    ("rb" . "ruby")
	    ("js" . "js")
	    ("sh" . "bash")
	    ("ml" . "ocaml")
	    ("vbs" . "cscript")
	    ("java" . "javac")
	    ("lua" . "lua")
	    )
	  )
    (setq file-name (buffer-file-name))
    (setq file-ext (file-name-extension file-name))
    (setq prog-name (cdr (assoc file-ext ext-map)))
    ;; (setq cmd-str (concat prog-name " " file-name))
    (setq cmd-str (concat prog-name " \"" file-name "\""))
    (shell-command cmd-str)))

(global-set-key (kbd "<f9>") 'run-current-file)
(defalias 'perl-mode 'cperl-mode)

;;*** 2.2.2 script shell
(defun ls/perl-shell()
  "make a perl db shell"
  (interactive)
  (switch-to-buffer (make-comint "perl" "perl" nil "-d -e''")))

(defun ls/lua-shell()
  "make a lua shell"
  (interactive)
  (switch-to-buffer (make-comint "lua" "lua" nil "-i")))

(defun ls/ruby-shell()
  "make a ruby shell"
  (interactive)
  (switch-to-buffer (make-comint "irb" "irb" nil "--inf-ruby-mode")))

(defun ls/python-shell()
  "make a python shell"
  (interactive)
  (switch-to-buffer (make-comint "python" "python" nil "-i")))

;;*** 2.2.3 lua-mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;;** 3.1 Org Mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;(org-remember-insinuate)
(setq org-directory "~/ls/org/")
(setq org-default-notes-file (concat org-directory "notes.org"))

;; user remember to save instant things and use "\C-c\C-c" to return
(define-key global-map "\C-cr" 'org-remember)
(setq org-remember-templates
      '(("TODO" ?t "* TODO %?\n %x\n %a" "~/ls/org/home.org" "Tasks")
	("IDEA" ?i "* IDEA %?\n %i\n %a" "~/ls/org/home.org" "Idea")
))

(setq org-agenda-files (list "~/ls/org/work.org"
                             "~/ls/org/personal.org"
                             "~/ls/org/home.org"))

(add-hook 'org-mode-hook
	(lambda ()
	  (toggle-truncate-lines)
	))
;; (add-hook 'org-mode-hook 'toggle-truncate-lines)

(setq org-log-done 'time)
(setq org-publish-project-alist
      '(
        ("org-ls"
         ;; Path to your org files.
         :base-directory "~/ls/org/"
         :base-extension "org"
         :exclude "/files/"

         ;; Path to your Jekyll project.
         :publishing-directory "~/ls/web/ls/"
         :blog-publishing-directory "~/web/blog/"
         :site-root "http://andialbrecht.de"
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 4
         :html-extension "html"
         )
        ("org-static-ls"
         :base-directory "~/ls/org/"
         ;:base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|html\\|tgz"
         :base-extension ".*"
         :publishing-directory "~/ls/web/static/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("ls" :components ("org-ls" "org-static-ls"))
))

(require 'iimage)
 ;;inline image
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)

;; hilight current line.
(require 'hl-line)
(global-hl-line-mode t)

;; if the ido-find-file is not working, you should C-L to rescan DIR;
(require 'ido)
(ido-mode t)

;; (global-set-key "\C-x\C-b" 'ibuffer)
(global-set-key "\C-x\C-b" 'helm-buffers-list)
(global-set-key "\C-x\C-f" 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "<f2>") 'bs-show)

;;** 5.1 plugins enhancement

;; load-path enhancement
(defun fni/add-to-load-path (this-directory &optional with-subdirs recursive)
  "Add THIS-DIRECTORY at the beginning of the load-path, if it exists.
Add all its subdirectories not starting with a '.' if the
optional argument WITH-SUBDIRS is not nil.
Do it recursively if the third argument is not nil."
  (when (and this-directory
             (file-directory-p this-directory))
    (let* ((this-directory (expand-file-name this-directory))
           (files (directory-files this-directory t "^[^\\.]")))

      ;; completely canonicalize the directory name (*may not* begin with `~')
      (while (not (string= this-directory (expand-file-name this-directory)))
        (setq this-directory (expand-file-name this-directory)))

      (message "Adding `%s' to load-path..." this-directory)
      (add-to-list 'load-path this-directory)

      (when with-subdirs
        (while files
          (setq dir-or-file (car files))
          (when (file-directory-p dir-or-file)
            (if recursive
                (fni/add-to-load-path dir-or-file 'with-subdirs 'recursive)
              (fni/add-to-load-path dir-or-file)))
          (setq files (cdr files)))))))

(fni/add-to-load-path "~/ls/packages/" t nil)

;;*** 5.1.6 anything
(require 'helm-config)

;;*** 5.1.8 color theme

;; dir /s/b *.c *.h *.cpp *.hpp >cscope.files
;; cscope -b -k
(require 'xcscope)

;; (add-to-list 'Info-default-directory-list "~/lisp/info/")


