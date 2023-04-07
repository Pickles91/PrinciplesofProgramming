; Define lisp functions(s) that would take a list of pairs, each element of the form (first_name last_name) 
; and return the list with all the element reversed and in the form (last_name first_name)

(setq l1 '((a b)(c d)(e f)))


(defun myreverse (l1)

   (cond

      ( (null l1) '())

      ( (null (cdr l1)) l1)

      ( (addatlast (car l1) (myreverse (cdr l1)) ) )

   )

)

(defun myreverselist(l1)

   (cond

      ((null l1) NIL)
      ((cons (myreverse(car l1)) (myreverselist (cdr l1))))

   )

)

(defun addatlast (v l1)

  (cond
     ( (null l1) (list v) )

     ( (cons (car l1) (addatlast v (cdr l1)) ) )
  )

)
