(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 ;;'(cua-mode t nil (cua-base))
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray20" :foreground "ghost white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 143 :width normal :foundry "outline" :family "黑体")))))




(set-default 'truncate-lines t)

;;add pathcolor-theme
(add-to-list 'load-path "~/.emacs.d")

;;org mode
(define-key global-map "\C-ca" 'org-agenda)
(setq org-todo-keywords
	  '(
		(sequence "TODO" "INPROCESS" "|" "DONE"  "CANCELED")
		(sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED")
		)
	  ) 

;;tabbar mode, ido-mode
(require 'ido)
(ido-mode t)

(when (require 'tabbar nil 'noerror)
  (tabbar-mode t)
  (define-key tabbar-mode-map [(control up)]    'tabbar-backward-group)
  (define-key tabbar-mode-map [(control down)]  'tabbar-forward-group)
  (define-key tabbar-mode-map [(control left)]  'tabbar-backward)
  (define-key tabbar-mode-map [(control right)] 'tabbar-forward)
  (defadvice tabbar-buffer-tab-label (after modified-flag activate)
    (setq ad-return-value
          (if (and (or (not (featurep 'tabbar-ruler))
                       (not window-system))
                   (buffer-modified-p (tabbar-tab-value tab)))
                   ;; (buffer-file-name (tabbar-tab-value tab))
              (concat ad-return-value "*")
            ad-return-value)))
  (defun update-tabbar-modified-state ()
    (tabbar-set-template tabbar-current-tabset nil)
    (tabbar-display-update))
  (defadvice undo (after update-tabbar-tab-label activate)
    (update-tabbar-modified-state))
  (add-hook 'first-change-hook 'update-tabbar-modified-state)
  (add-hook 'after-save-hook 'update-tabbar-modified-state))
(eval-after-load "tabbar"
  '(when (require 'tabbar-ruler nil 'noerror)
     (defadvice tabbar-popup-menu (after add-menu-item activate)
       "Add customize menu item to tabbar popup menu."
       (setq ad-return-value
             (append ad-return-value
                     '("--"
                       ["Copy Buffer Name" (kill-new
                                            (buffer-name
                                             (tabbar-tab-value
                                              tabbar-last-tab)))]
                       ["Copy File Path" (kill-new
                                          (buffer-file-name
                                           (tabbar-tab-value
                                            tabbar-last-tab)))
                        :active (buffer-file-name
                                 (tabbar-tab-value tabbar-last-tab))]
                       ["Open Dired" dired-jump
                        :active (fboundp 'dired-jump)]
                       ;; ["Open Dired" (dired
                       ;;                (let ((file (buffer-file-name
                       ;;                             (tabbar-tab-value
                       ;;                              tabbar-last-tab))))
                       ;;                  (if file
                       ;;                      (file-name-directory file)
                       ;;                    default-directory)))
                       ;;  :active (buffer-file-name
                       ;;           (tabbar-tab-value tabbar-last-tab))]
                       "--"
                       ["Undo Close Tab" undo-kill-buffer
                        :active (fboundp 'undo-kill-buffer)]))))
     (defadvice tabbar-line-tab (around window-or-terminal activate)
       "Fix tabbar-ruler in window-system and terminal"
       (if window-system
           ad-do-it
         (setq ad-return-value
               (let ((tab (ad-get-arg 0))
                     (tabbar-separator-value "|"))
                 (concat (propertize
                          (if tabbar-tab-label-function
                              (funcall tabbar-tab-label-function tab)
                            tab)
                          'tabbar-tab tab
                          'local-map (tabbar-make-tab-keymap tab)
                          'help-echo 'tabbar-help-on-tab
                          'mouse-face 'tabbar-highlight
                          'face (if (tabbar-selected-p tab
                                                       (tabbar-current-tabset))
                                    'tabbar-selected
                                  'tabbar-unselected)
                          'pointer 'hand)
                         tabbar-separator-value)))))
     ;; (unless (eq system-type 'windows-nt)
     (set-face-attribute 'tabbar-default nil
                         :family (face-attribute 'default :family))
     (add-hook 'after-make-frame-functions
               (lambda (frame)
                 (with-selected-frame frame
                   (set-face-attribute 'tabbar-default frame
                                       :family (face-attribute 'default
                                                               :family)))));; )
     (set-face-attribute 'tabbar-selected nil
                         :foreground "blue")
     (setq tabbar-buffer-groups-function 'tabbar-buffer-groups)
     (setq EmacsPortable-excluded-buffers '())))




;; color theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
 (color-theme-initialize)
)
)

;;color-theme-desert
(color-theme-desert)

;;line number 
(require 'linum  )
(global-linum-mode t)  

;;whitespace
(require 'whitespace)

;;pager
;;(require 'pager)

;;y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;;set the Ctrl+F4 to kill current buffer 
(global-set-key [M-f4] 'kill-this-buffer) 


;;use C-C C-x C-V
;;(setq cua-mode t)

(setq default-directory "/")

;;quick scroll
;;(setq lazy-lock-defer-on-scrolling t)
;;(setq font-lock-support-mode 'lazy-lock-mode)
;;(setq font-lock-maximum-decoration t)

;;vim pulse vim in emacs :) ctrl+z emacs 2vim   
(setq viper-mode t)                ; enable Viper at load time  
(setq viper-ex-style-editing nil)  ; can backspace past start of insert / line  
(require 'viper)                   ; load Viper  
(require 'vimpulse)                ; load Vimpulse  
;;(setq woman-use-own-frame nil)     ; don't create new frame for manpages  
;;(setq woman-use-topic-at-point t)  ; don't prompt upon K key (manpage display)  
;;ctrl + r -> redo   
(require 'redo+)  
(global-set-key (kbd "C-r") 'redo)
;;nice rectangle  
(require 'rect-mark)  

;;gud
(add-hook 'gdb-mode-hook '(lambda ()
                            (define-key c-mode-base-map [(f5)] 'gud-go)
                            (define-key c-mode-base-map [(f7)] 'gud-step)
                            (define-key c-mode-base-map [(f8)] 'gud-next)))
;;cdb
(load "cdb-gud")
(global-set-key [f5]    'gud-cont)
(global-set-key [f7]    'gud-tbreak)
(global-set-key [f8]    'gud-step)
(global-set-key [f9]    'gud-break)
(global-set-key [f10]   'gud-next)
(global-set-key [f13]   'gud-stop-subjob)


;full screen
(defun emacs-maximize ()
  "Maximize emacs window in windows os"
  (interactive)
  (w32-send-sys-command 61488))        ; WM_SYSCOMMAND #xf030 maximize
(defun emacs-minimize ()
  "Minimize emacs window in windows os"
  (interactive)
  (w32-send-sys-command #xf020))    ; #xf020 minimize
(defun emacs-normal ()
  "Normal emacs window in windows os"
  (interactive)
  (w32-send-sys-command #xf120))    ; #xf120 normalimize

;;(emacs-maximize)

(global-set-key [f11] 'emacs-maximize) 
(global-set-key [f6] 'shell) 

;;tree
(eval-after-load "tree-widget"
  '(if (boundp 'tree-widget-themes-load-path)
       (add-to-list 'tree-widget-themes-load-path "~/.emacs.d/")))

(autoload 'imenu-tree "imenu-tree" "Imenu tree" t)
(autoload 'tags-tree "tags-tree" "TAGS tree" t)
(global-set-key [f3] 'imenu-tree) 

;;dir merge
(require 'dirtree)
(global-set-key [f2] 'dirtree ) 

;;(require 'dircmp-mode)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

(setq load-path (add-to-list 'load-path "D:/DyApps/Emacs/lisp/muse"))
(require 'muse-mode)
(require 'muse-colors)
(require 'muse-publish)
(require 'muse-html) ;; and so on
(require 'muse-latex)        ; 
(require 'muse-texinfo)      ;
(require 'muse-docbook)      ;
(require 'muse-wiki nil t)   
(require 'muse-project)      ;
;
(setq muse-html-meta-content-type (concat "text/html; charset=utf-8"))
(setq muse-html-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"/>")  
;
(setq muse-project-alist
      '(("MyWiki"
         ("D:/DannyWang/Danny/wiki_home" :default "index")
         (:base "html" :path "D:/DannyWang/Danny/wiki_home/wiki"))))

;;;;;; cedet
;;;;(add-to-list 'load-path "D:/DyApps/Emacs/lisp/cedit")
;;;;(add-to-list 'load-path "D:/DyApps/Emacs/lisp/cedit/semantic")
;;;;(require 'cedet)
;;;;;semantiec基本配置
;;;;;见http://emacser.com/built-in-cedet.htm
;;;;(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
;;;;global-semanticdb-minor-mode
;;;;global-semantic-idle-summary-mode
;;;;global-semantic-mru-bookmark-mode))
;;;;
;;;;(semantic-mode 1)
;;;;
;;;;(global-semantic-highlight-edits-mode (if window-system 1 -1))
;;;;(global-semantic-show-unmatched-syntax-mode 1)
;;;;(global-semantic-show-parser-state-mode 1)
;;;;;代码跳转和官方版本一样还是用semantic-ia-fast-jump命令，不过在emacs-23.2里直接用这个命令可能会报下面的错误,所以运行时这个feature没被load进来，我们需要自己load一下：
;;;;(require 'semantic/analyze/refs)
;;;;(global-ede-mode t)
;;;;
;;;;;;;; Helper tools.
;;;;(custom-set-variables
;;;;'(semantic-default-submodes (quote (global-semantic-decoration-mode global-semantic-idle-completions-mode
;;;;global-semantic-idle-scheduler-mode global-semanticdb-minor-mode
;;;;global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode)))
;;;;'(semantic-idle-scheduler-idle-time 3))
;;;;
;;;;(semantic-mode)
;;;;(defconst user-include-dirs
;;;;  (list ".." "../include" "../inc" "../common" "../public"
;;;;        "../.." "../../include" "../../inc" "../../common" "../../public"))
;;;;
;;;;(defconst win32-include-dirs
;;;;  (list "D:/Apps/MinGW/include/c++/4.6.2"
;;;;        "D:/Apps/MinGW/include/c++/4.6.2/mingw32"
;;;;        "D:/Apps/MinGW/include/c++/4.6.2/backward"
;;;;        "D:/Apps/MinGW/lib/gcc/mingw32/4.6.2/include"
;;;;        "D:/Apps/MinGW/include"
;;;;        ))
;;;;(let ((include-dirs user-include-dirs))
;;;;  (when (eq system-type 'windows-nt)
;;;;    (setq include-dirs (append include-dirs win32-include-dirs)))
;;;;  (mapc (lambda (dir)
;;;;          (semantic-add-system-include dir 'c++-mode)
;;;;          (semantic-add-system-include dir 'c-mode))
;;;;        include-dirs))
;;;;
;;;;(defadvice push-mark (around semantic-mru-bookmark activate)
;;;;  "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
;;;;If `semantic-mru-bookmark-mode' is active, also push a tag onto
;;;;the mru bookmark stack."
;;;;  (semantic-mrub-push semantic-mru-bookmark-ring
;;;;                      (point)
;;;;                      'mark)
;;;;  ad-do-it)
;;;;
;;;;(defun semantic-ia-fast-jump-back ()
;;;;  (interactive)
;;;;  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
;;;;      (error "Semantic Bookmark ring is currently empty"))
;;;;  (let* ((ring (oref semantic-mru-bookmark-ring ring))
;;;;         (alist (semantic-mrub-ring-to-assoc-list ring))
;;;;         (first (cdr (car alist))))
;;;;    (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
;;;;        (setq first (cdr (car (cdr alist)))))
;;;;    (semantic-mrub-switch-tags first)))
;;;;
;;;;;; smart complitions
;;;;(require 'semantic/ia)
;;;;(setq-mode-local c-mode semanticdb-find-default-throttle
;;;;'(project unloaded system recursive))
;;;;(setq-mode-local c++-mode semanticdb-find-default-throttle
;;;;'(project unloaded system recursive))
;;;;(defun semantic-ia-fast-jump-or-back (&optional back)
;;;;  (interactive "P")
;;;;  (if back
;;;;      (semantic-ia-fast-jump-back)
;;;;    (semantic-ia-fast-jump (point))))
;;;;
;;;;(define-key semantic-mode-map [f12] 'semantic-ia-fast-jump-or-back)
;;;;(define-key semantic-mode-map [C-f12] 'semantic-ia-fast-jump-or-back)
;;;;(define-key semantic-mode-map [S-o] 'semantic-ia-fast-jump-back)

;;emacs 
;;(require 'cedet)
;;(require 'semantic-ia)
;;(semantic-load-enable-code-helpers)
;;
;;(global-set-key [(control tab)] 'semantic-ia-complete-symbol-menu)
;; 
;;;; Enable EDE (Project Management) features
;;(global-ede-mode 1)
;; 
;;(semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-semantic-debugging-helpers)
;; 
;;;; Enable SRecode (Template management) minor-mode.
;;(global-srecode-minor-mode 1)

;;set font
(if window-system
  (defun qiang-font-existsp (font)
    (if (null (x-list-fonts font))
      nil t
      )
    )
   (require 'cl) ;; find-if is in common list package
   (defvar font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
   (find-if #'qiang-font-existsp font-list)

   (defun qiang-make-font-string (font-name font-size)
     (if (and (stringp font-size) 
              (equal ":" (string (elt font-size 0))))
       (format "%s%s" font-name font-size)
       (format "%s %s" font-name font-size)))

   (defun qiang-set-font (english-fonts
                           english-font-size
                           chinese-fonts
                           &optional chinese-font-size)
     "english-font-size could be set to \":pixelsize=18\" or a integer.
   If set/leave chinese-font-size to nil, it will follow english-font-size"
   (require 'cl)                         ; for find if
   (let ((en-font (qiang-make-font-string
                    (find-if #'qiang-font-existsp english-fonts)
                    english-font-size))
         (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
                             :size chinese-font-size)))

     ;; Set the default English font
     ;; 
     ;; The following 2 method cannot make the font settig work in new frames.
     ;; (set-default-font "Consolas:pixelsize=18")
     ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
     ;; We have to use set-face-attribute
     (message "Set English Font to %s" en-font)
     (set-face-attribute
       'default nil :font en-font)

     ;; Set Chinese font 
     ;; Do not use 'unicode charset, it will cause the english font setting invalid
     (message "Set Chinese Font to %s" zh-font)
     (dolist (charset '(kana han symbol cjk-misc bopomofo))
       (set-fontset-font (frame-parameter nil 'font)
                         charset
                         zh-font))))
  (qiang-set-font
    '("Consolas Bold" "Monaco" "DejaVu Sans Mono" "Monospace" "Courier New") ":pixelsize=18"
    '("黑体" "新宋体" "宋体") )

  )

;;end set font
