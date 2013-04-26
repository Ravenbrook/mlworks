;;;; Bug reporting and browsing functions for MLWorks

;;; Ripped off from the Lispworks bug mode by daveb, August 1994.
;;; Modified to suit the MLWorks project.
;;; Includes commands to assign bugs and remove old assignments, mark bugs as
;;; urgent, fixed or unrepeatable, and to reject a bug entirely.
;;; All changes prompt for a mail message - fixes go to mlworks-changes,
;;; others just to mlworkers.

;;; $Log: new-bug-mode.el,v $
;;; Revision 1.10  1996/10/22 09:38:46  daveb
;;; Added an "Approved:" field to change reports.
;;;
; Revision 1.9  1996/08/21  14:07:04  io
; change reply to put a "Re:" in the subject
;
; Revision 1.8  1996/08/16  12:05:11  io
; [Bug #1552]
; Add a "Files Removed" field
;
; Revision 1.7  1995/09/06  15:56:03  matthew
; emacs18 doesn't like parameters to toggle-read-only
;
; Revision 1.6  1995/09/06  15:23:08  daveb
; Added command to delete bugs that have been fixed, rejected or kept.
;
; Revision 1.5  1994/10/13  13:44:18  daveb
; Removed unwanted field from ideas template.
;
; Revision 1.4  1994/09/28  13:17:56  daveb
; Mail about claimed or assigned bugs now includes the bug description.
;
; Revision 1.3  1994/09/22  15:31:31  daveb
; Changed prompt printed by mlworks-idea command.
;
; Revision 1.2  1994/09/06  14:42:14  daveb
; Added bug-assign function.  Claims are now treated as assignments to
; oneself.  Added more info to mail messages.
;
; Revision 1.1  1994/08/24  12:59:39  daveb
; new file
;

(provide 'new-bug-mode)

(require 'mail-utils)
(require 'backquote)
(require 'cl)


(defconst *news-directory*
  "/usr/spool/news/")


;;----------------------------------------------------------------------------
;; Bug command definer
;;----------------------------------------------------------------------------


(defvar *bug-infos* '())


(defun bug-function-body (name suffix args arg-desc what neat-name function info-args)
  (list 'defun (intern (concat name suffix)) args
	(concat what " for " neat-name ".")
	(list 'interactive arg-desc)
	(cons function (append args info-args))))

(defun bug-function-body1 (name suffix what neat-name function info-arg)
  (bug-function-body name suffix '(synopsis) "sA short bug description: "
		     what neat-name function (list info-arg)))

(defun bug-function-body2 (name suffix what neat-name function &rest info-args)
  (bug-function-body name suffix '() '() what neat-name function info-args))

(defun idea-function-body1 (name suffix what neat-name function info-arg)
  (bug-function-body name suffix '(synopsis) "sA short description of your idea: "
		     what neat-name function (list info-arg)))


(defmacro def-bugs-and-changes (name neat-name bug-info change-info)
  (let ((bug-info-var (intern (concat "*" name "-bug-info*")))
	(change-info-var (intern (concat "*" name "-change-info*"))))
    (list 'progn
      (list 'defconst bug-info-var (list 'quote (cons neat-name bug-info)))
      (list 'defconst change-info-var
	    (list 'quote (cons neat-name
			       (append change-info (cdr (cdr (cdr bug-info)))))))
      (list 'setq '*bug-infos* (list 'cons bug-info-var '*bug-infos*))
      (bug-function-body1 name "-bug" "Submit a bug report" neat-name
			 'bug-report bug-info-var)
      (bug-function-body2 name "-bugs" "Browse the bug reports" neat-name
			 'bug-browser bug-info-var change-info-var)
      (bug-function-body2 name "-change" "Submit a change report" neat-name
			 'change-report change-info-var)
      (bug-function-body2 name "-changes" "Browse the change reports" neat-name
			 'change-browser change-info-var))))


(defmacro def-doc-bugs (name neat-name bug-info)
  (` (let ((bug-info '((, neat-name) (, (car bug-info)) (, (car (cdr bug-info)))
		       (, (concat "*" neat-name " bugs*"))
		       (, (car (cdr (cdr bug-info))))
		       doc-bug-template find-dummy-image)))
       (setq *bug-infos* (cons bug-info *bug-infos*))
       (, (bug-function-body1 name "-bug" "Submit a bug report" neat-name
			      'bug-report (` (find-info (, neat-name)))))
       (, (bug-function-body2 name "-bugs" "Browse the bug reports" neat-name
			      'bug-browser (` (find-info (, neat-name))))))))

(defmacro def-ideas (name neat-name bug-info)
  (` (let ((bug-info '((, neat-name) (, (car bug-info)) (, (car (cdr bug-info)))
		       (, (concat "*" neat-name " Ideas*"))
		       (, (car (cdr (cdr bug-info))))
		       idea-template find-ml-image)))
       (setq *bug-infos* (cons bug-info *bug-infos*))
       (, (idea-function-body1 name "-idea" "Submit an idea" neat-name
			      'bug-report (` (find-info (, neat-name)))))
       (, (bug-function-body2 name "-ideas" "Browse the ideas" neat-name
			      'bug-browser (` (find-info (, neat-name))))))))


(defun info-address (info) (car (cdr info)))
(defun info-directory (info) (car (cdr (cdr info))))
(defun info-bufname (info) (car (cdr (cdr (cdr info)))))
(defun info-reply-address (info) (car (cdr (cdr (cdr (cdr info))))))
(defun info-template (info)
  (or (car (cdr (cdr (cdr (cdr (cdr info)))))) 'bug-template))
(defun info-find-image (info)
  (or (car (cdr (cdr (cdr (cdr (cdr (cdr info))))))) 'find-lw-image))

(defun info-newsgroup (info)
  (concat (mapcar '(lambda (x) (if (= x ?/) ?. x))
		  (info-directory info))))

(defun info-bugname (info)
  (let ((summary-buffer (info-bufname info)))
    (substring summary-buffer 1 (- (length summary-buffer) 2))))

(defun find-info (neat-name)
  (assoc neat-name *bug-infos*))


;;----------------------------------------------------------------------------
;; MLWorks bugs facilities
;;----------------------------------------------------------------------------

(def-bugs-and-changes "mlworks" "MLWorks"
  ("mlworks-bugs" "harlqn/mlworks/bugs" "*MLWorks-Bugs*" "mlworkers"
   bug-template find-ml-image)
  ("mlworks-changes" "harlqn/mlworks/changes" "*MLWorks-Changes*"))

(def-ideas "mlworks" "MLWorks"
  ("mlworks-ideas" "harlqn/mlworks/ideas" "mlworkers"))


;;----------------------------------------------------------------------------
;; Misc other bug functions
;;----------------------------------------------------------------------------


(defun view-bug (bug-number)
  "View the LispWorks bug BUG-NUMBER."
  (interactive "NBug number: ")
  (view-a-bug bug-number (info-directory *lispworks-bug-info*)))

(defun view-ebug (bug-number)
  "View the LispWorks environment bug BUG-NUMBER."
  (interactive "NBug number: ")
  (view-a-bug bug-number (info-directory *lispworks-environment-bug-info*)))

(defun view-a-bug (bug-number directory)
  (let ((file (concat *news-directory* directory "/" bug-number)))
    (if (file-exists-p file)
	(view-file file)
      (error "Bug %s does not exist" bug-number))))


;;----------------------------------------------------------------------------
;; Endless aliases
;;----------------------------------------------------------------------------

(defun lispworks-ebug ()
  "Submit a bug report for the LispWorks environment."
  (interactive) 
  (call-interactively 'lispworks-environment-bug))

(defun lispworks-ebugs ()
  "Browse the bug reports for the LispWorks environment."
  (interactive)
  (lispworks-environment-bugs))

(defun manual-bug ()
  "Submit a bug report for the LispWorks documentation."
  (interactive)
  (call-interactively 'lispworks-doc-bug))


;;----------------------------------------------------------------------------
;; Generic news handling routines
;;----------------------------------------------------------------------------


(defvar bug-file-directory)
(defvar bug-current-file)
(defvar bug-current-buffer)
(defvar bug-first-field)
(defvar *bug-info*)
(defvar *change-info*)


(defun browse-bugs (bug-group)
  "Browse the bug reports in BUG-GROUP."
  (interactive (list (completing-read "Browse bug db: " *bug-infos*)))
  (bug-browser (find-info bug-group)))

(defun bug-browser (bug-info &optional change-info)
  (if (get-buffer (info-bufname bug-info))
      (switch-to-buffer (info-bufname bug-info))
      (compute-bug-summary bug-info change-info "Synopsis")))

(defun change-browser (change-info)
  (if (get-buffer (info-bufname change-info))
      (switch-to-buffer (info-bufname change-info))
      (compute-bug-summary change-info nil "Files modified")))


(defun bug-summary-mode ()
  "Major mode in effect in a bug/change summary buffer.
As commands are issued in the summary buffer, the corresponding
report is displayed in the other buffer.
\\{bug-summary-mode-map}
Entering this mode calls the value of BUG-SUMMARY-MODE-HOOK."
  (interactive)
  (kill-all-local-variables)
  (make-local-variable 'bug-file-directory)
  (make-local-variable 'bug-current-file)
  (make-local-variable 'bug-current-buffer)
  (make-local-variable 'bug-first-field)
  (setq major-mode 'bug-summary-mode)
  (setq mode-name "Bug Summary")
  (use-local-map bug-summary-mode-map)
  (setq truncate-lines t)
  (setq buffer-read-only t)
  (set-syntax-table text-mode-syntax-table)
  (run-hooks 'bug-summary-mode-hook))


(defvar bug-summary-mode-map nil)

(if bug-summary-mode-map
    nil
  (setq bug-summary-mode-map (make-keymap))
  (suppress-keymap bug-summary-mode-map)
  (define-key bug-summary-mode-map "j"     'bug-summary-goto-report)
  (define-key bug-summary-mode-map "g"     'bug-summary-goto-numbered-report)
  (define-key bug-summary-mode-map "n"     'bug-summary-next-report)
  (define-key bug-summary-mode-map "p"     'bug-summary-previous-report)
  (define-key bug-summary-mode-map "\M->"  'bug-summary-last-report)
  (define-key bug-summary-mode-map "\M-<"  'bug-summary-first-report)
  (define-key bug-summary-mode-map " "     'bug-summary-scroll-report-up)
  (define-key bug-summary-mode-map "\177"  'bug-summary-scroll-report-down)
  (define-key bug-summary-mode-map "d"     'bug-summary-delete-old)
  (define-key bug-summary-mode-map "q"     'bug-summary-quit)
  (define-key bug-summary-mode-map "e"     'bug-edit-report)
  (define-key bug-summary-mode-map "r"     'bug-reply)
  (define-key bug-summary-mode-map "f" 	   'bug-mark-fixed)
  (define-key bug-summary-mode-map "k" 	   'bug-mark-kept)
  (define-key bug-summary-mode-map "R" 	   'bug-mark-rejected)
  (define-key bug-summary-mode-map "!" 	   'bug-mark-urgent)
  (define-key bug-summary-mode-map "c" 	   'bug-claim)
  (define-key bug-summary-mode-map "a" 	   'bug-assign)
  (define-key bug-summary-mode-map "u" 	   'bug-unassign))


;;;; Summary commands


(defun bug-summary-scroll-report-up (&optional dist)
  "Scroll the report in the other window forward."
  (interactive "P")
  (scroll-other-window dist))

(defun bug-summary-scroll-report-down (&optional dist)
  "Scroll the report in the other window backward."
  (interactive "P")
  (scroll-other-window
   (cond ((eq dist '-) nil)
	 ((null dist) '-)
	 (t (- (prefix-numeric-value dist))))))

(defun bug-summary-next-report ()
  "Move to the next unfixed report, or arg reports forward."
  (interactive)
  (if (= (forward-line 1) 0)
      (bug-summary-goto-report)))

(defun bug-summary-previous-report ()
  "Move to the previous unfixed report, or arg reports backward."
  (interactive)
  (if (= (forward-line -1) 0)
      (bug-summary-goto-report)))

(defun bug-summary-first-report ()
  "Goto the beginning of the summary buffer."
  (interactive)
  (goto-char (point-min)))

(defun bug-summary-last-report ()
  "Goto the end of the summary buffer."
  (interactive)
  (goto-char (point-max)))

(defun bug-summary-goto-report ()
  "Display the report at the cursor."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (mark-word 1)
    (let ((new-bug (buffer-substring (point) (mark)))
	  (ff bug-first-field)
	  (summary-buffer (current-buffer))
	  bug-buffer)
      (if (and bug-current-file
	       (string-equal bug-current-file new-bug)
	       (buffer-name bug-current-buffer))
	  (display-buffer bug-current-buffer)
	(progn
	  (if (null (buffer-name bug-current-buffer))
	      (setq bug-current-file nil))
	  (find-file-other-window (expand-file-name new-bug bug-file-directory))
	  (if (start-of-field ff)
	      (beginning-of-line)
	    (goto-char (point-min)))
	  (recenter 0)
	  (setq buffer-read-only t)
	  (setq bug-buffer (current-buffer))
	  (select-window (get-buffer-window summary-buffer))
	  (if bug-current-file
	      (bug-destroy-buffer bug-current-buffer))
	  (setq bug-current-file new-bug)
	  (setq bug-current-buffer bug-buffer)
	  )))))

(defun bug-summary-goto-numbered-report (number)
  "Find a report by number."
  (interactive "NReport number: ")
  (beginning-of-buffer)
  (re-search-forward (concat "^" number " "))
  (beginning-of-line)
  (bug-summary-goto-report))


(defun bug-edit-report ()
  "Edit the current report (recursive edit, automatic save)."
  (interactive)
  (bug-summary-goto-report)
  (save-window-excursion
    (other-window 1)
    (let ((buffer-read-only nil)
	  (bug-buffer (current-buffer)))
      (message "Recursive edit: C-M-c to exit and save, C-] to abort without saving")
      (recursive-edit)
      (set-buffer bug-buffer)
      (let ((backup-by-copying t)) (save-buffer))
      ))
  (bug-summary-line-update))


(defun bug-reply (cc-discussion)
  "Send mail about the bug to the person who reported it.
With a c-U, CC to the discussion list."
  (interactive "P")
  (bug-summary-goto-report)
  (let* ((from (or (bug-buffer-get-field "X-Originally-From")
		   (bug-buffer-get-mail-field "From")))
	 (sender-field (mail-strip-quoted-names from))
	 (orig-date (bug-buffer-get-field "X-Original-Date"))
	 (cc (if cc-discussion (info-reply-address *bug-info*))))
    (if (mail nil
	      (substring sender-field 0 (string-match "@" sender-field))
	      (concat "Re: " (bug-buffer-get-mail-field "Subject"))
	      (if (fboundp 'rmail-make-in-reply-to-field)
		  (rmail-make-in-reply-to-field from
		    (or orig-date (bug-buffer-get-mail-field "Date"))
		    (if orig-date "<unknown>" (bug-buffer-get-mail-field "Message-Id"))))
	      nil
	      bug-current-buffer)
	(if cc (progn (mail-cc) (insert cc) (end-of-buffer))))))


(defun bug-destroy-buffer (buf)
  (let ((old-buf (current-buffer)))
    (if (buffer-modified-p buf)
	(progn
	  (set-buffer buf)
	  (let ((backup-by-copying t)) (save-buffer))))
    (kill-buffer buf)
    (if (not (eq old-buf buf))
	(set-buffer old-buf))))

(defun bug-summary-delete-old ()
  "Delete fixed, rejected and unrepeatable bugs."
  (interactive)
  (bug-summary-first-report)
  (let ((old-buffer-read-only buffer-read-only))
    (setq buffer-read-only nil)
    (delete-matching-lines "^[0-9]+ +[<>?][<>]")
    (setq buffer-read-only old-buffer-read-only)))

(defun bug-summary-quit ()
  "Quit the browser."
  (interactive)
  (if bug-current-file
      (bug-destroy-buffer bug-current-buffer))
  (kill-buffer (current-buffer)))


;;;; Marking reports

(defun bug-mark-fixed (no-test-file)
  "Mark the current bug as fixed and prepare a change report about it.
With a c-U, no test file."
  (interactive "P")
  (if bug-current-file
    (progn
      (bug-summary-goto-report)
      (if (save-excursion
	     (set-buffer bug-current-buffer)
	     (bug-fixed-p))
        (message "Already fixed!")
        (if (yes-or-no-p "Mark bug as fixed? ")
	  (let ((test-file ""))
	    (save-excursion
	      (if (not no-test-file)
		(let ((default-directory
			(expand-file-name "~sml/MLW/src/test-suite/")))
		  (while (string= "" test-file)
		    (setq test-file (read-string "Test file name: ")))))
	      (set-buffer bug-current-buffer)
	      (let ((buffer-read-only nil))
	        (bug-field-find-or-insert "Fixed-by")
	        (insert (user-login-name) " " (current-time-string))
	        (if (not no-test-file)
		  (progn
		    (bug-field-find-or-insert "Test-file")
		    (insert test-file))))
	      (let ((backup-by-copying t)) (save-buffer)))
	    (bug-summary-line-update)
            (if *change-info*
	      (prepare-change-report
 	         (concat (info-bugname *bug-info*) " " bug-current-file)
	         (concat "Fixed: " (bug-buffer-get-mail-field "Subject"))
	         *change-info*))))))))

(defun bug-assign ()
  "Assign the current bug and prepare a report about it."
  (interactive)
  (if bug-current-file
    (progn
      (bug-summary-goto-report)
      (let ((status (save-excursion
                      (set-buffer bug-current-buffer)
                      (cond ((bug-fixed-p) "fixed")
                            ((bug-assigned-p) "assigned")))))
        (if (yes-or-no-p (if status
                            (concat "This bug is already " status
                                    "!  Do you really want to assign it? ")
                            "Assign bug? "))
	  (let ((assignee "")
		(assignment nil)
	        (urgent nil))
            (save-excursion
              (while (string= "" assignee)
                (setq assignee (read-string "Assign to: ")))
	      (setq assignment (get-field "ASSIGNED-TO"))
              (set-buffer bug-current-buffer)
	      (setq urgent (bug-urgent-p))
              (let ((buffer-read-only nil))
		(delete-field "CLAIMED-BY")
                (bug-field-find-or-insert "ASSIGNED-TO")
                (insert assignee " by " (user-login-name) " on "
			(current-time-string)))
              (let ((backup-by-copying t)) (save-buffer)))
            (bug-summary-line-update)
	    (prepare-assignment-report
	      (concat (info-bugname *bug-info*) " " bug-current-file)
	      (concat "Assigned to " assignee ": "
		      (bug-buffer-get-mail-field "Subject"))
	      urgent
	      assignment
	      *bug-info*
	      bug-current-buffer)))))))

(defun bug-claim ()
  "Assign the current bug to yourself and prepare a report about it."
  (interactive)
  (if bug-current-file
    (progn
      (bug-summary-goto-report)
      (let ((status (save-excursion
                      (set-buffer bug-current-buffer)
                      (cond ((bug-fixed-p) "fixed")
                            ((bug-assigned-p) "assigned")))))
        (if (yes-or-no-p (if status
                            (concat "This bug is already " status
                                    "!  Do you really want to claim it? ")
                            "Claim bug? "))
	  (let ((urgent nil)
		(assignment nil))
            (save-excursion
              (set-buffer bug-current-buffer)
	      (setq urgent (bug-urgent-p))
	      (setq assignment (get-field "ASSIGNED-TO"))
              (let ((buffer-read-only nil))
                (bug-field-find-or-insert "ASSIGNED-TO")
                (insert (user-login-name) " by " (user-login-name) " on "
			(current-time-string))
		(delete-field "CLAIMED-BY"))
              (let ((backup-by-copying t)) (save-buffer)))
            (bug-summary-line-update)
	    (prepare-claim-report
	      (concat (info-bugname *bug-info*) " " bug-current-file)
	      (concat "Claimed: " (bug-buffer-get-mail-field "Subject"))
	      urgent
	      assignment
	      *bug-info*
	      bug-current-buffer)))))))

(defun bug-unassign ()
  "Remove any assignment of the current bug and prepare a report about it."
  (interactive)
  (if bug-current-file
    (progn
      (bug-summary-goto-report)
      (let ((status (save-excursion
                      (set-buffer bug-current-buffer)
                      (cond ((bug-fixed-p) "Bug fixed!")
                            ((not (bug-assigned-p))
			    "Not assigned!")))))
        (if status
	  (message status)
          (if (yes-or-no-p "Abandon assignment? ")
	    ; could test for ownership of assignment here?
            (let ((assignment nil))
              (save-excursion
                (set-buffer bug-current-buffer)
                (let ((buffer-read-only nil))
		  (setq assignment (get-field "ASSIGNED-TO"))
		  (if (null assignment)
		    ;; Must be an old-style claim
		    (progn
		      (setq assignment (get-field "CLAIMED-BY"))
		      (delete-field "CLAIMED-BY"))
		    (delete-field "ASSIGNED-TO")))
                (let ((backup-by-copying t)) (save-buffer)))
              (bug-summary-line-update)
	      (prepare-unassignment-report
		(concat (info-bugname *bug-info*) " " bug-current-file)
	        (concat "Unassigned: " (bug-buffer-get-mail-field "Subject"))
		assignment
		*bug-info*))))))))

(defun bug-mark-urgent ()
  "Mark the current bug as urgent and prepare a report about it."
  (interactive)
  (if (and bug-current-file
	   (yes-or-no-p "Mark bug as urgent? "))
    (progn
      (bug-summary-goto-report)
      (let ((assignment nil))
        (save-excursion
          (set-buffer bug-current-buffer)
	  (setq assignment (get-field "ASSIGNED-TO"))
          (let ((buffer-read-only nil))
            (bug-field-find-or-insert "Status")
            (insert "urgent"))
          (let ((backup-by-copying t)) (save-buffer)))
        (bug-summary-line-update)
        (prepare-urgent-report
	  (concat (info-bugname *bug-info*) " " bug-current-file)
          (concat "Urgent: " (bug-buffer-get-mail-field "Subject"))
	  assignment
          *change-info*)))))

(defun bug-mark-rejected ()
  "Mark the current bug as rejected and prepare a report about it."
  (interactive)
  (if (and bug-current-file
	   (yes-or-no-p "Reject bug? "))
    (progn
      (bug-summary-goto-report)
      (save-excursion
        (set-buffer bug-current-buffer)
        (let ((buffer-read-only nil))
          (bug-field-find-or-insert "Fix")
          (insert "rejected, not a bug")
          (bug-field-find-or-insert "Fixed-by")
          (insert (user-login-name) " " (current-time-string))
          (bug-field-find-or-insert "Status")
          (insert "rejected")
	  (delete-field "CLAIMED-BY")
	  (delete-field "ASSIGNED-TO"))
        (let ((backup-by-copying t)) (save-buffer)))
      (bug-summary-line-update)
      (prepare-rejection-report
	(concat (info-bugname *bug-info*) " " bug-current-file)
	(concat "Rejected: " (bug-buffer-get-mail-field "Subject"))
	*bug-info*))))

(defun bug-mark-kept ()
  "Mark the current bug as unrepeatable and prepare a report about it."
  (interactive)
  (if (and bug-current-file
	   (yes-or-no-p "Mark bug as unrepeatable? "))
    (progn
      (bug-summary-goto-report)
      (save-excursion
        (set-buffer bug-current-buffer)
        (let ((buffer-read-only nil))
          (bug-field-find-or-insert "Fix")
          (insert "unrepeatable, keep report around for reference")
          (bug-field-find-or-insert "Fixed-by")
          (insert (user-login-name) " " (current-time-string))
          (bug-field-find-or-insert "Status")
          (insert "keep")
	  (delete-field "CLAIMED-BY")
	  (delete-field "ASSIGNED-TO"))
        (let ((backup-by-copying t)) (save-buffer)))
      (bug-summary-line-update)
      (prepare-kept-report
	(concat (info-bugname *bug-info*) " " bug-current-file)
	(concat "Unrepeatable: " (bug-buffer-get-mail-field "Subject"))
	*change-info*))))


;;;; handling fields


(defvar *field-regexp*  "^[ \t]*[^ \t\n][^ \t\n]*[ \t]*:"
  "regular expression to match generalized field header")

(defun start-of-field (field-name)
  (goto-char (point-min))
  (if (re-search-forward
       (concat "^[ \t]*" (regexp-quote field-name) "[ \t]*:[ \t]*")
       (point-max) t)
      (progn
	(skip-chars-forward " \t")
	(point))))

(defun end-of-field (field)
  (if (if (stringp field)
	  (start-of-field field)
	(goto-char field))
      (let ((first-point (point)))
	(if (re-search-forward *field-regexp* (point-max) 0)
	    (beginning-of-line))
	(skip-chars-backward " \t\n" first-point)
	(point))))


(defun get-field (field-name)
  ;; Returns the contents of the field field-name.  This is delimited by the
  ;; name string at the beginning of a line followed by a :  and another field
  ;; name or the end of file.  Leading and trailing white space is deleted 
  ;; (including new lines).  A value of nil indicates that the field does not
  ;; exist.
  (save-excursion
    (let ((first-char (start-of-field field-name)))
      (if first-char
	  (buffer-substring first-char (end-of-field first-char))))))

(defun delete-field (field-name)
  (save-excursion
    (if (start-of-field field-name)
      (progn
	(beginning-of-line)
	(forward-line -1)
        (kill-line)
        (kill-line)
	(kill-line)))))

(defun bug-buffer-get-field (field-name)
  ;; Like get-field but goes to the right buffer first
  (save-excursion
    (set-buffer bug-current-buffer)
    (get-field field-name)))


(defun bug-buffer-get-mail-field (field-name)
  ;; Like get-field but goes to the right buffer first
  (save-excursion
    (set-buffer bug-current-buffer)
    (mail-fetch-field field-name)))


(defun bug-field-find-or-insert (fieldname)
  ; finds and clears a field, or inserts a new one
  (let ((start (start-of-field fieldname)))
    (cond (start (let ((end (end-of-field start)))
		   (if (= start end)
		       (insert " ") ; make sure there is at least one
		     (delete-region start end))))
	  (t
	   (goto-char (point-max))
	   (insert (format "\n%s: \n" fieldname))
	   (backward-char 1)))))


;;; This is a bit baroque but seems to work - the null string and nil both
;;; have length zero. AJW 9/1/89

(defun bug-fixed-p ()
  (not (zerop (length (get-field "Fixed-by")))))

(defun bug-assigned-p ()
  (or (not (zerop (length (get-field "ASSIGNED-TO"))))
      (not (zerop (length (get-field "CLAIMED-BY"))))))

(defun bug-rejected-p ()
  (let ((field (get-field "Status")))
    (and field (string-equal field "rejected"))))

(defun bug-kept-p ()
  (let ((field (get-field "Status")))
    (and field (string-equal field "keep"))))

(defun bug-urgent-p ()
  (let ((field (get-field "Status")))
    (and field (string-equal field "urgent"))))


;;;; building the summary


(defvar *summary-cache-filename* "%summary%")
(defvar *summary-cache-buffer* nil)
(defvar *summary-cache-file* nil)
(defvar *force-rebuild-summary* nil)
(defvar *current-bug-directory* nil)
(defvar *bug-summary-buffer* nil)


(defun compute-bug-summary (bug-info change-info first-field)
  "Creates a bug summary of the news messages in DIRECTORY in 
a new buffer BUFNAME.  FUNCT should produce a one line summary of the
file and first-field is the field in the report that the system 
jumps to when it is displayed"
  (let* ((directory (concat *news-directory* (info-directory bug-info)))
	 (bufname (info-bufname bug-info))
	 (*bug-summary-buffer* (get-buffer-create bufname)))
    (setq *summary-cache-file*
	  (expand-file-name *summary-cache-filename* directory))
    (unwind-protect
	(progn
	  (setq *summary-cache-buffer*
		(if (file-exists-p *summary-cache-file*)
		    (find-file-noselect *summary-cache-file*)))
	  (setq *current-bug-directory* directory)
	  (condition-case err
	      (map-over-bug-files-with-buffer directory nil)
	    (error
	     (let ((rebuildp (y-or-n-p (concat "Error "
					       (message (prin1-to-string err))
					       " occurred -- force rebuild? "))))
	       (set-buffer *bug-summary-buffer*)
	       (delete-region (point-min) (point-max))
	       (if rebuildp
		   (map-over-bug-files-with-buffer directory t)
		 (insert-buffer *summary-cache-buffer*)
		 (message "Using old summary")))))
	  )
      (if *summary-cache-buffer*
	  (kill-buffer *summary-cache-buffer*))
      (setq *summary-cache-buffer* nil))
    (switch-to-buffer *bug-summary-buffer*)
    (bug-summary-mode)
    (make-local-variable '*bug-info*)
    (setq *bug-info* bug-info)
    (make-local-variable '*change-info*)
    (setq *change-info* change-info)
    (setq bug-file-directory directory)
    (setq bug-current-file nil)
    (setq bug-current-buffer nil)
    (setq bug-first-field first-field)
    (condition-case err
	(let ((make-backup-files nil))
	  (write-region (point-min) (point-max) *summary-cache-file* nil ':quiet)
	  (if (/= (file-modes *summary-cache-file*) 438) ; 666 octal
	      (set-file-modes *summary-cache-file* 438)))
      (error (message "%s" err)))
    (goto-char (point-max))
    (beginning-of-line)
    ;; this is a problem if the window isn't visible
    ;; (bug-summary-goto-report)
    ))


(defun map-over-bug-files-with-buffer (directory forcep)
  (message "Computing summary lines ...")
  (let ((*force-rebuild-summary* forcep)
	(standard-output *bug-summary-buffer*)
	(files (sort (directory-files directory nil "^[1-9][0-9]*$")
		     '(lambda (a b)
		        (< (string-to-int a) (string-to-int b))))))
    (mapcar 'recompute-summary-line files)
    (set-buffer *bug-summary-buffer*)
    (goto-char (point-max))
    (if (> (point) 1)
	(delete-char -1))		;kill the blank line at the end 
    (set-buffer-modified-p nil))
  (message "Computing summary lines ... done."))


(defun recompute-summary-line (filename)
  (let ((bug-file (expand-file-name filename *current-bug-directory*))
	(file-numb (string-to-int filename)))
    (if (zerop (% file-numb 10))
	(message "Computing summary lines ... %s" filename))
    (or (and (not *force-rebuild-summary*)
	     *summary-cache-buffer*
	     (file-newer-than-file-p *summary-cache-file* bug-file)
	     (progn
	       (set-buffer *summary-cache-buffer*)
	       (if (or (looking-at (concat filename " "))
		       (prog1
			   (re-search-forward (concat "^" filename " ")
					      (point-max) t)
			 (beginning-of-line)))
		   (let ((first-char (point))
			 (last-char (progn (end-of-line) (point))))
		     (set-buffer *bug-summary-buffer*)
		     (insert-buffer-substring *summary-cache-buffer*
					      first-char last-char)
		     (insert "\n")
		     t))))
	(progn
	  (set-buffer (find-file-noselect bug-file))
	  (print-summary-line file-numb)
	  (kill-buffer (current-buffer))))))


(defun print-summary-line (file-numb)
  "Read report in current buffer, write a summary line onto standard-output."
  (let ((date (or (get-field "X-Original-Date") (mail-fetch-field "Date")))
	(subject (mail-fetch-field "Subject")))
    (princ (format "%-6d" file-numb))
    (princ (if (bug-fixed-p)
	      (if (bug-rejected-p) "><"
		 (if (bug-kept-p) "?>" "<>"))
	     (if (and (bug-assigned-p) (bug-urgent-p)) "*!"
	        (if (bug-assigned-p) "* "
		   (if (bug-urgent-p) " !" "  ")))))
    (if subject
	(princ (left-justify subject 58))
      (princ (left-justify "NONE" 58)))
    (princ "    ")
    (if date (princ-date date) (princ "   UNKNOWN"))
    (princ "\n")))


(defun princ-date (date)
  ;; date format: [xxx, ][ |9]9 xxx 99[99]
  (if (char-equal (aref date 3) ?,) ; weekday?
      (setq date (substring date 5)))
  (let (year-pos)
    (if (char-equal (aref date 1) ? ) ; before the 10th of the month?
	(progn
	  (princ " ")
	  (princ (substring date 0 6))
	  (setq year-pos 6))
      (progn
	(princ (substring date 0 7))
	(setq year-pos 7)))
    (princ (if (or (<= (length date) (+ year-pos 2))
		   (char-equal (aref date (+ year-pos 2)) ? ))
	       (substring date year-pos (+ year-pos 2))
	     (substring date (+ year-pos 2) (+ year-pos 4))))))
  

(defun left-justify (str width)
  (if (> (length str) width)
      (substring str 0 width)
    (concat str (substring
		 "                                                                           "
		 0 (- width (length str))))))


(defun bug-summary-line-update ()
  "Update the summary line the cursor is on."
  (beginning-of-line)
  (let ((standard-output (current-buffer))
	(buffer-read-only nil)
	(start (point)))
    (forward-line 1)
    (delete-region start (point))
    (set-buffer bug-current-buffer)
    (print-summary-line (string-to-int (buffer-name)))
    (set-buffer standard-output)
    (forward-line -1)
    ))


;;;; Make reports


(defun report-bug (bug-group synopsis use-current-buffer)
  "Report a bug to BUG-GROUP with SYNOPSIS.  With c-U, picks up the
   bug report from the current buffer."
  (interactive (list (completing-read "Report bug in: " *bug-infos*)
		     (read-string "A short bug description: "
				  (if current-prefix-arg (get-field "Synopsis")))
		     current-prefix-arg))
  (let ((text-buffer (current-buffer)))
    (if (and (bug-report synopsis (find-info bug-group) use-current-buffer)
	     use-current-buffer)
	(let ((bug-buffer (current-buffer)) report)
	  (set-buffer text-buffer)
	  (save-excursion
	    (end-of-buffer) (search-backward "Site: Harlequin" (point-min) 1)
	    (setq report (buffer-substring (point) (point-max))))
	  (set-buffer bug-buffer)
	  (insert report)))
    ))

(defun bug-report (synopsis info &optional no-template)
  (let ((address (info-address info))
	(image-info (funcall (info-find-image info) t)))
    (if (mail nil address synopsis)
	(progn
	  (set-reply-to info (user-login-name))
	  (end-of-buffer)
	  (if (not no-template)
	      (progn
		(apply (info-template info) synopsis image-info)
		(start-of-field "Description")))
	  t)
      (message "Bug report command aborted.")
      nil)))


(defun bug-image-buffer-find-line (regexp point)
  (goto-char point)
  (and (re-search-forward regexp (point-max) t)
       (let ((begin (point)))
	 (end-of-line 1)
	 (buffer-substring begin (point)))))

(defun bug-guess-display ()
  (let ((disp (if (boundp 'x-display-name) x-display-name (getenv "DISPLAY"))))
    (if (and (not (equal disp "")) (eq (aref disp 0) ?:))
	(concat (system-name) disp)
	disp)))

(defun find-image-info (name)
  (let ((buffer (if name (get-buffer name) (current-buffer))))
    (if buffer
	(save-excursion
	  (if name
	      (set-buffer buffer))
	  (goto-char (point-max))
	  (if (re-search-backward "^LispWorks: " (point-min) t)
	      (let* ((point (point))
		     (saved-by (bug-image-buffer-find-line "^Saved by " point))
		     (version (bug-image-buffer-find-line "^Version " point))
		     (machine (bug-image-buffer-find-line "^User .* on " point))
		     (patched-version
		      (bug-image-buffer-find-line "^Patches loaded -- now version "
						  point)))
		(list (concat (or patched-version version) "\n         " saved-by)
		      machine
		      (bug-guess-display)))
	    (progn
	      (if (re-search-backward "^MLWorks(TM) Version " (point-min) t)
		  (list (bug-image-buffer-find-line "^MLWorks(TM) Version " (point))
			nil (bug-guess-display))
		)))))))


(defun find-ml-image (&optional return-data-p)
  (or (find-image-info nil)
      (find-image-info "*MLWorks server*")
      (find-image-info "ml")
      (find-image-info "*cmushell*")
      (find-image-info "*shell*")
      ))

(defun find-dummy-image (&optional return-data-p)
  '())


(defun set-reply-to (info originator)
  (let ((reply-address (info-reply-address info)))
    (if reply-address
	(if (start-of-field "Reply-to")
	    (insert reply-address ", ")
	  (progn
	    (mail-to)
	    (insert "\nReply-to: " reply-address ", " originator))))))


(defun bug-template (&optional synopsis version machine display)
  "Insert a bug report template at point."
  (interactive)
  (insert "Site: Harlequin\n\n")
  (insert "Version: " (or version "<unknown>") "\n\n")
  (insert "Machine & OS: " (or machine "") "\n\n")
  (insert "Display & window manager: " (or display "") "\n\n")
  (insert "Synopsis:    " (or synopsis "<a one-line problem description>") "\n\n")
  (insert "Description: <a more detailed description>\n\n")
  (insert "Repeat by:\n\n")
  (insert "Backtrace:\n\n")
)

(defun idea-template (&optional synopsis version machine display)
  "Insert a idea template at point."
  (interactive)
  (insert "Site: Harlequin\n\n")
  (insert "Synopsis:    " (or synopsis "<a one-line description>") "\n\n")
  (insert "Description: <a more detailed description>\n\n")
)


(defun change-report (info)
  (prepare-change-report nil nil info))

(defun prepare-change-report (id subject info)
  "Prepare a change report."
  (interactive)
  (if (mail nil (info-address info) subject)
      (progn
	(set-reply-to info (user-login-name))
	(end-of-buffer)
	(insert "\nVersion: (the version the change has been installed in)\n\n")
	(insert "Bug fix: ")
	(if id
	    (insert id "\n\n")
	    (insert "(the bug id if in response to a numbered bug)\n\n"))
	(insert "Approved by: \n\n")
	(insert "Files modified: (A list)\n\n")
	(insert "Files added: \n")
	(insert "Files removed: \n\n")
	(insert "Description:    (Outline of the changes made)\n")
	(mail-subject)
	)
      (message "Change report aborted.")))

(defun prepare-assignment-report (id subject urgent assignment info bug-buffer)
  "Prepare a assignment report."
  (interactive)
  (if (mail nil (info-reply-address info) subject)
      (progn
	(set-reply-to info (user-login-name))
	(end-of-buffer)
	(insert "\nBug assigned: " id "\n\n")
	(if urgent (insert "This bug is urgent!\n\n"))
	(if assignment (insert "Bug currently assigned to: " assignment "\n\n"))
	(insert-buffer bug-buffer)
	(mail-subject)
	)
      (message "Assignment report aborted.")))

(defun prepare-claim-report (id subject urgent assignment info bug-buffer)
  "Prepare a claim report."
  (interactive)
  (if (mail nil (info-reply-address info) subject)
      (progn
	(set-reply-to info (user-login-name))
	(end-of-buffer)
	(insert "\nBug claimed: " id "\n\n")
	(if urgent (insert "This bug is urgent!\n\n"))
	(if assignment (insert "Bug currently assigned to: " assignment "\n\n"))
	(insert-buffer bug-buffer)
	(mail-subject)
	)
      (message "Claim report aborted.")))

(defun prepare-unassignment-report (id subject assignment info)
  "Prepare a unassignment report."
  (interactive)
  (if (mail nil (info-reply-address info) subject)
      (progn
	(set-reply-to info (user-login-name))
	(end-of-buffer)
	(insert "\nBug unassigned: " id "\n")
	(insert "\nWas assigned to: " assignment "\n\n")
	(mail-subject)
	)
      (message "Unassignment report aborted.")))

(defun prepare-urgent-report (id subject assignment info)
  "Prepare a report of urgency."
  (interactive)
  (if (mail nil (info-reply-address info) subject)
      (progn
	(set-reply-to info (user-login-name))
	(end-of-buffer)
	(insert "\nBug marked urgent: " id "\n\n")
	(if assignment (insert "Bug currently assigned to: " assignment "\n\n"))
	(mail-subject)
	)
      (message "Urgency report aborted.")))

(defun prepare-rejection-report (id subject info)
  "Prepare a rejection report."
  (interactive)
  (if (mail nil (info-reply-address info) subject)
      (progn
	(set-reply-to info (user-login-name))
	(end-of-buffer)
	(insert "\nBug rejected: " id "\n\n")
	(mail-subject)
	)
      (message "Rejection report aborted.")))

(defun prepare-kept-report (id subject info)
  "Prepare a report of an unrepeatable bug."
  (interactive)
  (if (mail nil (info-reply-address info) subject)
      (progn
	(set-reply-to info (user-login-name))
	(end-of-buffer)
	(insert "\nUnrepeatable bug: " id "\n\n")
	(mail-subject)
	)
      (message "Kept report aborted.")))



;;;; wacky assignment functions


(defun info-directory-full (info)
  (concat *news-directory* (info-directory info)))


(defun state-matches-info-p (info)
  ;; Are we doing something related to the bug list specified by info?
  (cond ((equal (buffer-name) (info-bufname info))
	 (bug-summary-goto-report)
	 (set-buffer bug-current-buffer)
	 info)
	((equal default-directory
		(concat (info-directory-full info) "/"))
	 info)))


(defun current-bug-info ()
  (some (function state-matches-info-p) *bug-infos*))


(defun nice-time-string ()
  (let* ((timestring (current-time-string))
	 (day-etc (read-from-string timestring))
	 (month-etc (read-from-string timestring (cdr day-etc)))
	 (date-etc (read-from-string timestring (cdr month-etc)))
	 (time-etc (read-from-string timestring (cdr date-etc)))
	 (year-etc (read-from-string timestring (cdr time-etc))))
    (concat (format "%s" (car day-etc)) " "
	    (format "%s" (car month-etc)) " "
	    (format "%s" (car date-etc)) " "
	    (format "%s" (car year-etc)))))


;;;; other bug management functions


(defun hide-fixed-bugs ()
  "Remove all fixed bugs from the summary buffer."
  (interactive)
  (let ((buffer-read-only nil))
    (beginning-of-buffer)
    (delete-matching-lines "?>")
    (beginning-of-buffer)
    (delete-matching-lines "><")
    (beginning-of-buffer)
    (delete-matching-lines "<>"))
  (beginning-of-buffer))


(defun bug-forward (mailing-list-p info)
  "Forward the current buffer to a bug database,
with a prefix arg, to a bug mailing list."
  ;; It would be good idea to have a sane value of mail-yank-ignored-headers,
  ;; when you use this.
  (interactive (list current-prefix-arg
		     (completing-read "Move bug where: " *bug-infos*)))
  (bug-forward-1 info (current-buffer) mailing-list-p))


(defun bug-forward-1 (info-name bug-buffer mailing-list-p)
  (set-buffer bug-buffer)
  (let* ((info (assoc info-name *bug-infos*))
	 (newsgroup (info-newsgroup info))
	 (mail-self-blind nil)
	 (movedp (get-field "X-Originally-From"))
	 (originator (mail-fetch-field "From"))
	 (date (mail-fetch-field "Date")))
    (if (mail nil (if mailing-list-p (info-address info) newsgroup)
	      (mail-fetch-field "Subject") nil nil bug-buffer)
	(progn
	  (if mailing-list-p
	      (progn
		(set-reply-to info
			      (mail-strip-quoted-names (or movedp originator)))
		(end-of-buffer)))
	  (if (not movedp)
	      (insert "X-Originally-From: " originator "\n"
		      "X-Original-Date: " date "\n"))
	  (let ((mail-yank-ignored-headers
		 (concat mail-yank-ignored-headers
			 "\\|^Subject:\\|^From:\\|^Reply-To\\|^Date:\\|^Path:"
			 "\\|^Newsgroups:\\|^Lines:\\|^Organization:"
			 "\\|^Distribution:")))
	    (mail-yank-original 0))
	  newsgroup
	  )
      (progn (message "Bug moving aborted.") nil))))
