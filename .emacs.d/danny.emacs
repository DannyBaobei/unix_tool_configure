(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(set-default 'truncate-lines t)




;;add pathcolor-theme
(add-to-list 'load-path "~/.emacs.d")

(require 'vimpulse)
;; color theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
 (color-theme-initialize)
)
)

;;color-theme-desert
(color-theme-desert)


(setq w32-charset-info-alist  
      (cons '("gbk" w32-charset-gb2312 . 936) w32-charset-info-alist))  
(setq default-frame-alist  
      (append  
       '((font . "fontset-gbk")) default-frame-alist))  
(create-fontset-from-fontset-spec  
"-outline-Consolas-Bold-r-normal-normal-18-97-96-96-c-*-fontset-gbk")  

;;(set-default-font "Consolas Bold 14")

;;line number 行号  
(require 'linum  )
(global-linum-mode t)  

;;whitespace
(require 'whitespace)

;;y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;;set the Ctrl+F4 to kill current buffer 
(global-set-key [M-f4] 'kill-this-buffer) 



;;quick scroll
;;(setq lazy-lock-defer-on-scrolling t)
;;(setq font-lock-support-mode 'lazy-lock-mode)
;;(setq font-lock-maximum-decoration t)

;;;;vim pulse vim in emacs 真邪恶:) ctrl+z 进行emacs vim之间的切换   
;;(setq viper-mode t)                ; enable Viper at load time  
;;(setq viper-ex-style-editing nil)  ; can backspace past start of insert / line  
;;(require 'viper)                   ; load Viper  
;;(require 'vimpulse)                ; load Vimpulse  
;;(setq woman-use-own-frame nil)     ; don't create new frame for manpages  
;;(setq woman-use-topic-at-point t)  ; don't prompt upon K key (manpage display)  
;;ctrl + r -> redo   
;;(require 'redo)  
;;nice rectangle  
;;(require 'rect-mark)  

