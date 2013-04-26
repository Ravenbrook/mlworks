;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  emacs-server.el  -  receive files from emacs-server
;;;  ---------------------------------------------------
;;;
;;;  SCCS ID: 92/04/09 09:26:23 2.3 emacs-server.el
;;;
(defvar emacs-server-version "2.3"
  "Version of the emacs-server.el software")
;;;
;;;  Copyright (C) 1991 Claus Bo Nielsen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Global Variables (edit these vars for your system)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar se-server-program "/usr/local/lib/MLWorks/lib/emacs/etc/emacs-server"
  "*The program to use as the emacs-server")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  Private variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar se-server-running nil
  "Are we running the emacs-server program?")

(defvar se-argument ""
  "Save the called argument")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  emacs-server   - start the emacs-server program and setup filters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun emacs-server (&optional argument)
  "Start the emacs-server process; call the process from unix by the
command \"se <filename(s)>\". Emacs will find and display the file.
If the optional argument 'argument' is present give this to the 
emacs-server program as argument. If the emacs-server program dies
we will try to restart it, see the se-process-sentinel function."
  (interactive)
  (if (not se-server-running)
      (message "Starting emacs-server...")
    (delete-process se-server-process)    
    (message "Restarting emacs-server..."))
  (if argument
      (setq se-argument argument))
  (setq se-server-process
	(start-process "emacs-server" nil se-server-program se-argument))
  (setq se-server-running t)
  (set-process-filter se-server-process 'se-process-filter)
  (set-process-sentinel se-server-process 'se-process-sentinel)
  (process-kill-without-query se-server-process))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  se-process-filter    - input process filter
;;;  se-process-sentinel  - exit process filter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun se-process-filter (proc str)
  "Process filter for the emacs-server"
  (let ((first-char (string-to-char str)))
    (if (= first-char ?/)
	(find-file str)
      (if (not (= first-char 40))	; if not start with a "" 
	  (error "Elisp expression is not valid")
	(get-buffer-create "*emacs-server*")
	(set-buffer "*emacs-server*")
	(erase-buffer)
	(insert-string str)
	(eval-current-buffer)))))

(defun se-process-sentinel (proc msg)
  (setq se-server-running nil)		; it's not running any more
  (cond ((eq (process-status proc) 'exit)
	 (message "emacs-server subprocess exited"))
	((eq (process-status proc) 'signal)
	 (message "emacs-server subprocess killed")
;(emacs-server)
)))
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  End of emacs-server.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


