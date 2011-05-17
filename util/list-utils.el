;; from alexandria
(defun flatten (tree)
  "Traverses the tree in order, collecting non-null leaves into a list."
  (let (list)
    (labels ((traverse (subtree)
               (when subtree
                 (if (consp subtree)
                     (progn
                       (traverse (car subtree))
                       (traverse (cdr subtree)))
                     (push subtree list)))))
      (traverse tree))
    (nreverse list)))

(defun take (n lst)
  (cond ((or (null lst) (<= n 0)) nil)
        (t (cons (car lst) (take (1- n) (cdr lst))))))

(defun drop (n lst)
  (cond ((<= n 0) lst)
        (t (drop (1- n) (cdr lst)))))

(defun split-at (n lst)
  (list (take n lst) (drop n lst)))

(defun grouped (n lst)
  (cond ((or (<= n 0) (null lst)) nil)
        (t (cons (take n lst) (grouped n (drop n lst))))))

