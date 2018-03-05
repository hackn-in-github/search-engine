;;; packages.el --- search-engine-revision layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Tooru Iijima <tooru@tooru-PC-LL550KG1B>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `search-engine-revision-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `search-engine-revision/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `search-engine-revision/pre-init-PACKAGE' and/or
;;   `search-engine-revision/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst search-engine-revision-packages
  '((search-engine :excluded t))
  "The list of Lisp packages required by the search-engine-revision layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(setq search-engine-packages
      '(engine-mode)
      search-engine-alist
      '((amazon
         :name "Amazon"
         :url "http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%%3Daps&field-keywords=%s")
        (bing
         :name "Bing"
         :url "http://www.bing.com/search?q=%s")
        (duck-duck-go
         :name "Duck Duck Go"
         :url "https://duckduckgo.com/?q=%s")
        (google
         :name "Google"
         :url "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s")
        (google-images
         :name "Google Images"
         :url "http://www.google.com/images?hl=en&source=hp&biw=1440&bih=795&gbv=2&aq=f&aqi=&aql=&oq=&q=%s")
        (github
         :name "Github"
         :url "https://github.com/search?ref=simplesearch&q=%s")
        (google-maps
         :name "Google Maps"
         :url "http://maps.google.com/maps?q=%s")
        (twitter
         :name "Twitter"
         :url "https://twitter.com/search?q=%s")
        (project-gutenberg
         :name "Project Gutenberg"
         :url "http://www.gutenberg.org/ebooks/search.html/?format=html&default_prefix=all&sort_order=&query=%s")
        (youtube
         :name "YouTube"
         :url "http://www.youtube.com/results?aq=f&oq=&search_query=%s")
        (stack-overflow
         :name "Stack Overflow"
         :url "https://stackoverflow.com/search?q=%s")
        (spacemacs-issues
         :name "Spacemacs Issues"
         :url "https://github.com/syl20bnr/spacemacs/issues?utf8=%%E2%%9C%%93&q=is%%3Aissue+is%%3Aopen+%s")
        (spacemacs-pullrequests
         :name "Spacemacs Pull Requests"
         :url "https://github.com/syl20bnr/spacemacs/pulls?utf8=%%E2%%9C%%93&q=is%%3Aissue+is%%3Aopen+%s")
        (wikipedia
         :name "Wikipedia"
         :url "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s")
        (wolfram-alpha
         :name "Wolfram Alpha"
         :url "http://www.wolframalpha.com/input/?i=%s")
        ))

(defun search-engine/init-engine-mode ()
  (use-package engine-mode
    :commands (defengine spacemacs/search-engine-select)
    :defines search-engine-alist
    :init
    (progn
      (spacemacs/set-leader-keys
        "a/" 'spacemacs/search-engine-select)
      (dolist (engine search-engine-alist)
        (let ((func (intern (format "engine/search-%S" (car engine)))))
          (autoload func "engine-mode" nil 'interactive))))
    :config
    (progn
      (engine-mode t)
      (dolist (engine search-engine-alist)
        (let* ((cur-engine (car engine))
               (engine-url (plist-get (cdr engine) :url)))
          (eval `(defengine ,cur-engine ,engine-url)))))))

;;; packages.el ends here
