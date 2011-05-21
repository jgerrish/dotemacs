(when (require 'scala-mode-auto nil t)
  (require 'auto-highlight-symbol)
  (setq scala-interpreter "scala -Xnojline")

  ;; http://www.callcc.net/diary/20101106.html ;;;;;;;
  (defadvice scala-block-indentation (around improve-indentation-after-brace activate)
    (if (eq (char-before) ?\{)
        (setq ad-return-value (+ (current-indentation) scala-mode-indent:step))
      ad-do-it))

  (defun scala-newline-and-indent ()
    (interactive)
    (delete-horizontal-space)
    (let ((last-command nil))
      (newline-and-indent))
    (when (scala-in-multi-line-comment-p)
      (insert "* ")))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


  (add-hook 'scala-mode-hook
            (lambda ()
              (define-key scala-mode-map (kbd "RET") 'scala-newline-and-indent)))

  (add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
  (add-hook 'scala-mode-hook
            (lambda ()
              (scala-electric-mode)
              (setq imenu-generic-expression
                    '(
                      ("var" "\\(var +\\)\\([^(): ]+\\)" 2)
                      ("val" "\\(val +\\)\\([^(): ]+\\)" 2)
                      ("override def" "^[ \\t]*\\(override\\) +\\(def +\\)\\([^(): ]+\\)" 3)
                      ("implicit def" "^[ \\t]*\\(implicit\\) +\\(def +\\)\\([^(): ]+\\)" 3)
                      ("def" "^[ \\t]*\\(def +\\)\\([^(): ]+\\)" 2)
                      ("trait" "\\(trait +\\)\\([^(): ]+\\)" 2)
                      ("class" "^[ \\t]*\\(class +\\)\\([^(): ]+\\)" 2)
                      ("case class" "^[ \\t]*\\(case class +\\)\\([^(): ]+\\)" 2)
                      ("abstract class" "^[ \\t]*\\(abstract class +\\)\\([^(): ]+\\)" 2)
                      ("object" "\\(object +\\)\\([^(): ]+\\)" 2)
                      ))))

  ;; http://d.hatena.ne.jp/tototoshi/20110122/1295689870
  (defadvice scala-eval-region (after pop-after-scala-eval-region activate)
    (pop-to-buffer scala-inf-buffer-name)
    (goto-char (point-max)))

  (defadvice scala-eval-buffer (after pop-after-scala-eval-buffer activate)
    (pop-to-buffer scala-inf-buffer-name)
    (goto-char (point-max))))

