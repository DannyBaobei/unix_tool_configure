(require 'org-publish)


;;(setq note-root-dir
;;      (file-name-directory (or load-file-name (buffer-file-name))))
;;
;;(setq note-publish-dir
;;      (expand-file-name "public_html" (directory-file-name
;;                                       (file-name-directory
;;                                        (directory-file-name note-root-dir)))))
;;
;;(setq org-publish-project-alist
;;      `(("note-org"
;;         :base-directory ,note-root-dir
;;         :publishing-directory ,note-publish-dir
;;         :base-extension "org"
;;         :recursive t
;;         :publishing-function org-publish-org-to-html
;;         :auto-index t
;;         :index-filename "index.org"
;;         :index-title "index"
;;         :link-home "index.html")
;;        ("note-static"
;;         :base-directory ,note-root-dir
;;         :publishing-directory ,note-publish-dir
;;         :recursive t
;;         :base-extension "css//|js//|png//|jpg//|gif//|pdf//|mp3//|swf//|zip//|gz//|txt//|el"
;;         :publishing-function org-publish-attachment)
;;        ("note" :components ("note-org" "note-static"))))
;;
(setq org-publish-project-alist
      '(("note-org"
         :base-extension "org"
         :recursive t
         :publishing-function org-publish-org-to-html
         :auto-index nil
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
         :section-numbers nil
         :style "<link rel=\"stylesheet\"
    href=\"./style.css\"
    type=\"text/css\"/>")
        ("note-static"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" 
         :components ("note-org" "note-static")
         :author "DannyBabobei7@gmail.com"
         )))

