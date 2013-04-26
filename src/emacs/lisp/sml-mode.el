;;; sml-mode.el. Major mode for editing (Standard) ML. Version 3.2

;; Copyright (C) 1989, Lars Bo Nielsen; 1994, Matthew J. Morley

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

;;; HISTORY 

;; Still under construction: History obscure, needs a biographer as
;; well as a M-x doctor. See attatched Change Log.

;; Hacked by Olin Shivers for comint from Lars Bo Nielsen's sml.el.

;; Hacked by Matthew Morley to incorporate Fritz Knabe's hilite
;; patterns, some of Steven Gilmore's easy-menus, and numerous
;; bugs and bug-fixes.

;;; DESCRIPTION 

;; This mode provides support for writing `pretty' ML programs. Once
;; in sml-mode you are provided with templates for
;; inserting ML forms -- let expressions, fun, datatype, struct, and
;; so on -- with some prompting and completion: bound to C-c C-m
;; (sml-insert-form) by default. The mode only has rudimentary
;; understanding of ML comments though.

;; Advertising: To interact with ML through this mode you need
;; sml-proc.el, and this depends on the comint package, and this
;; depends on ... and so on right back to the big bang. Comint usually
;; comes along with GNU Emacs, and XEmacs.

;; The highlighting of keywords is an excellent visual aid, and the
;; menu support "useful as an aide memoire". See sml-menus.el and
;; sml-{font,hilite}.el respectively. 

;;; FOR YOUR .EMACS FILE

;; If sml-mode.el lives in some non-standard directory, you must tell 
;; emacs where to get it. This may or may not be necessary:

;; (setq load-path (cons (expand-file-name "~jones/lib/emacs") load-path))

;; Then to access the commands autoload sml-mode with that command:

;; (autoload 'sml-mode "sml-mode" "Major mode for editing ML programs." t)
;;
;; Files ending in ".sml" or ".ML" are considered by emacs hereafter to
;; be Standard ML source, so put their buffers into sml-mode automatically

;; (setq auto-mode-alist
;;       (cons '(("\\.sml$" . sml-mode)
;;               ("\\.ML$"  . sml-mode)) auto-mode-alist))

;; Here's an example of setting things up in the sml-mode-hook:

;; (setq sml-mode-hook
;;       '(lambda() "ML mode hacks"
;;          (setq sml-indent-level 2         ; conserve on horiz. space
;;                indent-tabs-mode nil)))    ; whatever

;; sml-mode-hook is run whenever a new sml-mode buffer is created.
;; There is an sml-load-hook too, which is only run when this file is
;; loaded. One use for this hook is to select your preferred
;; highlighting scheme, like this:

;; (setq sml-load-hook
;;       '(lambda() "Highlights." (require 'sml-hilite)))

;; hilit19 is the magic that actually does the highlighting. My set up
;; for hilit19 runs something like this:

;; (if window-system
;;     (setq hilit-background-mode   t ; monochrome (alt: 'dark or 'light)
;;           hilit-inhibit-hooks     nil
;;           hilit-inhibit-rebinding nil
;;           hilit-quietly           t))

;; Alternatively, you can (require 'sml-font) which uses the font-lock
;; package instead. 

;; Finally, there is also an inferior-sml-mode-hook -- see
;; sml-proc.el. For more information consult the mode's *info* tree.

;;; VERSION STRING

(defconst sml-mode-version-string
  "sml-mode, Version 3.2")

(provide 'sml-mode)

;;; VARIABLES CONTROLLING THE MODE

(defvar sml-indent-level 2
  "*Indentation of blocks in ML.")

(defvar sml-pipe-indent -2
  "*Extra (usually negative) indentation for lines beginning with |.")

(defvar sml-case-indent nil
  "*How to indent case-of expressions.
    If t:   case expr                     If nil:   case expr of
              of exp1 => ...                            exp1 => ...
               | exp2 => ...                          | exp2 => ...

The first seems to be the standard in SML/NJ, but the second
seems nicer...")

(defvar sml-nested-if-indent nil
  "*Determine how nested if-then-else will be formatted:
    If t: if exp1 then exp2               If nil:   if exp1 then exp2
          else if exp3 then exp4                    else if exp3 then exp4
          else if exp5 then exp6                         else if exp5 then exp6
               else exp7                                      else exp7")

(defvar sml-type-of-indent t
  "*How to indent `let' `struct' etc.
    If t:  fun foo bar = let              If nil:  fun foo bar = let
                             val p = 4                 val p = 4
                         in                        in
                             bar + p                   bar + p
                         end                       end

Will not have any effect if the starting keyword is first on the line.")

