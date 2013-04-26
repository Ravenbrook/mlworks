;; sml-mouse.el -- experimental!

;; A specialisation of the Emacs' mouse-drag-region.

;; This won't work in XEmacs at all.

;; Set up a mouse key like this:

;;(global-set-key [S-down-mouse-1] 'sml-mouse-drag-region)

;; and load this file into Emacs somehow. Eg:

;;(setq sml-load-hook 
;;      (function (lambda () "Get Mouse Feature..."
;;                     (load-library "sml-mouse")))


;; It *has* to be easier than this!
(defun sml-mouse-drag-region (start-event)
  "Set the region to the text that the mouse is dragged over, & send to ML.
Highlight the drag area as you move the mouse.
This must be bound to a button-down mouse event.
In Transient Mark mode, the highlighting remains once you
release the mouse button.  Otherwise, it does not."
  (interactive "e")
  (mouse-minibuffer-check start-event)
  (let* ((start-posn (event-start start-event))
	 (start-point (posn-point start-posn))
	 (start-window (posn-window start-posn))
	 (start-frame (window-frame start-window))
	 (bounds (window-edges start-window))
	 (top (nth 1 bounds))
	 (bottom (if (window-minibuffer-p start-window)
		     (nth 3 bounds)
		   ;; Don't count the mode line.
		   (1- (nth 3 bounds))))
	 (click-count (1- (event-click-count start-event))))
    (setq mouse-selection-click-count click-count)
    (mouse-set-point start-event)
    (let ((range (mouse-start-end start-point start-point click-count)))
      (move-overlay mouse-drag-overlay (car range) (nth 1 range)
		    (window-buffer start-window)))
    (deactivate-mark)
    (let (event end end-point)
      (track-mouse
	(while (progn
		 (setq event (read-event))
		 (or (mouse-movement-p event)
		     (eq (car-safe event) 'switch-frame)))
	  (if (eq (car-safe event) 'switch-frame)
	      nil
	    (setq end (event-end event)
		  end-point (posn-point end))

	    (cond
	     ;; Are we moving within the original window?
	     ((and (eq (posn-window end) start-window)
		   (integer-or-marker-p end-point))
	      (goto-char end-point)
	      (let ((range (mouse-start-end start-point (point) click-count)))
		(move-overlay mouse-drag-overlay (car range) (nth 1 range))))

	     (t
	      (let ((mouse-row (cdr (cdr (mouse-position)))))
		(cond
		 ((null mouse-row))
		 ((< mouse-row top)
		  (mouse-scroll-subr start-window (- mouse-row top)
				     mouse-drag-overlay start-point))
		 ((>= mouse-row bottom)
		  (mouse-scroll-subr start-window (1+ (- mouse-row bottom))
				     mouse-drag-overlay start-point)))))))))
      (if (consp event)
	  (let ((fun (key-binding (vector (car event)))))
	    ;; Run the binding of the terminating up-event, if possible.
	    ;; In the case of a multiple click, it gives the wrong results,
	    ;; because it would fail to set up a region.
	    (if (and (= (mod mouse-selection-click-count 3) 0) (fboundp fun))
		(progn
		  (setq this-command fun)
		  ;; Delete the overlay before calling the function,
		  ;; because delete-overlay increases buffer-modified-tick.
		  (delete-overlay mouse-drag-overlay)
		  (funcall fun event))
	      (if (not (= (overlay-start mouse-drag-overlay)
			  (overlay-end mouse-drag-overlay)))
		  (let (last-command this-command)
		    (push-mark (overlay-start mouse-drag-overlay) t t)
		    (goto-char (overlay-end mouse-drag-overlay))
		    (delete-overlay mouse-drag-overlay)
		    (copy-region-as-kill (point) (mark t))
		    (mouse-set-region-1))
		(goto-char (overlay-end mouse-drag-overlay))
		(setq this-command 'mouse-set-point)
		(delete-overlay mouse-drag-overlay))))
	(delete-overlay mouse-drag-overlay))))
  (sml-send-region (point) (mark)))
