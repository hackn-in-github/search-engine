(with-eval-after-load "helm"
  (defun spacemacs/helm-search-engine-select ()
    "Set search engine to use with helm."
    (interactive)
    (helm :sources (helm-build-sync-source "Search Engines Revision"
                      :candidates (mapcar (lambda (engine)
                                            (cons (plist-get (cdr engine) :name)
                                                  (intern (format "engine/search-%S"
                                                                  (car engine)))))
                                          search-engine-alist)
                      :action (lambda (candidate) (call-interactively candidate))
                      :migemo t))))

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
