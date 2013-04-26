;;; sml-menus.el. Simple menus for sml-mode

;; Copyright (C) 1994, Matthew J. Morley

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

;; You need auc-menu or easymenu on your lisp load-path.

;; Menus appear only when the insertion point is in an sml-mode
;; buffer. They should appear automatically as long as sml-mode can
;; find this file and easymenu.el, auc-menu.el, but not otherwise.

;; If you load sml-proc.el to run an inferior ML process -- or even a
;; superior one, who knows? -- the "Process" submenu will become active.

;;; CODE 

(condition-case () (require 'easymenu) (error (require 'auc-menu)))

;; That's FSF easymenu, distributed with GNU Emacs 19, or Per
;; Abrahamsen's auc-menu distributed with AUCTeX, or from the Emacs
;; lisp archive, or the IESD (http://ftp.iesd.auc.dk/pub/emacs-lisp)
;; lisp archive at Aalborg (auc-menu works with XEmacs too).

(defconst sml-menu
  (list "SML"
	(list "Process" ["Start default ML compiler" (sml nil) t]
	      ["-" nil nil]
	      ["load ML source file"        sml-load-file 
                :active (featurep 'sml-proc)]
	      ["switch to ML buffer"         (switch-to-sml nil) 
                :active (featurep 'sml-proc)]
	      ["--" nil nil]
	      ["send buffer contents"       sml-send-buffer 
                :active (featurep 'sml-proc)]
	      ["send region"                sml-send-region 
                :active (featurep 'sml-proc)]
	      ["send paragraph"             sml-send-function 
                :active (featurep 'sml-proc)]
	      ["goto next error"            sml-next-error 
                :active (featurep 'sml-proc)]
	      ["---" nil nil]
	      ["MLWorks"  sml-mlworks
                t]
	      ["Help for Inferior ML"   (describe-function 'inferior-sml-mode) 
                :active (featurep 'sml-proc)]
	      )
	["electric pipe"     sml-electric-pipe t]
	["insert SML form"   sml-insert-form t]
	(list "Forms" 
	      ["abstype"     (sml-abstype) t]
              ["datatype"    (sml-datatype) t]
              ["-" nil nil]
              ["let"         (sml-let) t]
              ["local"       (sml-local) t]
              ["case"        (sml-case) t]
              ["--" nil nil]
              ["signature"   (sml-signature) t]
              ["functor"     (sml-functor) t]
              ["structure"   (sml-structure) t]
              ["---" nil nil]
              ["abstraction" (sml-abstraction) t])
        (list "Format/Mode Variables"
              ["indent region"             sml-indent-region t]
              ["outdent"                   sml-back-to-outer-indent t]
	      ["-" nil nil]
              ["set indent-level"          sml-indent-level t]
              ["set pipe-indent"           sml-pipe-indent t]
	      ["--" nil nil]
              ["toggle type-of-indent"     (sml-type-of-indent) t]
              ["toggle nested-if-indent"   (sml-nested-if-indent) t]
              ["toggle case-indent"        (sml-case-indent) t]
              ["toggle electric-semi-mode" (sml-electric-semi-mode) t])
        ["-----" nil nil]
	["SML mode help (brief)"       describe-mode t]
	["SML mode *info*"             sml-mode-info t]
	["SML mode version"            sml-mode-version t]
	["-----" nil nil]
	["Fontify buffer"    (sml-mode-fontify-buffer)
                :active (or (featurep 'sml-font) (featurep 'sml-hilite))]
	))

(defun sml-mode-fontify-buffer ()
  "Just as it suggests."
  (if (featurep 'sml-font) 
      (font-lock-fontify-buffer)
    (if (featurep 'sml-hilite) 
	(hilit-rehighlight-buffer)
      (message "No highlight scheme specified")))) ; belt & braces

(easy-menu-define sml-mode-menu
    sml-mode-map
    "Menu used in sml-mode."
    sml-menu)

;;; Make's sure they appear in the menu bar when sml-mode-map is active.

;; On the hook for XEmacs only -- see easy-menu-add in auc-menu.el.

(defun sml-mode-menu-bar ()
  "Make sure menus appear in the menu bar as well as under mouse 3."
  (and (eq major-mode 'sml-mode)
       (easy-menu-add sml-mode-menu sml-mode-map)))

(add-hook 'sml-mode-hook 'sml-mode-menu-bar)

(autoload 'sml "sml-proc"   sml-no-doc t) ;; autoload all the proc. code

(autoload 'sml-mlworks "sml-mlworks" "An autoload function" t) 

(provide 'sml-menus)

;;; sml-menu.el is over now.
