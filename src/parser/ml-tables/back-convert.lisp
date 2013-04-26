(in-package ml)

(defun prefix-eq (string1 string2)
  (string= string1 string2 :end1 (length string2)))

(defun back-convert (stream start-outstream outstream end-outstream)
  (let ((line nil))
    (loop
     (setq line (read-line stream nil nil))
     (unless line (return))
     (format start-outstream "~A~%" line)
     (when (string= line "(* Do not delete this line 1 *)")
	   (return)))
    (loop while (and (setq line (read-line stream nil nil))
		     (not (string= line "(* Do not delete this line 2 *)")))
	  do
	  (cond
	   ((string= line "")
            (terpri outstream))
	   ((prefix-eq line " | _ => raise ActionError"))
	   ((prefix-eq line "(*")
	    (princ (subseq line 3 (- (length line) 3)) outstream)
            (terpri outstream))
           (t
            (princ ";#" outstream)
            (princ line outstream)
            (terpri outstream))))
    (format end-outstream "~A~%" line)
    (loop
     while (setq line (read-line stream nil nil))
     do (format end-outstream "~A~%" line))
    ))

(defun bc-file (pname start-outfile outfile end-outfile)
  (with-open-file (str pname)
    (with-open-file (start-out start-outfile :direction :output :if-exists :supersede)
       (with-open-file (out outfile :direction :output :if-exists :supersede)
         (with-open-file (end-out end-outfile :direction :output :if-exists :supersede)
	    (back-convert str start-out out end-out))))))

(defun back-convert-grammar ()
  (bc-file #P"../_actionfunctions.sml" #P"_actionfunctions-start" #P"new-grammar.lisp" #P"_actionfunctions-end"))

(defun back-convert-basics ()
  (bc-basics #P"../LRbasics.sml" '(#P"LRbasics-start" #P"LRbasics-end"))
  (bc-basics #P"../_LRbasics.sml" '(#P"_LRbasics-start" #P"_LRbasics-middle1" #P"_LRbasics-middle2" #P"_LRbasics-end")))

(defun bc-basics (file outfilelist)
  (with-open-file (stream file)
     (bc-stream stream outfilelist nil)))

(defun bc-stream (instream outfilelist start-line)
  (if (null outfilelist) nil
    (let ((outfile (car outfilelist))
	  (rest (cdr outfilelist)))
      (with-open-file (outstream outfile :direction :output :if-exists :supersede)
	 (when start-line (format outstream "~A~%" start-line))
	 (let ((line nil))
	   (loop
	    (setq line (read-line instream nil nil))
	    (unless line (return))
	    (format outstream "~A~%" line)
	    (when (string= line "(* Do not delete this line *)")
		  (return)))
	   (loop
	    (setq line (read-line instream nil nil))
	    (unless line (return))
	    (when (string= line "(* Do not delete this line *)")
		  (return)))))
      (bc-stream instream rest "(* Do not delete this line *)"))))

	    