(defvar sml-electric-semi-mode nil
  "*If t, `\;' will self insert, reindent the line, and do a newline.
If nil, just insert a `\;'. (To insert while t, do: C-q \;).")

(defvar sml-paren-lookback 1000
  "*How far back (in chars) the indentation algorithm should look
for open parenthesis. High value means slow indentation algorithm. A
value of 1000 (being the equivalent of 20-30 lines) should suffice
most uses. (A value of nil, means do not look at all)")

(defvar sml-mode-info "sml-mode"
  "*Where to find Info file for sml-mode.
The default assumes the info file \"sml-mode.info\" is on Emacs' info
directory path. If it is not, either put the file on the standard path
or set the variable sml-mode-info to the exact location of this file
which is part of the sml-mode 3.2 (and later) distribution. E.g:  

  (setq sml-mode-info \"/usr/me/lib/info/sml-mode\") 

in your .emacs file. You can always set it interactively with the
set-variable command.")

(defvar sml-mode-hook nil
  "*This hook is run when sml-mode is loaded, or a new sml-mode buffer created.
This is a good place to put your preferred key bindings.")

(defvar sml-load-hook nil
  "*This hook is only run when sml-mode is loaded.")

;;; CODE FOR SML-MODE 

(defun sml-mode-info ()
  "Command to access the TeXinfo documentation for sml-mode.
See doc for the variable sml-mode-info."
  (interactive)
  (require 'info)
  (condition-case nil
      (funcall 'Info-goto-node (concat "(" sml-mode-info ")"))
    (error (progn
             (describe-variable 'sml-mode-info)
             (message "Can't find it... set this variable first!")))))

(defun sml-indent-level (&optional indent)
   "Allow the user to change the block indentation level. Numeric prefix 
accepted in lieu of prompting."
   (interactive "NIndentation level: ")
   (setq sml-indent-level indent))

(defun sml-pipe-indent (&optional indent)
  "Allow to change pipe indentation level (usually negative). Numeric prefix
accepted in lieu of prompting."
   (interactive "NPipe Indentation level: ")
   (setq sml-pipe-indent indent))

(defun sml-case-indent (&optional of)
  "Toggle sml-case-indent. Prefix means set it to nil."
  (interactive "P")
  (setq sml-case-indent (and (not of) (not sml-case-indent)))
  (if sml-case-indent (message "%s" "true") (message "%s" nil)))

(defun sml-nested-if-indent (&optional of)
  "Toggle sml-nested-if-indent. Prefix means set it to nil."
  (interactive "P")
  (setq sml-nested-if-indent (and (not of) (not sml-nested-if-indent)))
  (if sml-nested-if-indent (message "%s" "true") (message "%s" nil)))

(defun sml-type-of-indent (&optional of)
  "Toggle sml-type-of-indent. Prefix means set it to nil."
  (interactive "P")
  (setq sml-type-of-indent (and (not of) (not sml-type-of-indent)))
  (if sml-type-of-indent (message "%s" "true") (message "%s" nil)))

(defun sml-electric-semi-mode (&optional of)
  "Toggle sml-electric-semi-mode. Prefix means set it to nil."
  (interactive "P")
  (setq sml-electric-semi-mode (and (not of) (not sml-electric-semi-mode)))
  (message "%s" (concat "Electric semi mode is " 
                   (if sml-electric-semi-mode "on" "off"))))

;;; BINDINGS: should be common to the source and process modes...

(defun install-sml-keybindings (map)
  ;; Text-formatting commands:
  (define-key map "\C-c\C-m" 'sml-insert-form)
  (define-key map "\C-c\C-i" 'sml-mode-info)
  (define-key map "\M-|"     'sml-electric-pipe)
  (define-key map "\;"       'sml-electric-semi)
  (define-key map "\M-\t"    'sml-back-to-outer-indent)
  (define-key map "\C-j"     'newline-and-indent)
  (define-key map "\177"     'backward-delete-char-untabify)
  (define-key map "\C-\M-\\" 'sml-indent-region)
  (define-key map "\t"       'sml-indent-line) ; ...except this one
  ;; Process commands added to sml-mode-map -- these should autoload
  (define-key map "\C-c\C-s" 'switch-to-sml)
  (define-key map "\C-c\C-l" 'sml-load-file)
  (define-key map "\C-c\C-r" 'sml-send-region)
  (define-key map "\C-c\C-b" 'sml-send-buffer)
  (define-key map "\C-c`"    'sml-next-error))

;;; Autoload functions -- another idea cribbed from AucTeX!

(defvar sml-no-doc
  "This function is part of sml-proc, and has not yet been loaded.
Full documentation will be available after autoloading the function."
  "Documentation for autoload functions.")

(autoload 'switch-to-sml   "sml-proc"   sml-no-doc t)
(autoload 'sml             "sml-proc"   sml-no-doc t)
(autoload 'sml-load-file   "sml-proc"   sml-no-doc t)
(autoload 'sml-send-region "sml-proc"   sml-no-doc t)
(autoload 'sml-send-buffer "sml-proc"   sml-no-doc t)
(autoload 'sml-next-error  "sml-proc"   sml-no-doc t)

(defvar sml-mode-map nil "The mode map used in sml-mode.")
(cond ((not sml-mode-map)
       (setq sml-mode-map (make-sparse-keymap))
       (install-sml-keybindings sml-mode-map)))

(defun sml-mode-version ()
  "This file's version number (sml-mode)."
  (interactive)
  (message sml-mode-version-string))

(defvar sml-mode-syntax-table nil "The syntax table used in sml-mode.")
(if sml-mode-syntax-table
    ()
  (setq sml-mode-syntax-table (make-syntax-table))
  ;; Set everything to be "." (punctuation) except for [A-Za-z0-9],
  ;; which will default to "w" (word-constituent).
  (let ((i 0))
    (while (< i ?0)
      (modify-syntax-entry i "." sml-mode-syntax-table)
      (setq i (1+ i)))
    (setq i (1+ ?9))
    (while (< i ?A)
      (modify-syntax-entry i "." sml-mode-syntax-table)
      (setq i (1+ i)))
    (setq i (1+ ?Z))
    (while (< i ?a)
      (modify-syntax-entry i "." sml-mode-syntax-table)
      (setq i (1+ i)))
    (setq i (1+ ?z))
    (while (< i 128)
      (modify-syntax-entry i "." sml-mode-syntax-table)
      (setq i (1+ i))))

  ;; Now we change the characters that are meaningful to us.
  (modify-syntax-entry ?\(      "()1"   sml-mode-syntax-table)
  (modify-syntax-entry ?\)      ")(4"   sml-mode-syntax-table)
  (modify-syntax-entry ?\[      "(]"    sml-mode-syntax-table)
  (modify-syntax-entry ?\]      ")["    sml-mode-syntax-table)
  (modify-syntax-entry ?{       "(}"    sml-mode-syntax-table)
  (modify-syntax-entry ?}       "){"    sml-mode-syntax-table)
  (modify-syntax-entry ?\*      ". 23"  sml-mode-syntax-table)
  (modify-syntax-entry ?\"      "\""    sml-mode-syntax-table)
  (modify-syntax-entry ?        " "     sml-mode-syntax-table)
  (modify-syntax-entry ?\t      " "     sml-mode-syntax-table)
  (modify-syntax-entry ?\n      " "     sml-mode-syntax-table)
  (modify-syntax-entry ?\f      " "     sml-mode-syntax-table)
  (modify-syntax-entry ?\'      "w"     sml-mode-syntax-table)
  (modify-syntax-entry ?\_      "w"     sml-mode-syntax-table))

;;These have moved to sml-font.el.

;;(defvar sml-font-lock-keywords
;;  '("\\blet\\b" "\\blocal\\b" "\\bin\\b" "\\bend\\b" 
;;    "\\bval\\b" "\\band\\b" "\\bfu?n\\b" 
;;    "\\b\\(data\\|eq\\|abs\\)?type\\b" 
;;    "\\bexception\\b" "\\braise\\b" "\\bhandle\\b"
;;    "\\bif\\b" "\\bthen\\b" "\\belse\\b"
;;    "\\bcase\\b" "\\bof\\b" 
;;    "\\bwhile\\b" "\\bdo\\b"
;;    "\\bas\\b"
;;    "!" ":=" "=>" 
;;    "\\bref\\b" "\\bandalso\\b" "\\borelse\\b"
;;    "\\bfunctor\\b" "\\bstruct\\(ure\\)?\\b" "\\bsig\\(nature\\)?\\b"
;;    "\\bsharing\\b" "\\bopen\\b")
;;  "*List of SML keywords for font-lock to highlight.")

(defun sml-mode ()
  "Major mode for editing ML code.
Tab indents for ML code.
Comments are delimited with (* ... *).
Blank lines and form-feeds separate paragraphs.
Delete converts tabs to spaces as it moves back.

For information on running an inferior ML process, see the documentation
for inferior-sml-mode (set this up with \\[sml]).

Customisation: Entry to this mode runs the hooks on sml-mode-hook.

Variables controlling the indentation
=====================================

Seek help (\\[describe-variable]) on individual variables to get current settings.

sml-indent-level (default 2)
    The indentation of a block of code.

sml-pipe-indent (default -2)
    Extra indentation of a line starting with \"|\".

sml-case-indent (default nil)
    Determine the way to indent case-of expression.

sml-nested-if-indent (default nil)
    Determine how nested if-then-else expressions are formatted.

sml-type-of-indent (default t)
    How to indent let, struct, local, etc.
    Will not have any effect if the starting keyword is first on the line.

sml-electric-semi-mode (default nil)
    If t, a `\;' will reindent line, and perform a newline.

sml-paren-lookback (default 1000)
    Determines how far back (in chars) the indentation algorithm should 
    look to match parenthesis. A value of nil, means do not look at all.

Mode map
========
\\{sml-mode-map}"

  (interactive)
  (kill-all-local-variables)
  (sml-mode-variables)
  (use-local-map sml-mode-map)
  (setq major-mode 'sml-mode)
  (setq mode-name "SML")
  (run-hooks 'sml-mode-hook))           ; Run the hook

;; What is the deal? This is a symbol, but it's also defined as a var?

(defvar sml-mode-abbrev-table nil "*SML mode abbrev table (default nil)")

(defun sml-mode-variables ()
  (set-syntax-table sml-mode-syntax-table)
  (setq local-abbrev-table sml-mode-abbrev-table)
  ;; A paragraph is separated by blank lines or ^L only.
  (make-local-variable 'paragraph-start)
  (setq paragraph-start (concat "^[\t ]*$\\|" page-delimiter))
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'sml-indent-line)
  (make-local-variable 'comment-start)
  (setq comment-start "(* ")
  (make-local-variable 'comment-end)
  (setq comment-end " *)")
  (make-local-variable 'comment-column)
  (setq comment-column 40)              
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "(\\*+[ \t]?")
  (make-local-variable 'comment-indent-function)
  (setq comment-indent-function 'sml-comment-indent)
  ;;
  ;; Adding these will fool the matching of parens. I really don't
  ;; know why. It would be nice to have comments treated as
  ;; white-space.
  ;; 
  ;;(make-local-variable 'parse-sexp-ignore-comments)
  ;;(setq parse-sexp-ignore-comments t)
  )

(defconst sml-pipe-matchers-reg
  "\\bcase\\b\\|\\bfn\\b\\|\\bfun\\b\\|\\bhandle\\b\
\\|\\bdatatype\\b\\|\\babstype\\b\\|\\band\\b"
  "The keywords a `|' can follow.")

(defun sml-electric-pipe ()
  "Insert a \"|\". 
Depending on the context insert the name of function, a \"=>\" etc."
  (interactive)
  (let ((case-fold-search nil)          ; Case sensitive
        (here (point))
        (match (save-excursion
                 (sml-find-matching-starter sml-pipe-matchers-reg)
                 (point)))
        (tmp "  => ")
        (case-or-handle-exp t))
    (if (/= (save-excursion (beginning-of-line) (point))
            (save-excursion (skip-chars-backward "\t ") (point)))
        (insert "\n"))
    (insert "|")
    (save-excursion
      (goto-char match)
      (cond
       ;; It was a function, insert the function name
       ((looking-at "fun\\b")
        (setq tmp (concat " " (buffer-substring
                               (progn (forward-char 3)
                                      (skip-chars-forward "\t\n ") (point))
                               (progn (forward-word 1) (point))) " "))
        (setq case-or-handle-exp nil))
       ;; It was a datatype, insert nothing
       ((looking-at "datatype\\b\\|abstype\\b")
        (setq tmp " ") (setq case-or-handle-exp nil))
       ;; If it is an and, then we have to see what is was
       ((looking-at "and\\b")
        (let (isfun)
          (save-excursion
            (condition-case ()
                (progn
                  (re-search-backward "datatype\\b\\|abstype\\b\\|fun\\b")
                  (setq isfun (looking-at "fun\\b")))
              (error (setq isfun nil))))
          (if isfun
              (progn
                (setq tmp
                      (concat " " (buffer-substring
                                   (progn (forward-char 3)
                                          (skip-chars-forward "\t\n ") (point))
                                   (progn (forward-word 1) (point))) " "))
                (setq case-or-handle-exp nil))
            (setq tmp " ") (setq case-or-handle-exp nil))))))
    (insert tmp)
    (sml-indent-line)
    (beginning-of-line)
    (skip-chars-forward "\t ")
    (forward-char (1+ (length tmp)))
    (if case-or-handle-exp
        (forward-char -4))))

(defun sml-electric-semi ()
  "Inserts a \;.
If variable sml-electric-semi-mode is t, indent the current line, insert 
a newline, and indent."
  (interactive)
  (insert "\;")
  (if sml-electric-semi-mode
      (reindent-then-newline-and-indent)))

;;; INDENTATION !!!

(defun sml-mark-function ()
  "Synonym for mark-paragraph -- sorry.
If anyone has a good algorithm for this..."
  (interactive)
  (mark-paragraph))

(defun sml-indent-region (begin end)
  "Indent region of ML code."
  (interactive "r")
  (message "Indenting region...")
  (save-excursion
    (goto-char end) (setq end (point-marker)) (goto-char begin)
    (while (< (point) end)
      (skip-chars-forward "\t\n ")
      (sml-indent-line)
      (end-of-line))
    (move-marker end nil))
  (message "Indenting region... done"))

(defun sml-indent-line ()
  "Indent current line of ML code."
  (interactive)
  (let ((indent (sml-calculate-indentation)))
    (if (/= (current-indentation) indent)
        (save-excursion                 ;; Added 890601 (point now stays)
          (let ((beg (progn (beginning-of-line) (point))))
            (skip-chars-forward "\t ")
            (delete-region beg (point))
            (indent-to indent))))
    ;; If point is before indentation, move point to indentation
    (if (< (current-column) (current-indentation))
        (skip-chars-forward "\t "))))

(defun sml-back-to-outer-indent ()
  "Unindents to the next outer level of indentation."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward "\t ")
    (let ((start-column (current-column))
          (indent (current-column)))
      (if (> start-column 0)
          (progn
            (save-excursion
              (while (>= indent start-column)
                (if (re-search-backward "^[^\n]" nil t)
                    (setq indent (current-indentation))
                  (setq indent 0))))
            (backward-delete-char-untabify (- start-column indent)))))))

(defconst sml-indent-starters-reg
  "abstraction\\b\\|abstype\\b\\|and\\b\\|case\\b\\|datatype\\b\
\\|else\\b\\|fun\\b\\|functor\\b\\|if\\b\\|sharing\\b\
\\|in\\b\\|infix\\b\\|infixr\\b\\|let\\b\\|local\\b\
\\|nonfix\\b\\|of\\b\\|open\\b\\|raise\\b\\|sig\\b\\|signature\\b\
\\|struct\\b\\|structure\\b\\|then\\b\\|\\btype\\b\\|val\\b\
\\|while\\b\\|with\\b\\|withtype\\b"
  "The indentation starters. The next line will be indented.")

(defconst sml-starters-reg
  "\\babstraction\\b\\|\\babstype\\b\\|\\bdatatype\\b\
\\|\\bexception\\b\\|\\bfun\\b\\|\\bfunctor\\b\\|\\blocal\\b\
\\|\\binfix\\b\\|\\binfixr\\b\\|\\bsharing\\b\
\\|\\bnonfix\\b\\|\\bopen\\b\\|\\bsignature\\b\\|\\bstructure\\b\
\\|\\btype\\b\\|\\bval\\b\\|\\bwithtype\\b\\|\\bwith\\b"
  "The starters of new expressions.")

(defconst sml-end-starters-reg
  "\\blet\\b\\|\\blocal\\b\\|\\bsig\\b\\|\\bstruct\\b\\|\\bwith\\b"
  "Matching reg-expression for the \"end\" keyword.")

(defconst sml-starters-indent-after
  "let\\b\\|local\\b\\|struct\\b\\|in\\b\\|sig\\b\\|with\\b"
  "Indent after these.")

(defun sml-calculate-indentation ()
  (save-excursion
    (let ((case-fold-search nil))
      (beginning-of-line)
      (if (bobp)                        ; Beginning of buffer
          0                             ; Indentation = 0
        (skip-chars-forward "\t ")
        (cond
         ;; Indentation for comments alone on a line, matches the
         ;; proper indentation of the next line. Search only for the
         ;; next "*)", not for the matching.
         ((looking-at "(\\*")
          (if (not (search-forward "*)" nil t))
              (error "Comment not ended."))
          (end-of-line)
          (skip-chars-forward "\n\t ")
          ;; If we are at eob, just indent 0
          (if (eobp) 0 (sml-calculate-indentation)))
         ;; Continued string ? (Added 890113 lbn)
         ((looking-at "\\\\")
          (save-excursion
            (if (save-excursion (previous-line 1)
                                (beginning-of-line)
                                (looking-at "[\t ]*\\\\"))
                (progn (previous-line 1) (current-indentation))
            (if (re-search-backward "[^\\\\]\"" nil t)
                (1+ (current-indentation))
              0))))
         ;; Are we looking at a case expression ?
         ((looking-at "|.*=>")
          (sml-skip-block)
          (sml-re-search-backward "=>")
          ;; Dont get fooled by fn _ => in case statements (890726)
          ;; Changed the regexp a bit, so fn has to be first on line,
          ;; in order to let the loop continue (Used to be ".*\bfn....")
          ;; (900430).
          (let ((loop t))
            (while (and loop (save-excursion
                               (beginning-of-line)
                               (looking-at "[^ \t]+\\bfn\\b.*=>")))
              (setq loop (sml-re-search-backward "=>"))))
          (beginning-of-line)
          (skip-chars-forward "\t ")
          (cond
           ((looking-at "|") (current-indentation))
           ((and sml-case-indent (looking-at "of\\b"))
            (1+ (current-indentation)))
           ((looking-at "fn\\b") (1+ (current-indentation)))
           ((looking-at "handle\\b") (+ (current-indentation) 5))
           (t (+ (current-indentation) sml-pipe-indent))))
         ((looking-at "and\\b")
          (if (sml-find-matching-starter sml-starters-reg)
              (current-column)
            0))
         ((looking-at "in\\b")          ; Match the beginning let/local
          (sml-find-match-indent "in" "\\bin\\b" "\\blocal\\b\\|\\blet\\b"))
         ((looking-at "end\\b")         ; Match the beginning
          (sml-find-match-indent "end" "\\bend\\b" sml-end-starters-reg))
         ((and sml-nested-if-indent (looking-at "else[\t ]*if\\b"))
          (sml-re-search-backward "\\bif\\b\\|\\belse\\b")
          (current-indentation))
         ((looking-at "else\\b")        ; Match the if
          (sml-find-match-indent "else" "\\belse\\b" "\\bif\\b" t))
         ((looking-at "then\\b")        ; Match the if + extra indentation
          (+ (sml-find-match-indent "then" "\\bthen\\b" "\\bif\\b" t)
             sml-indent-level))
         ((and sml-case-indent (looking-at "of\\b"))
          (sml-re-search-backward "\\bcase\\b")
          (+ (current-column) 2))
         ((looking-at sml-starters-reg)
          (let ((start (point)))
            (sml-backward-sexp)
            (if (and (looking-at sml-starters-indent-after)
                     (/= start (point)))
                (+ (if sml-type-of-indent
                       (current-column)
                     (if (progn (beginning-of-line)
                                (skip-chars-forward "\t ")
                                (looking-at "|"))
                         (- (current-indentation) sml-pipe-indent)
                       (current-indentation)))
                   sml-indent-level)
              (beginning-of-line)
              (skip-chars-forward "\t ")
              (if (and (looking-at sml-starters-indent-after)
                       (/= start (point)))
                  (+ (if sml-type-of-indent
                         (current-column)
                       (current-indentation))
                     sml-indent-level)
                (goto-char start)
                (if (sml-find-matching-starter sml-starters-reg)
                    (current-column)
                  0)))))
         (t
          (let ((indent (sml-get-indent)))
            (cond
             ((looking-at "|")
              ;; Lets see if it is the follower of a function definition
              (if (sml-find-matching-starter
                   "\\bfun\\b\\|\\bfn\\b\\|\\band\\b\\|\\bhandle\\b")
                  (cond
                   ((looking-at "fun\\b") (- (current-column) sml-pipe-indent))
                   ((looking-at "fn\\b") (1+ (current-column)))
                   ((looking-at "and\\b") (1+ (1+ (current-column))))
                   ((looking-at "handle\\b") (+ (current-column) 5)))
                (+ indent sml-pipe-indent)))
             (t
              (if sml-paren-lookback    ; Look for open parenthesis ?
                  (max indent (sml-get-paren-indent))
                indent))))))))))

(defun sml-get-indent ()
  (save-excursion
    (let ((case-fold-search nil))
      (beginning-of-line)
      (skip-chars-backward "\t\n; ")
      (if (looking-at ";") (sml-backward-sexp))
      (cond
       ((save-excursion (sml-backward-sexp) (looking-at "end\\b"))
        (- (current-indentation) sml-indent-level))
       (t
        (while (/= (current-column) (current-indentation))
          (sml-backward-sexp))
        (skip-chars-forward "\t |")
        (let ((indent (current-column)))
          (skip-chars-forward "\t (")
          (cond
           ;; Started val/fun/structure...
           ((looking-at sml-indent-starters-reg)
            (+ (current-column) sml-indent-level))
           ;; Indent after "=>" pattern, but only if its not an fn _ =>
           ;; (890726)
           ((looking-at ".*=>")
            (if (looking-at ".*\\bfn\\b.*=>")
                indent
              (+ indent sml-indent-level)))
           ;; else keep the same indentation as previous line
           (t indent))))))))

(defun sml-get-paren-indent ()
  (save-excursion
    (let ((levelpar 0)                  ; Level of "()"
          (levelcurl 0)                 ; Level of "{}"
          (levelsqr 0)                  ; Level of "[]"
          (backpoint (max (- (point) sml-paren-lookback) (point-min))))
      (catch 'loop
        (while (and (/= levelpar 1) (/= levelsqr 1) (/= levelcurl 1))
          (if (re-search-backward "[][{}()]" backpoint t)
              (if (not (sml-inside-comment-or-string-p))
                  (cond
                   ((looking-at "(") (setq levelpar (1+ levelpar)))
                   ((looking-at ")") (setq levelpar (1- levelpar)))
                   ((looking-at "\\[") (setq levelsqr (1+ levelsqr)))
                   ((looking-at "\\]") (setq levelsqr (1- levelsqr)))
                   ((looking-at "{") (setq levelcurl (1+ levelcurl)))
                   ((looking-at "}") (setq levelcurl (1- levelcurl)))))
            (throw 'loop 0)))           ; Exit with value 0
        (if (save-excursion
              (forward-char 1)
              (looking-at sml-indent-starters-reg))
            (1+ (+ (current-column) sml-indent-level))
          (1+ (current-column)))))))

(defun sml-inside-comment-or-string-p ()
  (let ((start (point)))
    (if (save-excursion
          (condition-case ()
              (progn
                (search-backward "(*")
                (search-forward "*)")
                (forward-char -1)       ; A "*)" is not inside the comment
                (> (point) start))
            (error nil)))
        t
      (let ((numb 0))
        (save-excursion
          (save-restriction
            (narrow-to-region (progn (beginning-of-line) (point)) start)
            (condition-case ()
                (while t
                  (search-forward "\"")
                  (setq numb (1+ numb)))
              (error (if (and (not (zerop numb))
                              (not (zerop (% numb 2))))
                         t nil)))))))))

(defun sml-skip-block ()
  (let ((case-fold-search nil))
    (sml-backward-sexp)
    (if (looking-at "end\\b")
        (progn
          (goto-char (sml-find-match-backward "end" "\\bend\\b"
                                              sml-end-starters-reg))
          (skip-chars-backward "\n\t "))
      ;; Here we will need to skip backward past if-then-else
      ;; and case-of expression. Please - tell me how !!
      )))

(defun sml-find-match-backward (unquoted-this this match &optional start)
  (save-excursion
    (let ((case-fold-search nil)
          (level 1)
          (pattern (concat this "\\|" match)))
      (if start (goto-char start))
      (while (not (zerop level))
        (if (sml-re-search-backward pattern)
            (setq level (cond
                         ((looking-at this) (1+ level))
                         ((looking-at match) (1- level))))
          ;; The right match couldn't be found
          (error (concat "Unbalanced: " unquoted-this))))
      (point))))

(defun sml-find-match-indent (unquoted-this this match &optional indented)
  (save-excursion
    (goto-char (sml-find-match-backward unquoted-this this match))
    (if (or sml-type-of-indent indented)
        (current-column)
      (if (progn
            (beginning-of-line)
            (skip-chars-forward "\t ")
            (looking-at "|"))
          (- (current-indentation) sml-pipe-indent)
        (current-indentation)))))

(defun sml-find-matching-starter (regexp)
  (let ((case-fold-search nil)
        (start-let-point (sml-point-inside-let-etc))
        (start-up-list (sml-up-list))
        (found t))
    (if (sml-re-search-backward regexp)
        (progn
          (condition-case ()
              (while (or (/= start-up-list (sml-up-list))
                         (/= start-let-point (sml-point-inside-let-etc)))
                (re-search-backward regexp))
            (error (setq found nil)))
          found)
      nil)))

(defun sml-point-inside-let-etc ()
  (let ((case-fold-search nil) (last nil) (loop t) (found t) (start (point)))
    (save-excursion
      (while loop
        (condition-case ()
            (progn
              (re-search-forward "\\bend\\b")
              (while (sml-inside-comment-or-string-p)
                (re-search-forward "\\bend\\b"))
              (forward-char -3)
              (setq last (sml-find-match-backward "end" "\\bend\\b"
                                                  sml-end-starters-reg last))
              (if (< last start)
                  (setq loop nil)
                (forward-char 3)))
          (error (progn (setq found nil) (setq loop nil)))))
      (if found
          last
        0))))

(defun sml-re-search-backward (regexpr)
  (let ((case-fold-search nil) (found t))
    (if (re-search-backward regexpr nil t)
        (progn
          (condition-case ()
              (while (sml-inside-comment-or-string-p)
                (re-search-backward regexpr))
            (error (setq found nil)))
          found)
      nil)))

(defun sml-up-list ()
  (save-excursion
    (condition-case ()
        (progn
          (up-list 1)
          (point))
      (error 0))))

(defun sml-backward-sexp ()
  (condition-case ()
      (progn
        (let ((start (point)))
          (backward-sexp 1)
          (while (and (/= start (point)) (looking-at "(\\*"))
            (setq start (point))
            (backward-sexp 1))))
    (error (forward-char -1))))

(defun sml-comment-indent ()
  (if (looking-at "^(\\*")              ; Existing comment at beginning
      0                                 ; of line stays there.
    (save-excursion
      (skip-chars-backward " \t")
      (max (1+ (current-column))        ; Else indent at comment column
           comment-column))))           ; except leave at least one space.

;;; INSERTING PROFORMAS (COMMON SML-FORMS) 

(defconst sml-form-alist
  '(("let") ("local") ("signature") ("structure") ("datatype")
    ("case") ("functor") ("abstype") ("abstraction"))
  "The list of regions to auto-insert.")

(defun sml-insert-form ()
  "Interactive short-cut to insert a common ML form."
  (interactive)
  (let ((newline nil)                   ; Did we insert a newline
        (name (completing-read "Form to insert: (default let) "
                               sml-form-alist nil t nil)))
    ;; default is "let"
    (if (string= name "") (setq name "let"))
    ;; Insert a newline if point is not at empty line
    (sml-indent-line)                   ; Indent the current line
    (if (save-excursion (beginning-of-line) (skip-chars-forward "\t ") (eolp))
        ()
      (setq newline t)
      (insert "\n"))
    (condition-case ()
        (cond
         ((string= name "let") (sml-let))
         ((string= name "local") (sml-local))
         ((string= name "structure") (sml-structure))
         ((string= name "signature") (sml-signature))
         ((string= name "abstraction") (sml-abstraction))
         ((string= name "functor") (sml-functor))
         ((string= name "case") (sml-case))
         ((string= name "abstype") (sml-abstype))
         ((string= name "datatype") (sml-datatype)))
      (quit (if newline 
                (progn
                  (delete-char -1)
                  (beep)))))))

(defun sml-let () 
  "Insert a `let in end'."
  (sml-let-local "let"))

(defun sml-local ()
  "Insert a `local in end'."
  (sml-let-local "local"))

(defun sml-signature ()
  "Insert a `signature ??? = sig end', prompting for name."
  (sml-structure-signature "signature"))

(defun sml-structure ()
  "Insert a `structure ??? = struct end', prompting for name."
  (sml-structure-signature "structure"))

(defun sml-case ()
  "Insert a case, prompting for case-expresion."
  (let (indent (expr (read-string "Case expr: ")))
    (insert (concat "case " expr))
    (sml-indent-line)
    (setq indent (current-indentation))
    (end-of-line)
    (if sml-case-indent
        (progn
          (insert "\n")
          (indent-to (+ 2 indent))
          (insert "of "))
      (insert " of\n")
      (indent-to (+ indent sml-indent-level)))
    (save-excursion (insert " => "))))

(defun sml-let-local (starter)
  (let (indent)
    (insert starter)
    (sml-indent-line)
    (setq indent (current-indentation))
    (end-of-line)
    (insert "\n") (indent-to (+ sml-indent-level indent))
    (insert "\n") (indent-to indent)
    (insert "in\n") (indent-to (+ sml-indent-level indent))
    (insert "\n") (indent-to indent)
    (insert "end") (previous-line 3) (end-of-line)))

(defun sml-structure-signature (which)
  (let (indent
        (name (read-string (concat "Name of " which ": "))))
    (insert (concat which " " name " ="))
    (sml-indent-line)
    (setq indent (current-indentation))
    (end-of-line)
    (insert "\n") (indent-to (+ sml-indent-level indent))
    (insert (if (string= which "signature") "sig\n" "struct\n"))
    (indent-to (+ (* 2 sml-indent-level) indent))
    (insert "\n") (indent-to (+ sml-indent-level indent))
    (insert "end") (previous-line 1) (end-of-line)))

(defun sml-functor ()
  "Insert `functor ? () : ? = struct end', prompting for name/type."
  (let (indent
        (name (read-string "Name of functor: "))
        (signame (read-string "Signature type of functor: ")))
    (insert (concat "functor " name " () : " signame " ="))
    (sml-indent-line)
    (setq indent (current-indentation))
    (end-of-line)
    (insert "\n") (indent-to (+ sml-indent-level indent))
    (insert "struct\n")
    (indent-to (+ (* 2 sml-indent-level) indent))
    (insert "\n") (indent-to (+ sml-indent-level indent))
    (insert "end") (previous-line 1) (end-of-line)))

(defun sml-abstraction ()
  "Insert `abstraction ? : ? = struct end', prompting for name/type."
  (let (indent
        (name (read-string "Name of abstraction: "))
        (signame (read-string "Signature type of abstraction: ")))
    (insert (concat "abstraction " name " : " signame " ="))
    (sml-indent-line)
    (setq indent (current-indentation))
    (end-of-line)
    (insert "\n") (indent-to (+ sml-indent-level indent))
    (insert "struct\n")
    (indent-to (+ (* 2 sml-indent-level) indent))
    (insert "\n") (indent-to (+ sml-indent-level indent))
    (insert "end") (previous-line 1) (end-of-line)))

(defun sml-datatype ()
  "Insert a `datatype ??? =', prompting for name."
  (let (indent 
        (type (read-string (concat "Type of datatype (default none): ")))
        (name (read-string (concat "Name of datatype: "))))
    (insert (concat "datatype "
                    (if (string= type "") "" (concat type " "))
                    name " ="))
    (sml-indent-line)
    (setq indent (current-indentation))
    (end-of-line) (insert "\n") (indent-to (+ sml-indent-level indent))))

(defun sml-abstype ()
  "Insert an `abstype 'a ??? = with ... end'"
  (let (indent
        (typevar (read-string "Name of type variable (default 'a): "))
        (type (read-string "Name of abstype: ")))
    (if (string= typevar "")
        (setq typevar "'a"))
    (insert (concat "abstype " typevar " " type " ="))
    (sml-indent-line)
    (setq indent (current-indentation))
    (insert "\n") (indent-to (+ sml-indent-level indent))
    (insert "\n") (indent-to indent)
    (insert "with\n") (indent-to (+ sml-indent-level indent))
    (insert "\n") (indent-to indent)
    (insert "end")
    (previous-line 3)
    (end-of-line)))

;;; Load the menus, if they can be found on the load-path,

(condition-case nil
    (require 'sml-menus)
  (error (message "Sorry, not able to load SML mode menus.")))

;;; & do the user's customisation

(add-hook 'sml-load-hook 'sml-mode-version t)

(run-hooks 'sml-load-hook)

;;; sml-mode.el has just finished.
