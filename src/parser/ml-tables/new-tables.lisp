(in-package ml)

(defvar *actions-list*)
(defvar *actions-index*)

;; Take the actions output of make-parsing-tables and split into an array with
;; numbers and a vector with actions themselves.

(defun make-actions-list (actions)
  (let* ((*actions-list* nil)
	 (new-vector (map 'vector 'doitems actions)))
    (values (length *actions-list*) new-vector (reverse *actions-list*))))


(defun action-equal (action1 action2)
  (flet ((is-shift (action)
	     (and (null (cdr action))
		  (consp (car action))
		  (eq (car (car action)) :shift))))
    (or (and (is-shift action1)
	     (is-shift action2))
	(equal action1 action2))))

(defun doitems (x)
  (mapcar #'(lambda (item)
              (let* ((token (first item))
                     (actions (rest item))
                     (sub (member actions
			          *actions-list*
			          :test 'action-equal)))
		(cond (sub
		       (list token (1- (length sub))))
		      (t
		       (push actions *actions-list*)
		       (list token (1- (length *actions-list*)))))))
	  x))

(defun make-gotos (gotos length)
  (flet ((munge (x)
                (mapcar #'(lambda (x) (list (car x)(cdr x)))
                        x)))
    (let ((goto-vector (make-array length)))
      (maphash #'(lambda (x y) (setf (aref goto-vector x) (munge y)))
               gotos)
      goto-vector)))

(defun apply-append (l)
  (let ((result nil))
    (dolist (subl l)
      (dolist (item subl)
	(push item result)))
    (reverse result)))

(defun make-grammar-symbols (grammar)
  (sort (mapcar 'symbol-name
                (remove-duplicates
                 (apply-append (apply-append grammar))))
        'string<))

(defvar *symbols*)

(defun make-tables (grammar)
  (setq *symbols* (make-grammar-symbols grammar)))

(defun get-symbol-from-index (n)
  (nth n *symbols*))

(defun get-index-from-string (string)
  (position string *symbols* :test 'string=))

(defun get-index-from-symbol (sym)
  (get-index-from-string (symbol-name sym)))

(defun indexify (x)
  (cond ((null x) nil)
        ((numberp x) x)
        ((eq x :eoi) -1)
        ((symbolp x) (get-index-from-symbol x))
        ((consp x) (cons (indexify (car x)) (indexify (cdr x))))
        (t (map 'vector 'indexify x))))

(defun doitall (grammar)
  (multiple-value-bind (actions gotos) (parsergen::make-parsing-tables grammar)
    (let* ((length (length actions))
	   (symbols (make-grammar-symbols grammar))
           (*symbols* symbols)
           (goto-table (indexify (make-gotos gotos length))))
      (multiple-value-bind (no-of-actions actions-temp actions-list)
	  (make-actions-list actions)
        (let ((actions (indexify actions-temp)))
          (values length symbols goto-table actions actions-list))))))


(defun set-vars ()
  (multiple-value-setq (*length* *symbols* *gotos* *actions* *actions-list*)
    (doitall *mlg*))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Printing functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This prints the action table and the goto table
(defun print-ml-table (stream table)
  (print-separated-list stream
			(coerce table 'list)
                        ",~%  "
                        #'(lambda (row stream)
                          (print-separated-list stream
						row ", "
                                                #'(lambda (item stream)
                                                  (format stream
                                                          "(~D,~D)"
                                                          (first item)
                                                          (second item)))
                                                "[" "]"))
                        "[~%" "]~%"))

;; Print the list of actions
(defun print-action-list (stream alist)
  (print-separated-list stream
			alist
			",~%  "
			#'(lambda (actions stream)
			    (if (= (length actions) 1)
				(princ (action-string (first actions)) stream)
                              (error "Bad action list")))
			""
			"~%"))

(defun action-string (action)
  (if (eq action :accept)
      "Accept"
    (ecase (car action)
      (:shift "Shift")
      (:reduce (format nil "Reduce(~D,~A,~D)"
		       (third action)
		       (fourth action)
		       (second action)))
      (:funcall
       (destructuring-bind (name act1 act2) (cdr action)
         (format nil "Funcall(~A,~Aarity,~A,~A)"
                 (string-downcase name)
                 (string-downcase name)
                 (action-string act1)
                 (action-string act2))))
       (:resolve
        (format nil
                "Resolve[~A]"
                (actions-list-string (cdr action)))))))

(defun actions-list-string (alist)
  (cond
   ((null alist) "")
   ((null (cdr alist))
    (action-string (car alist)))
   (t
    (format nil "~A,~A"
            (action-string (car alist))
            (actions-list-string (cdr alist))))))

(defun print-separated-list (stream list separator printfun &optional (open "") (close ""))
  (format stream open)
  (when list
    (funcall printfun (car list) stream)
    (when (cdr list)
      (dolist (item (cdr list))
        (format stream separator)
        (funcall printfun item stream))))
  (format stream close))

;; Print capitalized symbols separated by "|"

(defun print-ml-symbols (syms stream)
  (print-separated-list stream syms "~% | " #'(lambda(sym stream)
						(format stream   "~A"
							(string-upcase
							 sym))) " | " "~%"))

(defun print-ml-symbol-list (syms stream)
  (print-separated-list stream syms ", ~%  " #'(lambda(sym
						       stream)(format
							       stream "~A" (string-upcase sym))) "" "~%"))

(defun print-table (table stream)
  (setq table (coerce table 'list))
  (dolist (row table)
	  (dolist (item row)
		  (dolist (n item)
			  (format stream "~D " n)))
	  (terpri stream)))

(defun print-tables (gotofile actionsfile symbolfile actionlistfile symbollistfile)
   (multiple-value-bind (length symbols gotos actions actions-list)
       (doitall *mlg*)
       (format t "~d actions~%" length)
       (with-open-file (stream gotofile :direction :output :if-exists :supersede)
	    (print-table gotos stream))
       (with-open-file (stream actionsfile :direction :output :if-exists :supersede)
	    (print-table actions stream))
       (with-open-file (stream symbolfile :direction :output :if-exists :supersede)
	    (print-ml-symbols symbols stream))
       (with-open-file (stream actionlistfile :direction :output :if-exists :supersede)
	    (print-action-list stream actions-list))
       (with-open-file (stream symbollistfile :direction :output :if-exists :supersede)
	    (print-ml-symbol-list symbols stream))))
		       

(defun print-the-tables ()
  (print-tables "gotos.data" "actions.data" "symbols.data"
		"actionlist.data" "symbollist.data"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Action printing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-ml-actions (stream &optional (outstream *standard-output*))
  (let ((line (read-line stream nil nil))
	(action-number 0))
    (loop while line
	  do
	  (cond ((is-ml-line line)
		 (print-ml-header outstream action-number)
		 (loop do
		       (print-ml-line outstream line)
		       (setq line (read-line stream nil nil))
		       until
		       (not (is-ml-line line)))
		 (print-ml-tail outstream action-number)
		 (incf action-number))
		(t (if (equal line "")
		       (terpri outstream)
		     (format outstream "~%(* ~A *)" line))))
	  (setq line (read-line stream nil nil)))))

(defun print-ml-header (stream number)
  (format stream "~% " number))

(defun print-ml-tail (stream number)
  (format stream " | _ => raise ActionError ~D,~%" number))

(defun print-ml-line (stream string)
  (princ (subseq string 2) stream)
  (terpri stream))

(defun is-ml-line (string)
  (and (> (length string) 1)
       (string= (subseq string 0 2) ";#")))

(defun write-action-functions (infile outfile)
  (with-open-file (instream infile :direction :input)
     (with-open-file (outstream outfile :direction :output :if-exists :supersede)
        (make-ml-actions instream outstream)
	(format outstream "~%"))))

;; Assume here that we are in the directory where the data is to go

(defun write-the-actions ()
  (write-action-functions "new-grammar.lisp" "action-functions.data"))

;;;;; End of action writing section ;;;;;
