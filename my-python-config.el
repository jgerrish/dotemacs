(require 'python-mode)

;; (require 'ipython)
;; ipythonのプロンプトを替える
;; ln[1]  ->  >>>
;; (setq py-python-command-args '("-cl"))

;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(defvar my-py-docs-python-org-url "http://docs.python.org")

(defun my-py-search-documentation-interactive (word)
  (interactive "sSEARCH: ")
  (my-py-search-documentation word))

(defun my-py-search-documentation-at-point ()
  (interactive)
  (let ((word (current-word)))
    (when word
      (my-py-search-documentation word))))

(defun my-py-search-documentation (word)
  (browse-url (format "%s/search.html?q=%s" my-py-docs-python-org-url word)))

(add-hook 'python-mode-hook
           (lambda ()
             (define-key py-mode-map (kbd "C-c C-f") 'my-py-search-documentation-at-point)
             (define-key py-mode-map (kbd "<f1>") 'my-py-search-documentation-interactive)
             (define-key py-mode-map "\"" 'electric-pair)
             (define-key py-mode-map "\'" 'electric-pair)
             (define-key py-mode-map "(" 'electric-pair)
             (define-key py-mode-map "[" 'electric-pair)
             (define-key py-mode-map "{" 'electric-pair)
             (setq imenu-create-index-function 'py-imenu-create-index)
             (set (make-variable-buffer-local 'beginning-of-defun-function)
                  'py-beginning-of-def-or-class)
             (setq outline-regexp "def\\|class ")))

(let ((pymacs-lisp-dir "~/.emacs.d/pymacs-lisp"))
  (if (not (file-exists-p pymacs-lisp-dir))
      (make-directory pymacs-lisp-dir))
  (eval-after-load "pymacs"
    '(add-to-list 'pymacs-load-path pymacs-lisp-dir)))
