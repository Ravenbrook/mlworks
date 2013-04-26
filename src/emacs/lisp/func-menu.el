;;; func-menu.el --- Jump to a function within a buffer.
;;; Time-stamp: <94/08/19 10:15:23 brianm>
;;;
;;; SKG - 94/08/19 - Added dylan mode compatibility and mods for SML mode
;;
;; Author: Ake Stenhoff <etxaksf@aom.ericsson.se>
;;         Lars Lindberg <lli@sypro.cap.se>
;; Created: 10 Sep 1993
;; Version: 3.1
;; Keywords: tools
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:
;;
;; Purpose of this package:
;;   Jump to any function within the current buffer.
;;
;; How it works:
;;   Hit a key and it will generate a list of all functions in the 
;;   current buffer and bring up a dialog that you can choose from.
;;   Current version supports C/C++ and Lisp/Emacs Lisp, Dylan and SML.
;;
;; Installation:
;;   Put this file in your load-path and insert the following in .emacs
;;
;;   (cond window-system 
;;      (require 'func-menu)
;;      (define-key global-map [S-down-mouse-3] 
;;        'function-menu))

;;; Change Log:
;;    v3.1 Feb 1 1994 Lars Lindberg
;;       The sort function is now customizable - 'fume-sort-function'.
;;       The scanning message is now customizable -
;;       'fume-scanning-message'.  Made the default find functions
;;       more compact.  Added the ability to add a mode specific find
;;       function.
;;    v2.0 Jan 31 1994 Ake Stenhoff
;;       General workthrough before first public release.
;;       Thanks goes to Lars Lindberg.
;;    v1.0 Sep 10 1993 Ake Stenhoff
;;      First release.

;;; Code
(require 'cl)

;;;
;;; Customizable variables
;;;

(defvar fume-sort-function 'fume--sort-by-name
  "*The function to use for sorting the function menu.

Set this to nil if you don't want any sorting (faster).
The items in the menu are then presented in the order they were found
in the buffer.

The function should take two arguments and return T if the first
element should come before the second.  The arguments are cons cells;
(NAME . POSITION).  Look at 'fume--sort-by-name' for an example.")

(defvar fume-max-items 22
  "*Maximum number of elements in the function menu.")

(defvar fume-scanning-message "Scanning buffer. (%3d%%) done."
  "*Set this to nil if you don't want any progress messages during the
scanning of the buffer.")

;;;
;;;
;;;
(defvar fume-find-function-name-alist
  '((emacs-lisp-mode . fume--find-name-lisp)
    (lisp-mode . fume--find-name-lisp)
    (dylan-mode . fume--find-name-dylan)
    (sml-mode . fume--find-name-sml)
    (c-mode . fume--find-name-c)
    (c++-mode . fume--find-name-c++)
    (c++-c-mode . fume--find-name-c++))

  "An alist that connects modes with find functions.

The elements in the alist looks like: (MODE . FIND-FUNCTION).

MODE is the mode where you would like to use this package.

FIND-FUNCTION should be a function that takes no arguments and returns
a cons cell on the format (NAME . POSITION).

The first time that function is called the cursor is placed at the
begining of the buffer and the function should search forward from
that point.  It should leave the point at the position of the
function.
In the following calls the point is at the same place where
FIND-FUNCTION leftt it.  The function should return nil if it can find
no more functions.

See 'fume--find-name-lisp' or any of the other find functions at the
end of this file for examples.")

;;;
;;; Internal variables
;;;

;; The latest list of function names in the buffer.
;; Buffer local.
(defvar fume--funclist nil)
(make-variable-buffer-local 'fume--funclist)

;; The function to find function names in for the current mode for
;; this buffer.
;; This variable is set every time 'function-menu' is called.
(defvar fume--find-function nil)

;;;
;;; Internal support functions
;;;

;;;
;;; Sets 'fume--find-function' to something appropriate for the
;;; current mode for this buffer.
;;;
(defun fume--set-defaults ()
  (setq fume--find-function
	(cdr-safe (assoc major-mode fume-find-function-name-alist))))

;;;
;;; Sort function
;;; Sorts the items depending on their function-name
;;; An item look like (NAME . POSITION).
;;;
(defun fume--sort-by-name (item1 item2)
  (string-lessp (car item1) (car item2)))

;;;
;;; Support function to calculate relative position in buffer
(defun fume--relative-position ()
  (let ((pos (point))
	 (total (buffer-size)))
    (if (> total 50000)
	;; Avoid overflow from multiplying by 100!
	(/ (1- pos) (max (/ total 100) 1))
      (/ (* 100 (1- pos)) (max total 1)))))
    

;; Split LIST into sublists of max length N.
;; Example (fume--split '(1 2 3 4 5 6 7 8) 3)-> '((1 2 3) (4 5 6) (7 8))
(defun fume--split (list n)
  (let ((remain list)
	(result '())
	(sublist '())
	(i 0))
    (while remain
      (push (pop remain) sublist)
      (incf i)
      (and (= i n)
	   ;; We have finished a sublist
	   (progn (push (nreverse sublist) result)
		  (setq i 0)
		  (setq sublist '()))))
    ;; There might be a sublist (if the length of LIST mod n is != 0)
    ;; that has to be added to the result list.
    (and sublist
	 (push (nreverse sublist) result))
    (nreverse result)))

;;;
;;; Splits a menu in to several menus.
;;;
(defun fume--split-menu (menulist)
  (cons "Function menus"
	(mapcar
	 (function
	  (lambda (menu)
	    (cons (format "(%s)" (car (car menu)))
		  (cons '("*Rescan*" . -99) menu))))
	 (fume--split menulist fume-max-items))))

;;;
;;; The main function for this package!
;;;
(defun function-menu (event)
  "Pop up a menu of functions for selection with the mouse.

Jumps to the selected function.  A mark is set at the old position,
so you can easily go back with C-u \\[set-mark-command]."
  (interactive "e")
  ;; See to that the window where the mouse is really is selected.
  (let ((window (posn-window (event-start event))))
    (or (framep window) (select-window window)))
  (or (fume--set-defaults)
      (error "The mode \"%s\" is not implemented in 'function-menu' yet." mode-name))
  ;; Create a list for this buffer only if there isn't any. 
  (let ((funcname)
	(funclist '())
	(menu '()))
    (or fume--funclist
	(save-excursion
	  (beginning-of-buffer)
	  (and fume-scanning-message
	       (message fume-scanning-message 0))
	  (while (setq funcname (funcall fume--find-function))
	    (setq funclist (cons funcname funclist))
	    (and fume-scanning-message
		 (message fume-scanning-message (fume--relative-position))))
	  (and fume-scanning-message
	       (message fume-scanning-message 100))
	  (if fume-sort-function
	      (setq fume--funclist
		    (sort funclist fume-sort-function))
	    (setq fume--funclist (nreverse funclist)))))
    (or fume--funclist
	(error "No functions found in this buffer."))

    ;; Create the menu
    (setq menu (fume--split-menu fume--funclist))
    (let ((position (x-popup-menu event menu)))
      (cond
       ((not position)
	nil)
       ((= position -99)
	;; User wants to rescan the buffer.
	(setq fume--funclist nil)
	(function-menu event))
       (t
	;; Jump to selected function.
	(push-mark)
	(goto-char position))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; Some examples of finding functions
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Return the current/previous sexp and the location of the sexp (it's
;; beginning) without moving the point.
(defun fume--name-and-position ()
  (save-excursion
    (forward-sexp -1)
    (let ((beg (point))
	  (end (progn (forward-sexp) (point))))
      (cons (buffer-substring beg end)
	    beg))))
  
;;;
;;; Lisp
;;; 

;; Regular expression to find lisp functions
(defvar fume--function-name-regexp-lisp
  "^(defun [A-Za-z0-9_-]+[	 ]*(")

(defun fume--find-name-lisp (&optional regexp)
  ;; Search for the function
  (cond
   ((re-search-forward
     (or regexp fume--function-name-regexp-lisp)
     nil t)
    (backward-up-list 1)
    (fume--name-and-position))
   (t nil)))

;;;
;;; Dylan
;;; 

;; Regular expression to find lisp functions
(defvar fume--function-name-regexp-dylan
  "^(define-method [A-Za-z0-9_-]+[	 ]*(")

(defun fume--find-name-dylan (&optional regexp)
  ;; Search for the function
  (cond
   ((re-search-forward
     (or regexp fume--function-name-regexp-dylan)
     nil t)
    (backward-up-list 1)
    (fume--name-and-position))
   (t nil)))


;;;
;;; SML
;;; 

(setq fume--function-name-regexp-sml
  "^[ \t]*fun[ \t]+[A-Za-z0-9_-]+")


;;; Grab the whole function header, save point, and then step back
;;; to the start of the name woth (forward-word -1).
(defun fume--find-name-sml (&optional regexp)
  (cond
   ((re-search-forward
     (or regexp fume--function-name-regexp-sml)
     nil t)
    (let ((end (point))
;	  (beg (re-search-backward (or regexp "[ \t]") nil t)))
	  (beg (progn (forward-word -1) (point))))
	  (cons (buffer-substring beg end)
		beg)))
   (t nil)))

;;;
;;; C
;;;
;; Regular expression to find C functions
(defvar fume--function-name-regexp-c
  (concat 
   "^[a-zA-Z0-9]+[ \t]?"		; type specs; there can be no
   "\\([a-zA-Z0-9_*]+[ \t]+\\)?"	; more than 3 tokens, right?
   "\\([a-zA-Z0-9_*]+[ \t]+\\)?"
   "\\([*&]+[ \t]*\\)?"			; pointer
   "\\([a-zA-Z0-9_*]+\\)[ \t]*("	; name
   ))

(defun fume--find-name-c (&optional regexp)
  (let (char)
    ;; Search for the function
    (cond
     ((re-search-forward
       (or regexp fume--function-name-regexp-c)
       nil t)
      (backward-up-list 1)
      (save-excursion
	(goto-char (scan-sexps (point) 1))
	(setq char (following-char)))
      ;; Skip this function name if it is a prototype declaration.
      (if (eq char ?\;)
	  (fume--find-name-c regexp)
	(fume--name-and-position)))
     (t nil))))

;;; 
;;; C++
;;; 
;; Regular expression to find C++ functions
(defvar fume--function-name-regexp-c++
  (concat 
   "^[a-zA-Z0-9:]+[ \t]?"		; type specs; there can be no
   "\\([a-zA-Z0-9_:~*]+[ \t]+\\)?"	; more than 3 tokens, right?
   "\\([a-zA-Z0-9_:~*]+[ \t]+\\)?"
   "\\([*&]+[ \t]*\\)?"			; pointer
   "\\([a-zA-Z0-9_:*]+\\)[ \t]*("	; name
   ))
(defun fume--find-name-c++ ()
  (fume--find-name-c fume--function-name-regexp-c++))

(provide 'func-menu)

;;; func-menu.el ends here
