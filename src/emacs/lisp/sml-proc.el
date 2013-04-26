;;; sml-proc.el. Comint based interaction mode for Standard ML.

;; Copyright (C) 1989, Lars Bo Nielsen, 1994, Matthew J. Morley

;; ====================================================================

;; This file is not part of GNU Emacs, but it is distributed under the
;; same conditions.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING. If not, write to the
;; Free Software Foundation, 675 Mass Ave, Cambridge, MA 0139, USA.
;; (See sml-mode.el for HISTORY.) 

;; ====================================================================

;; [MJM 10/94] Separating this from sml-mode means sml-mode will run
;; under 18.59 (or anywhere without comint, if there are such places).
;; See sml-mode.el for further information.

;;; DESCRIPTION

;; Inferior-sml-mode is for interacting with an ML process run under
;; emacs. This uses the comint package so you get history, expansion,
;; backup and all the other benefits of comint. Interaction is
;; achieved by M-x sml which starts a sub-process under emacs. You may
;; like to set this up for autoloading in your .emacs:

;; (autoload 'sml "sml-proc" "Run an inferior ML process." t)

;; Exactly what process is governed by the variable sml-program-name
;; -- "mlworks" by default. If you give a prefix argument (C-u M-x
;; sml) you will be prompted for a different program to execute from
;; the default -- if you just hit RETURN you get the default anyway --
;; along with the option to specify any command line arguments. Once
;; you select the ML program name in this manner, it remains the
;; default (unless you set in a hook, or otherwise).

;; NB inferior-sml-mode-hook is run AFTER the ML program has been
;; launched.

;; When running an ML process some further key-bindings are effective
;; in sml-mode buffer(s). C-c C-s (switch-to-sml) will split the
;; screen into two windows if necessary and place you in the ML
;; process buffer. In the interaction buffer, C-c C-s is bound to the
;; `sml' command by default (in case you need to restart).

;; C-c C-l (sml-load-file) will load an SML source file into the
;; inferior process, C-c C-r (sml-send-region) will send the current
;; region of text to the ML process, etc. Given a prefix argument to
;; these commands will switch you from the SML buffer to the ML
;; process buffer as well as sending the text. If you get errors
;; reported by the compiler, C-c ` (sml-next-error) will step through
;; the errors with you.

;; NOTE. There is only limited support for this as it obviously
;; depends on the compiler's error messages being recognised by the
;; mode. Error reporting is currently only geared up for MLWorks
;; (see file sml-mlworks.el). Look at the
;; documentation for sml-error-parser and sml-next-error -- you may
;; only need to modify the former to recover this feature for some
;; other ML systems, along with sml-error-regexp.

;; While small pieces of text can be fed quite happily into the ML
;; process directly, lager pieces should (probably) be sent via a
;; temporary file making use of the compiler's "use" command. 

;; CURRENT RATIONALE: you get sense out of the error messages if
;; there's a real file associated with a block of code, and XEmacs is
;; less likely to hang. These are likely to change.

;; For more information see the variable sml-temp-threshold. You
;; should set the variable sml-use-command appropriately for your ML
;; compiler. By default things are set up to work for the MLWorks
;; compiler.

;;; FOR YOUR .EMACS

;; Here  are some ideas for an inferior-sml-mode-hook:

;; (setq inferior-sml-mode-hook
;;      '(lambda() "Interaction ML mode hacks"
;;	 (define-key sml-mode-map          "\C-c\C-f" 'sml-send-function)
;;	 (define-key sml-mode-map          "\C-cd"    'sml-cd)
;;	 (define-key inferior-sml-mode-map "\C-cd"    'sml-cd)
;;	 (setq sml-temp-threshold 0 ; safe: always use tmp file
;;	       comint-scroll-show-maximum-output t
;;	       comint-input-autoexpand nil)))

;; ===================================================================

;;; INFERIOR ML MODE VARIABLES

(require 'sml-mode)
(require 'comint)

(defvar sml-program-name "mlworks"
  "*Program to run as ML.")

(defvar sml-default-arg "-tty"
  "*Default command line option to pass, if any.")

(defvar sml-use-command "use \"%s\""
  "*Template for loading a file into the inferior ML process.
Set to \"use \\\"%s\\\"\" for SML/NJ, Edinburgh ML or MLWorks; 
set to \"PolyML.use \\\"%s\\\"\" for Poly/ML, etc.")

(defvar sml-cd-command "System.Directory.cd \"%s\""
  "*ML command for changing directories in ML process (if possible).
See emacs command sml-cd.")

(defvar sml-prompt-regexp "^MLWorks>* *"
  "*Regexp used to recognise prompts in the inferior ML process.")

(defvar sml-error-regexp "^.+:[0-9]+.[0-9]+\\( to [0-9]+.[0-9]+\\)?: \\(error\\|warning\\):"
  "*Regexp for matching an error message.")

(defvar sml-error-parser 'sml-mlworks-error-parser
  "*This function parses an error message into a 3 or 5 element list:
  (file start-line start-col [end-line end-col]).

  If the file is standard input, this function should (probably) return 
  (\"std_in\" l c).")

(autoload 'sml-mlworks-error-parser  "sml-mlworks"   
  "This function is not yet to be loaded. Full documentation will be available 
   after autoloading." nil)

(defvar sml-temp-threshold 0
  "*Controls when emacs uses temporary files to communicate with ML. 
If not a number (e.g., NIL), then emacs always sends text directly to
the subprocess. If an integer N, then emacs uses a temporary file
whenever the text is longer than N chars. sml-temp-file contains the
name of the temporary file for communicating. See variable
sml-use-command and function sml-send-region.

Sending regions directly through the pty (not using temp files)
doesn't work very well -- e.g., SML/NJ nor Poly/ML incorrectly report
the line # of errors occurring in std_in.")

(defvar sml-temp-file (make-temp-name "/tmp/ml")
  "*Temp file that emacs uses to communicate with the ML process.
See sml-temp-threshold. Defaults to (make-temp-name \"/tmp/ml\")")

(defvar inferior-sml-mode-hook nil
  "*This hook is run when the inferior ML process is started.
This is a good place to put your preferred key bindings.")

;; Who ever want's multi-process support anyway?

(defvar sml-buffer nil "*The current ML process buffer.

MULTIPLE PROCESS SUPPORT
=====================================================================
sml-mode supports, in a fairly simple fashion, running multiple ML
processes. To run multiple ML processes, you start the first up with
\\[sml]. It will be in a buffer named *sml*. Rename this buffer with
\\[rename-buffer]. You may now start up a new process with another
\\[sml]. It will be in a new buffer, named *sml*. You can switch
between the different process buffers with \\[switch-to-buffer].

NB *sml* is just the default name for the buffer. It actually gets
it's name from the value of sml-program-name -- *poly*, *smld*,...

Commands that send text from source buffers to ML processes -- like
sml-send-function or sml-send-region -- have to choose a process to
send to, when you have more than one ML process around. This is
determined by the global variable sml-buffer. Suppose you have three
inferior ML's running:
    Buffer      Process
    foo         sml
    bar         sml<2>
    *sml*       sml<3>
If you do a \\[sml-send-function] command on some ML source code, what
process do you send it to?

- If you're in a process buffer (foo, bar, or *sml*), you send it to
  that process.
- If you're in some other buffer (e.g., a source file), you send it to
  the process attached to buffer sml-buffer.

This process selection is performed by function sml-proc.

Whenever \\[sml] fires up a new process, it resets sml-buffer to be
the new process's buffer. If you only run one process, this will do
the right thing. If you run multiple processes, you can change
sml-buffer to another process buffer with \\[set-variable].

More sophisticated approaches are, of course, possible. If you find
youself needing to switch back and forth between multiple processes
frequently, you may wish to consider writing something like ilisp.el,
a larger, more sophisticated package for running inferior Lisp and
Scheme processes. The approach taken here is for a minimal, simple
implementation. Feel free to extend it!"
)


;;; CODE

(defvar inferior-sml-mode-map nil)

(defvar sml-real-file nil)		; used for finding source errors
(defvar sml-error-cursor nil)		;   ditto
(defvar sml-error-barrier nil)		;   ditto


(defun sml-proc-buffer ()
  "Returns the current ML process buffer. See variable sml-buffer."
  (if (eq major-mode 'inferior-sml-mode) (current-buffer) sml-buffer))

(defun sml-proc ()
  "Returns the current ML process. See variable sml-buffer."
  (let ((proc (get-buffer-process (sml-proc-buffer))))
    (or proc
        (error "No current process. See variable sml-buffer"))))


(defun inferior-sml-mode ()
  "Major mode for interacting with an inferior ML process.

The following commands are available:
\\{inferior-sml-mode-map}

An ML process can be fired up (again) with \\[sml].

Customisation: Entry to this mode runs the hooks on comint-mode-hook
and inferior-sml-mode-hook (in that order).

Variables controlling behaviour of this mode are

sml-program-name (default \"sml\")
    Program to run as ML.

sml-use-command (default \"use \\\"%s\\\"\")
    Template for loading a file into the inferior ML process.

sml-cd-command (default \"System.Directory.cd \\\"%s\\\"\")
    ML command for changing directories in ML process (if possible).

sml-prompt-regexp (default \"^[\\-=] *\")
    Regexp used to recognise prompts in the inferior ML process.

sml-temp-threshold (default 0)
    Controls when emacs uses temporary files to communicate with ML. 
    If an integer N, then emacs uses a temporary file whenever the
    text is longer than N chars. 

sml-temp-file (default (make-temp-name \"/tmp/ml\"))
    Temp file that emacs uses to communicate with the ML process.

sml-error-regexp 
   (default \"^.+:[0-9]+.[0-9]+\\( to [0-9]+.[0-9]+\\)?: \\(error\\|warning\\):\")

    Regexp for matching error messages.

sml-error-parser (default 'sml-mlworks-error-parser)
    This function parses a error messages into a 3 or 5 element list:
    (file start-line start-col [end-line end-col]).

You can send text to the inferior ML process from other buffers containing
ML source.  
    switch-to-sml switches the current buffer to the ML process buffer.
    sml-send-function sends the current *paragraph* to the ML process.
    sml-send-region sends the current region to the ML process.

    Prefixing the sml-send-<whatever> commands with \\[universal-argument]
    causes a switch to the ML process buffer after sending the text.

For information on running multiple processes in multiple buffers, see
documentation for variable sml-buffer.

Commands:
RETURN after the end of the process' output sends the text from the 
    end of process to point.
RETURN before the end of the process' output copies the current line
    to the end of the process' output, and sends it.
DELETE converts tabs to spaces as it moves back.
TAB file name completion, as shell-mode, etc.."
  (interactive)
  (kill-all-local-variables)
  (comint-mode)
  (setq comint-prompt-regexp sml-prompt-regexp)
  (sml-mode-variables)

  ;; For sequencing through error messages:
  (make-local-variable 'sml-error-cursor)
  (setq sml-error-cursor (marker-position (point-max-marker)))
  (make-local-variable 'sml-error-barrier)
  (setq sml-error-barrier (marker-position (point-max-marker)))
  (make-local-variable 'sml-real-file)
  (setq sml-real-file (cons nil 0))

  (setq major-mode 'inferior-sml-mode)
  (setq mode-name "Inferior ML")
  (setq mode-line-process '(": %s"))
  (use-local-map inferior-sml-mode-map)

  (run-hooks 'inferior-sml-mode-hook))

;;; FOR RUNNING ML FROM EMACS
 
(defun sml (&optional pfx)
  "Run an inferior ML process, input and output via buffer *sml*. 
If there is a process already running in *sml*, just switch to that
buffer. With argument, allows you to edit the command line (default is
value of sml-program-name). Runs comint-mode-hook and
inferior-sml-mode-hook hooks in that order.

In fact the name of this buffer is chosen to reflect the name of the
command specified by sml-program-name, or entered at the prompt, or if
you explicitly set the variable sml-buffer. You can have several
inferior ML process running, but only one current one -- given by
sml-buffer.

\(Type \\[describe-mode] in the process buffer for a list of commands.)"

  (interactive "P")
  (let ((cmd (if pfx
		 (read-string "ML command: " sml-program-name)
	       sml-program-name))
	(args (if pfx
		  (read-string "Any args: " sml-default-arg)
		sml-default-arg)))
    (sml-run cmd args)))

(defun sml-run (cmd arg)
  "Run the ML program CMD with given arguments ARGS."
  (let ((pname (file-name-nondirectory cmd))
	(args (if (equal arg "") () (sml-args-to-list arg))))
    (let ((bname (concat "*" pname "*")))
      (if (not (comint-check-proc bname))
	  (progn (if (null args) 
		     ; there is a good reason for this; to ensure
		     ; *no* argument is sent, not even a "".
		     (set-buffer (apply 'make-comint pname cmd nil))
		   (set-buffer (apply 'make-comint pname cmd nil args)))
		 (message (concat "Starting \"" pname "\" in background."))
		 (inferior-sml-mode)
		 (goto-char (point-max))
                 ; and this -- to keep these as defaults even if
		 ; they're set in the mode hooks.
		 (setq sml-program-name pname
		       sml-default-arg arg)
		 (setq sml-buffer bname)
		 (switch-to-buffer-other-window bname))
	(progn
	  (setq sml-buffer bname)
	  (if (not (equal (buffer-name (current-buffer)) bname))
	      (switch-to-buffer-other-window bname)))))))

(defun sml-args-to-list (string)
  (let ((where (string-match "[ \t]" string)))
    (cond ((null where) (list string))
          ((not (= where 0))
           (cons (substring string 0 where)
                 (sml-args-to-list (substring string (+ 1 where)
					      (length string)))))
          (t (let ((pos (string-match "[^ \t]" string)))
               (if (null pos)
                   nil
                   (sml-args-to-list (substring string pos
						(length string)))))))))

(defun sml-temp-threshold (&optional thold)
  "Set the variable to the given prefix (nil, if no prefix given).
This is really just for debugging the mode!"
  (interactive "P")
  (setq sml-temp-threshold 
	(if current-prefix-arg (prefix-numeric-value thold)))
  (message "%s" sml-temp-threshold))

;; Fakes it with a "use <temp-file>;" if necessary.

(defun sml-send-region (start end &optional and-go)
  "Send current region to the inferior ML process.
Prefix argument means switch-to-sml afterwards.

If the region is shorter than sml-temp-threshold, the text is sent 
directly to the compiler; otherwise, it is written to a temp file and 
a \"use <temp-file>;\" command is sent to the compiler. 

See sml-temp-threshold, sml-temp-file and sml-use-command for details."

  (interactive "r\nP")
  (save-excursion
    (if (not (get-buffer-process (sml-proc-buffer))) (sml t)))
  (cond ((and (numberp sml-temp-threshold)
              (< sml-temp-threshold (- end start)))
         ;; Just in case someone is still reading from
         ;; sml-temp-file:
         (if (file-exists-p sml-temp-file)
             (delete-file sml-temp-file))
         (write-region start end sml-temp-file nil 'silently)
         (sml-update-barrier (buffer-file-name (current-buffer)) start)
         (sml-update-cursor (sml-proc-buffer))
         (comint-send-string (sml-proc)
                 (concat (format sml-use-command sml-temp-file) ";\n")))
        (t
         (comint-send-region (sml-proc) start end)
         (comint-send-string (sml-proc) ";\n")))
  (if and-go (switch-to-sml nil)))

;; Update the buffer-local variables SML-REAL-FILE and SML-ERROR-BARRIER
;; in the process buffer:

(defun sml-update-barrier (file pos)
  (let ((buf (current-buffer)))
    (unwind-protect (let* ((proc (sml-proc))
                           (pmark (marker-position (process-mark proc))))
                      (set-buffer (process-buffer proc))
                      (setq sml-real-file
                            (and file (cons file pos)))
                      (setq sml-error-barrier pmark))
      (set-buffer buf))))

;; Update the buffer-local error-cursor in PROC-BUFFER to be its
;; current proc mark.

(defun sml-update-cursor (proc-buffer)
  (let ((buf (current-buffer)))
    (unwind-protect (let* ((proc (sml-proc))
                           (pmark (marker-position (process-mark proc))))
                      (set-buffer proc-buffer)
                      (if proc
                          (setq sml-error-cursor pmark)))
      (set-buffer buf))))

;; This is quite bogus, so we don't bind it to keys by default.
;; Anyone coming up with an algorithm to recognise fun & local
;; declarations surrounding point will do everyone a favour!

(defun sml-send-function (&optional and-go)
  "Send current paragraph to the inferior ML process. 
With a prefix argument switch to sml buffer as well."
  (interactive "P")
  (save-excursion
    (sml-mark-function)
    (sml-send-region (point) (mark)))
  (if and-go (switch-to-sml nil)))

(defun sml-send-buffer (&optional and-go)
  "Send buffer to inferior shell running ML process. 
With a prefix argument switch to sml buffer as well."
  (interactive "P")
  (if (eq major-mode 'sml-mode)
    (sml-send-region (point-min) (point-max) and-go)))

(defun switch-to-sml (eob-p)
  "Switch to the ML process buffer.
With prefix argument, positions cursor at point, otherwise at end of buffer."
  (interactive "P")
  (if (sml-proc-buffer)
      (pop-to-buffer (sml-proc-buffer))
      (error "No current process buffer. See variable sml-buffer."))
  (cond ((not eob-p)
         (push-mark)
         (goto-char (point-max)))))


;; Since sml-send-function/region take an optional prefix arg, these
;; commands are redundant. But they are kept around for the user to
;; bind if she wishes, since its easier to type C-c r than C-u C-c C-r.

(defun sml-send-region-and-go (start end)
  "Send current region to the inferior ML process, and go there."
  (interactive "r")
  (sml-send-region start end nil))

(defun sml-send-function-and-go ()
  "Send current paragraph to the inferior ML process, and go there."
  (interactive)
  (sml-send-function nil))

;;; LOADING AND IMPORTING SOURCE FILES:

(defvar sml-source-modes '(sml-mode) 
  "Used to determine if a buffer contains ML source code. 
If it's loaded into a buffer that is in one of these major modes, it's
considered an ML source file by sml-load-file. Used by these commands
to determine defaults.")

(defvar sml-prev-l/c-dir/file nil
  "Caches the (directory . file) pair used in the last sml-load-file
or sml-load-file command. Used for determining the default in the
next one.")

(defun sml-load-file (&optional and-go)
  "Load an ML file into the inferior ML process. 
With a prefix argument switch to sml buffer as well."
  (interactive "P")
  (save-excursion
    (if (not (get-buffer-process (sml-proc-buffer))) (sml t)))
  (let ((file-name 
         (car (comint-get-source "Load ML file: " sml-prev-l/c-dir/file
                                 sml-source-modes t)))) ; why a flippin list?
    (comint-check-source file-name)     ; Check to see if buffer needs saved.
    (setq sml-prev-l/c-dir/file (cons (file-name-directory    file-name)
                                      (file-name-nondirectory file-name)))
    (sml-update-cursor (sml-proc-buffer))
    (comint-send-string (sml-proc)
                        (concat (format sml-use-command file-name) ";\n")))
  (if and-go (switch-to-sml nil)))


(defun sml-cd (dir)
  "Change the working directory of the inferior ML process.
The directory of the process buffer is changed as well. Set the
variable sml-cd-command."
  (interactive "DSML Directory: ")
  (let* ((buf (sml-proc-buffer))
         (proc (get-buffer-process buf))
         (dir (expand-file-name dir)))
    (if (not buf)
	(error "No current process buffer. See variable sml-buffer.")
      (set-buffer buf)
      (process-send-string proc (concat (format sml-cd-command dir) ";\n"))
      (cd dir)))
  (setq sml-prev-l/c-dir/file (cons dir nil)))


;;; PARSING ERROR MESSAGES

;; This should need no modification to support other compilers. See
;; sml-mlworks-error-parser (in sml-mlworks.el) for ideas. 

(defun sml-next-error ()
  "Find the next error by parsing the inferior ML buffer.
Move the error message on the top line of the window;
put the cursor at the beginning of the error source. If the
error message specifies a range, the mark is placed at the end. 

Error interaction has several limitations:

- See sml-mlworks-error-parser: only if there is a file associated with
  the input will the errors get tracked. A bug leaves cursor at the
  last error in interaction buffer if you try to search past it.

However: if the last text sent went via sml-load-file (or through the
temp file mechanism), the next error reported will be relative to the
start of the region sent, any error reports in the previous output
being forgotten.  If the text went directly to the compiler the `next'
error reported will be the next error relative to the location (in the
output) of the last error. This odd behaviour may have a use, I
suppose."

  (interactive)
  (let ((case-fold-search nil))
    (if (not (sml-proc-buffer))
	(error "No current process. See variable sml-buffer")
      (pop-to-buffer (sml-proc-buffer))
      (goto-char sml-error-cursor)        ; Goto last found error
      (if (re-search-forward sml-error-regexp (point-max) t) ; go to next err
	  (let* ((parse (funcall sml-error-parser (match-beginning 0)))
		 (file (nth 0 parse))
		 (line0 (nth 1 parse))
		 (col0 (nth 2 parse))
		 (line/col1 (cdr (cdr (cdr parse)))))
	    (setq sml-error-cursor (point))
	    
	    (set-window-start (get-buffer-window (sml-proc-buffer))
			      (save-excursion (beginning-of-line) (point)))
	    (cond ((equal file "std_in")
		   (error "Sorry, can't track errors through std_in."))
		  
		  ;; Errorful input came from temp file. 
		  ((equal file sml-temp-file)
		   (if (< (point) sml-error-barrier)
		       (error "Temp file error report not current.")
		     (let ((file (car sml-real-file))
			   (pos (cdr sml-real-file)))
		       (cond ((not file)
			      (error "No source file."))
			     ((not (file-readable-p file))
			      (error (concat "Can't read file " file)))
			     (t
			      (find-file-other-window file)
			      ;; If given, put mark at line/col1:
			      (cond (line/col1
				     (goto-char pos)
				     (if (> (car line/col1) 1)
					 (forward-line (1- (car line/col1))))
				     (forward-char (1+ (car (cdr line/col1))))
				     (push-mark)))
			      (goto-char pos)
			      (if (> line0 1) (forward-line (1- line0)))
			      (forward-char col0))))))
		  
		  ;; Errorful input came from a source file.
		  ((file-readable-p file)
		   (switch-to-buffer-other-window (find-file-noselect file))
		   ;; If given, put mark at line/col1:
		   (cond (line/col1
			  (goto-line (car line/col1))
			  (forward-char (1+ (car (cdr line/col1))))
			  (push-mark)))
		   (goto-line line0) (forward-char col0))
		  (t
		   (error (concat "Can't read file " file)))))
	(message "No error message(s) found.")))))


(defun sml-skip-errors ()
  "Skip past the rest of the errors."
  (interactive)
  (sml-update-cursor (sml-proc-buffer)))

;;; Set up the inferior mode keymap, using sml-mode bindings.

(cond ((not inferior-sml-mode-map)
       (setq inferior-sml-mode-map
             (copy-keymap comint-mode-map))
       (install-sml-keybindings inferior-sml-mode-map)
       (define-key inferior-sml-mode-map "\C-c\C-s" 'sml)
       (define-key inferior-sml-mode-map "\t"       'comint-dynamic-complete)))

(provide 'sml-proc)

;;; Here is where sml-proc.el ends

