;;
;; $Log: mlworks-emacs.el,v $
;; Revision 1.1  1992/09/07 15:43:08  clive
;; Initial revision
;;
;;
;;

;; This function calls a function in the image to print possible completions of the 
;;   name in front of the cursor 

(defun ml-complete()
  (interactive)
  (re-search-backward "[^a-z_.]\\([a-z._]*\\)")
  (let 
      ((the-string (buffer-substring (match-beginning 1) (match-end 1))))
    (end-of-buffer)
    (process-send-string 
     (get-buffer-process (current-buffer))
     (concat "do_completion(\"" the-string "\");\n"))))

;; Tries to find a debug string on the current line, and then attempts to go to the current
;;   location in the given file 

(defun ml-find-file ()
  (interactive)
  (beginning-of-line)
  (re-search-forward " \\([^ :]+\\): *\\([0-9]+\\), *\\([0-9]+\\) *$")
  (let ((file (buffer-substring (match-beginning 1) (match-end 1)))
	(line (string-to-int (buffer-substring (match-beginning 2) (match-end 2))))
	(column (string-to-int (buffer-substring (match-beginning 3) (match-end 3)))))
    (if (file-exists-p file)
	(progn
	  (find-file-other-window file)
	  (goto-line line)
	  (forward-char column))
      (let
	  ((file-name (read-file-name
		       (concat "Sml (default " file "): ")
		       ""
		       file)))
	(if (file-exists-p file-name)
	    (progn
	      (find-file-other-window file-name)
	      (goto-line line)
	      (forward-char column))
	  (message "Not found"))))))

