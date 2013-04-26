(in-package parsergen)

#|
(defun set-action (state item symbol action)
  (declare (special *action-list* *action-hash-table*))
  (setq action (fix-action action))
  (if (null symbol)(break "Trying to set an action for NIL"))
  (let ((entry (assoc symbol *action-list*)))
    (if entry
	(setf (cdr entry) (resolve-actions action (cdr entry) symbol))
      (push (list symbol action) *action-list*))))
|#

(defun set-action (state item symbol action)
  (declare (ignore state item))
  (declare (special *action-list* *action-hash-table*))
  (setq action (fix-action action))
  (if (null symbol)(break "Trying to set an action for NIL"))
  (let ((entry (assoc symbol *action-list*)))
    (if entry
	(push action (cdr entry))
      (push (list symbol action) *action-list*))))

#|
(defun resolve-actions (action1 action-list symbol)
  (if (> (length action-list) 1) (pushnew action1 action-list :test 'equal)
    (let ((action2 (car action-list)))
      (if (same-action action1 action2)
	  action-list
	(let* ((pi1 (cadr action1))
	       (pi2 (cadr action2))
	       (prod1 (get-prod pi1))
	       (prod2 (get-prod pi2)))
	  (print symbol)
	  (print (list (car action1) prod1))
	  (print (list (car action2) prod2))
	  (if (and (listp action1)(listp action2))
	      (or (resolve-actions2 prod1 prod2 action1 action2)
		  (if (= pi1 pi2)
		      (or (resolve-self-conflict prod1 action1 action2)
			  (progn (print :both)(list action1 action2)))
		    (if (or (member (list prod1 prod2)
				    *unresolve*
				    :test 'equal)
			    (member (list prod2 prod1)
				    *unresolve*
				    :test 'equal))
			(progn (print :both)(list action1 action2))
		      (if (< pi1 pi2)
			  (progn (print 1)
				 (list action1))
			(progn (print 2)
			       (list action2))))))
	    (progn (print :both)
		   (pushnew action1 action-list :test 'equal))))))))
|#

(defvar *resolutions* nil)
(defparameter *single-conflicts* nil)

(defun resolve-self-conflict (prod action1 action2)
  (let* ((entry (assoc prod *single-conflicts* :test 'equal))
	 (resolution (second entry)))
    (case resolution
	  (:both (print :both) (list action1 action2))
	  (:reduce (if (eq (car action1) :reduce)
		       (progn (print 1)
			      (list action1))
		     (progn (print 2)
			    (list action2))))
	  (:shift (if (eq (car action1) :shift)
		      (progn (print 1)
			     (list action1))
		    (progn (print 2)
			   (list action2))))
	  (t nil))))

(defun resolve-actions2 (prod1 prod2 action1 action2)
  (if (member (list prod1 prod2) *resolutions* :test 'equal)
      (progn (print 1) (list action1))
    (if (member (list prod2 prod1) *resolutions* :test 'equal)
	(progn (print 2) (list action2))
      nil)))

(defun same-action (a1 a2)
  (or (and (listp a1)(listp a2)(eq (car a1) :shift)(eq (car a2)
						       :shift))
      (equal a1 a2)))

(defun get-prod (action)
  (aref *production-array* action))

(defun fix-action (action)
  (if (and (listp action) (eq (car action) :reduce))
      (let ((production (aref *production-array* (cdr action))))
	(list :reduce
	      (cdr action)
	      (length (production-rhs production))
	      (production-lhs production)
	      (format nil "act~D" (cdr action))))
    action))

(defun make-parsing-tables (full-grammar)
  (let ((*action-table* nil)
	(*goto-table* nil)
	(*action-function-table* nil)
	(*action-nargs-table* nil)
	(*action-nt-table* nil)
	(*error-productions* nil)
	(*error-action-function-table* nil)
	(*error-action-nt-table* nil))
    (let* ((ok-full-grammar (remove-if #'(lambda (x)
					   (eq (cadar x) :error))
				       full-grammar))
	   (error-full-grammar (remove-if-not #'(lambda (x)
						  (eq (cadar x) :error))
					      full-grammar))
	   (grammar (mapcar #'car ok-full-grammar))
	   (error-grammar (mapcar #'car error-full-grammar)))
      (make-tables grammar error-grammar)
      (values *action-table* *goto-table*))))


(defun ml::make-ml-tables (grammar &optional (stream *standard-output*))
  (multiple-value-bind (actions gotos) (parsergen::make-parsing-tables grammar)
    (let ((goto-vector (make-array (length actions))))
      (maphash #'(lambda (x y) (setf (aref goto-vector x) y))
               gotos)
      (ml-print-object actions stream)
      (ml-print-object goto-vector stream))))

(defun ml-print-object (object stream)
  (typecase object
    (integer (prin1 object stream))
    (string (prin1 object stream))
    (symbol (prin1 (symbol-name object) stream))
    (list (print-separated-list object ", " 'ml-print-object stream))
    (vector (print-separated-vector object ",~%" 'ml-print-object stream))
    (t (error "~S unknown type" object))))
                                       
(defun print-actions (action-vector stream)
  (print-separated-vector action-vector ",~%" 'ml-print-action stream))

(defun ml-print-action (action stream)
  (format stream "(~A, " (car action))
  (print-separated-list (cdr action) ", " 'print-one-action stream)
  (format stream ")"))

(defun print-one-action (action stream)
  (format stream "(~A,~A)" (first action) (second action)))
  
(defun print-separated-list (list sep print-fn stream &optional (bra "[")(ket "]"))
  (format stream bra)
  (loop while list
        do
        (funcall print-fn (if (listp list) (car list) list) stream)
        (when (and (listp list)(cdr list)) (format stream sep))
        (if (listp list) (pop list)(setq list nil)))
  (format stream ket))

(defun print-separated-vector (vec sep print-fn stream)
  (format stream "[")
  (dotimes (i (length vec))
    (funcall print-fn (aref vec i) stream)
    (when (< i (1- (length vec)))
      (format stream sep)))
  (format stream "]~%"))
    

(defun make-action (state item)
  (let ((itemb (item-b item)))
  (cond
   ((null itemb)
    (make-simple-reductions state item))

   ((is-terminal itemb)
    (set-action state
		item
                itemb
                (list :shift (production-index-of item))))

   (t (make-derived-actions state item)))))

(defun is-shift (action)
  (and (consp action)
       (eq (car action) :shift)))

(defun generate-shifts (state item)
  (dolist (term (get-production-first-set (item-B item)))
	  (set-action state
		      item
		      term
		      (list :shift (production-index-of item)))))


;; And now, some even newer stuff for doing this properly.

;; And here is the parsergen function that is modified.

(defun make-actions(state)
  (let ((*action-list* nil)
	(*action-hash-table* (make-hash-table :test #'eq))
	(item-set (item-set-of-state state)))
    (declare (special *action-list* *action-hash-table*))
    (dolist (item item-set)
	    (make-action state item))
    (setf (svref *action-table* state) (sort-out-action-list *action-list*))))

(defun sort-out-action-list (actionlist)
  ;; This should be an alist of symbol and actions
  (mapcar
   #'(lambda (symbolactions)
       (let ((symbol (car symbolactions))
	     (actions (remove-duplicates (cdr symbolactions) :test 'same-action)))
	 (if (<= (length actions) 1)
	     (list symbol (car actions))
	   (let ((result (resolve-actions actions symbol)))
             (terpri)
	     (print symbol)
	     (print (make-action-list-rep actions))
	     (print (make-action-rep result))
	     (list symbol result)))))
   actionlist))
	 
(defun resolve-actions (alist symbol)
  (or (complex-ml-resolution alist symbol)
      (simple-ml-resolution alist)
      (default-ml-resolution alist)))

(defun all-same-action (alist)
  (if (null alist) t
    (let ((item (car alist))
	  (rest (cdr alist)))
      (every #'(lambda(x) (same-action item x)) rest))))

;; This looks for a permutation of the action that occurs on
;; the the *simple-resolution* list.


(defun simple-ml-resolution (alist)
  (let ((perms (get-all-perms alist)))
    (dolist (perm perms)
      (when (member (make-action-list-rep perm)
		    *simple-resolutions*
		    :test 'equal)
	(return (car perm))))))

(defun complex-ml-resolution (alist symbol)
  (let ((perms (get-all-perms alist)))
    (dolist (perm perms)
	    (let* ((rep (make-action-list-rep perm))
		   (entry 
		    (cdr (assoc (make-action-list-rep perm)
				*complex-resolutions*
				:test 'equal)))
                   (symbol-entry
                    (cadr (assoc symbol (cdr entry)))))
              (when symbol-entry
                (return (fixup-entry symbol-entry perm rep)))
	      (when (car entry)
		(return (fixup-entry (car entry) perm rep)))))))

(defun find-action (action perm rep)
  (cond
   ((null perm) nil)
   ((same-action action (car rep))
    (car perm))
   (t (find-action action (cdr perm) (cdr rep)))))

(defun fixup-entry (entry perm rep)
  ;; This should take an entry in *complex-resolutions* and produce a
  ;; suitable action object that can be printed to ML.
  (flet ((fixup-action (action)
	               (cond
                        ((consp action)
			 (or (find-action action perm rep)
			     (error "Can't find action")))
			((eq action :shift)
                         '(:shift 0))
                        (t (error "Bad Action")))))
    (case (car entry)
      (:funcall
       (let ((name (cadr entry))
	     (actions (cddr entry)))
	 `(:funcall ,name ,@(mapcar #'fixup-action actions))))
      (:resolve
       (let ((actions (cdr entry)))
	 `(:resolve ,@(mapcar #'fixup-action actions))))
      (t (fixup-action entry)))))

(defun default-ml-resolution (alist)
  (find-least alist :test '< :key #'(lambda(x) (if (listp x) (cadr x)
						-1))))

(defun find-least (list &key (test '<) (key 'identity))
  (cond
   ((null list) nil)
   ((null (cdr list)) (car list))
   (t (let ((next-least (find-least (cdr list) :test test :key key))
	    (this-one (car list)))
	(if (funcall test (funcall key this-one) (funcall key next-least))
	    this-one
	  next-least)))))
	    
(defun make-action-list-rep (action-list)
  (mapcar 'make-action-rep action-list))

(defun make-action-rep (action)
  (if (eq action :accept)
      '(:accept)
    (ecase (car action)
      ((:reduce :shift)
       (let ((prod (get-prod (cadr action))))
	 (list (car action) prod)))
      (:funcall
       `(:funcall ,(cadr action)
		  ,@(mapcar 'make-action-rep (cddr action))))
      (:resolve
       `(:resolve ,@(mapcar 'make-action-rep (cdr action)))))))

;; Heres a nice exponential algorithm. Fortunately, length list <= 2
;; usually.

(defun perm-insert (item list)
  (if (null list)
      `((,item))
    `((,item ,@list)
      ,@(mapcar #'(lambda (l)(cons (car list) l))
	     (perm-insert item (cdr list))))))

(defun get-all-perms (list)
  (if (null list)
      (list nil)
    (let ((perms1 (get-all-perms (cdr list))))
      (reduce 'append 
	     (mapcar #'(lambda (x) (perm-insert (car list) x)) perms1)
	     :from-end t))))
  
(defparameter *complex-resolutions* nil)
(defparameter *simple-resolutions* nil)

(defun ml::ml-test ()
  (make-parsing-tables ml::*mlg*)
  nil)
