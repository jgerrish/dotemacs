(require 'string)

(defun my-file-basename (filename)
  (char-list-to-string (reverse (take-while #'(lambda (x) (/= ?/ x))
                       (reverse (string-to-list filename))))))

(defun my-file-path-join (&rest paths)
  (reduce #'(lambda (x y) (concat (file-name-as-directory x) y)) paths))

(defun my-file-get-contents (filePath)
  "Return FILEPATH's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun my-read-lines (filePath)
  "Return a list of lines of a file at FILEPATH."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun my-write-lines (file lst)
  "Write string list to a file"
  (my-file-put-contents file (string-list-to-string "\n" lst)))

(defun my-file-put-contents (file-path string)
  "put content to FILEPATH's file."
  (with-temp-buffer
    (erase-buffer)
    (insert string)
    (write-region (point-min) (point-max) file-path)))

(defun tt:remove-extension (filename)
  (cond ((string-replace-match "\\.\\([0-9a-zA-Z]*\\)$" filename ""))
        (t filename)))

(provide 'file-utils)