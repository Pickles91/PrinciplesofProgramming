;  Author: Steven Sommer
;  Course: CS 415 - Principles of Programming Languages
;  Assignment Name: Lisp Program
;  Description: A Boolean expression is of the form
;              (and  a b c d)   or         (and (or b c) (not a) (and c d)) – or any combination thereof
;              Where a,b,c,d are propositions
;              Truth set is given in the form
;                     ((a t) (b f) (c t) (d t))                where a is true, b is false, c is true and d is true.

;   Write Lisp function myevalb – which takes in a Boolean expression as described above, and a (sufficient) truth set as described above, 
;   and returns the value of the evaluated boolean expression (T or NIL).

(defun myevalb (expr truth-set)
  (cond ((atom expr) (cdr (assoc expr truth-set)))
        ((eq (car expr) 'and) (every #'identity (mapcar #'(lambda (x) (myevalb x truth-set)) (cdr expr))))
        ((eq (car expr) 'or) (some #'identity (mapcar #'(lambda (x) (myevalb x truth-set)) (cdr expr))))
        ((eq (car expr) 'not) (not (myevalb (cadr expr) truth-set)))))
