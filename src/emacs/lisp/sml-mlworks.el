;;; sml-mlworks.el: Modifies inferior-sml-mode defaults for MLWorks.

;; Copyright (C) 1994, Matthew J. Morley, 1996, The Harlequin Group Limited.

;; This file is not part of GNU Emacs, but it is distributed under the
;; same conditions.

;; ====================================================================

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
;; Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;; ====================================================================

;;; DESCRIPTION

;; To use this library just put

;;(autoload 'sml-mlworks "sml-mlworks" "Set up and run MLWorks." t)

;; in your .emacs file. If you only ever use MLWorks
;; you might as well put something like

;;(setq sml-mode-hook
;;      '(lambda() "SML mode defaults to MLWorks"
;;	 (define-key  sml-mode-map "\C-cp" 'sml-mlworks)))

;; for your sml-mode-hook. The command prompts for the program name.

;;; CODE

(require 'sml-proc)

;; The reg-expression used when looking for errors. MLWorks errors:

(defvar sml-mlworks-error-regexp
  "^.+:[0-9]+.[0-9]+\\( to [0-9]+.[0-9]+\\)?: \\(error\\|warning\\):"
  "*Default regexp matching MLWorks error and warning messages.")

(defun sml-mlworks-error-parser (pt)
 "This function parses an MLWorks error message into a 3 or 5 element list:
  (file start-line start-col [end-line end-col])"

  (save-excursion
    (goto-char pt)
    (re-search-forward "^\\(.+\\):\\([0-9]+\\),\\([0-9]+\\)\\( to \\([0-9]+\\),\\([0-9]+\\)\\)?\
: \\(error\\|warning\\):")
    (let ((tail (and (match-beginning 4)
                     (list (string-to-int (buffer-substring     ; end line
                                           (match-beginning 5)
                                           (match-end 5)))
                           (1- (string-to-int (buffer-substring ; end col
                                               (match-beginning 6)
                                               (match-end 6))))))))
      (nconc (list (buffer-substring (match-beginning 1)        ; file
                                     (match-end 1))
                   (string-to-int (buffer-substring             ; start line
                                   (match-beginning 2)
                                   (match-end 2)))
                   (1- (string-to-int (buffer-substring         ; start col
                                       (match-beginning 3)
                                       (match-end 3)))))
             tail))))

(defun sml-mlworks ()
   "Set up and run MLWorks
Note: defaults set here will be clobbered if you setq them in the
{inferior-}sml-mode-hook.

 sml-program-name  <option>
 sml-default-arg   \"\"
 sml-use-command   \"use \\\"%s\\\"\"
 sml-cd-command    \"OS.FileSys.chDir \\\"%s\\\"\"
 sml-prompt-regexp \"^MLWorks>* *\"
 sml-error-regexp  sml-mlworks-error-regexp
 sml-error-parser  'sml-mlworks-error-parser"
   (interactive)
   (let ((cmd (read-string "Command name: " "mlworks")))
     (setq sml-program-name  cmd
	   sml-default-arg   " -tty"
	   sml-use-command   "use \"%s\""
	   sml-cd-command    "OS.FileSys.chDir \"%s\""
	   sml-prompt-regexp "^MLWorks>* *"
	   sml-error-regexp  sml-mlworks-error-regexp
	   sml-error-parser  'sml-mlworks-error-parser)
     (sml-run cmd sml-default-arg)))

;;; sml-mlworks.el fin

