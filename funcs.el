;;; funcs.el --- search-engine Layer functions File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;(defun spacemacs//search-engine-source (engines)
;  "return a source for helm selection"
;  `((name . "Search Engines")
;    (candidates . ,(mapcar (lambda (engine)
;                             (cons (plist-get (cdr engine) :name)
;                                   (intern (format "engine/search-%S"
;                                                   (car engine)))))
;                           engines))
;    (action . (lambda (candidate) (call-interactively candidate)))))
;
; migemo 対応にする(参考 http://syohex.hatenablog.com/entry/2015/10/10/171926)
(with-eval-after-load "helm"
  (defvar spacemacs//search-engine-source-with-migemo
    (helm-build-sync-source "Search Engines"
      :candidates (mapcar (lambda (engine)
                            (cons (plist-get (cdr engine) :name)
                                  (intern (format "engine/search-%S"
                                                  (car engine)))))
                          search-engine-alist)
      :action (lambda (candidate) (call-interactively candidate))
      :migemo t)))

(defun spacemacs/helm-search-engine-select ()
  "Set search engine to use with helm."
  (interactive)
  (helm :sources `(spacemacs//search-engine-source-with-migemo)))

;(defun spacemacs/helm-search-engine-select ()
;  "Set search engine to use with helm."
;  (interactive)
;  (helm :sources (list (spacemacs//search-engine-source
;                        search-engine-alist))))

(defun spacemacs/ivy-search-engine-select ()
  "Set search engine to use with ivy."
  (interactive)
  (ivy-read "Search Engines: "
            (mapcar (lambda (engine)
                      (cons (plist-get (cdr engine) :name)
                            (intern (format "engine/search-%S"
                                            (car engine)))))
                    search-engine-alist)
            :action (lambda (candidate) (call-interactively (cdr candidate)))))

(defun spacemacs/search-engine-select ()
  "Set search engine to use."
  (interactive)
  (search-engine/init-engine-mode)
  (if (configuration-layer/layer-usedp 'ivy)
      (call-interactively 'spacemacs/ivy-search-engine-select)
    (call-interactively 'spacemacs/helm-search-engine-select)))
