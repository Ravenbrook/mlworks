(defpackage op-parser)

(in-package op-parser)

;;(parsergen::defparser op-parser

(defun test ()
  (translate-grammar '(((top exp))
			  ((exp :var))
			  ((exp exp :op exp))
			  ((exp start-let declist :in exp))
			  ((start-let :let))
			  ((declist :var :eq exp))
			  ((declist declist var :eq exp)))))

(defun makeit ()
  (with-open-file (str "~/ml/full-tables.sml" :direction
		       :output :if-exists :supersede)
     (let ((*standard-output* str)
	   (*package* (find-package "ML")))
       (translate-grammar ml::*mlg*))))

(defun translate-grammar (grammar)
  (format t "(*~%")
  (multiple-value-bind (x y)
		       (parsergen::make-parsing-tables grammar)
      (format t "~%*)~%")
;      (format t "~%val actions = [")
      (dotimes (i (length x))
;         (if (> i 0) (format t ",~% "))
	 (actions-print (aref x i)))
;      (format t "]~%")
      (format t "~%val gotos = [")
      (dotimes (i (length x))
	       (if (> i 0) (format t ",~% "))
	       (ml-print (gethash i y)))
      (format t "]~%")))

(defun ensure-list (l)
  (cond ((null l) l)
	((atom l) (list l))
	((cons (car l)(ensure-list (cdr l))))))

(defun ml-print (list)
  (setq list (ensure-list list))
  (format t "[")
  (when list
	(print-one (car list))
	(dolist (i (cdr list))
		(format t ", ")
		(print-one i)))
  (format t "]"))

(defun actions-print (list)
  (setq list (ensure-list list))
  (format t "~%add_action [")
  (when list
	(print-action (car list))
	(dolist (i (cdr list))
		(format t ", ")
		(print-action i)))
  (format t "];~%"))

(defun make-ml-string (object)
  (let ((str (if (listp object)
		 (case (car object)
		       (:shift "Shift")
		       (:reduce (apply 'format nil "Reduce (~D,~A,~(~A)~)" (cddr object)))
		       (t (format nil "~:(~A~)" object)))
	       (format nil "~:(~A~)" object))))
    (map 'string #'(lambda (x)(if (char= x #\-) #\_ x))
	 str)))

(defun print-one (object)
  (setq object (ensure-list object))
  (format t "(~{~A~^, ~})" (mapcar 'string-upcase
				   (mapcar 'make-ml-string
					   (mapcar #'(lambda(x)
						       (if (eq x :eoi)
							   :eof x))
						   object)))))
	  
(defun print-action (object)
  (setq object (ensure-list object))
  (if (>= (length object) 3)
      (print-multi-action (if (eq (car object) :eoi) :eof (car object))(cdr object))
    (format t "(~{~A~^, ~})"
	    (cons (if (eq (car object) :eoi) :eof (car object))
		  (mapcar 'make-ml-string (cdr object))))))

(defun print-multi-action (sym actions)
  (format t "(~A, Resolve [~{~A~^, ~}])"
	  sym
	  (mapcar 'make-ml-string actions)))

#|
(eval-when (compile load eval)
	   (defvar *precs* nil)
	   (defvar *assoc* nil))

(defmacro add-prec (symbol n side)
  (push (cons symbol n) *precs*)
  (push (cons symbol side) *assoc*))

(defun get-prec (symbol) (cdr (assoc symbol *precs*)))

(defun get-assoc (symbol) (cdr (assoc symbol *assoc*)))

(add-prec * 0 :right)
(add-prec + 1 :left)
(add-prec \ 0 :left)


(defun sort-out (op1 op2)
  (if (eq op1 op2)
      (get-assoc op1)
    (let ((prec1 (get-prec op1))
	  (prec2 (get-prec op2)))
      (if (= prec1 prec2)
	  :left
	(if (< prec1 prec2)
	    :right
	  :left)))))

	  
	  
|#
