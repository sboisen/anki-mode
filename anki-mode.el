 ;;; anki-mode.el --- Anki major mode

 ;; Author: Sean Boisen
 ;; Keywords: extensions

 ;; This file is free software; you can redistribute it and/or modify
 ;; it under the terms of the GNU General Public License as published by
 ;; the Free Software Foundation; either version 2, or (at your option)
 ;; any later version.

 ;; This file is distributed in the hope that it will be useful,
 ;; but WITHOUT ANY WARRANTY; without even the implied warranty of
 ;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ;; GNU General Public License for more details.

 ;; You should have received a copy of the GNU General Public License
 ;; along with GNU Emacs; see the file COPYING.  If not, write to
 ;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 ;; Boston, MA 02111-1307, USA.

 ;;; Commentary:

 ;; This mode has trivial extensions for editing text files to be
 ;; loaded into Anki: it has no actual flashcard features. 

 ;;; Code:

(defvar anki-mode-hook nil)

(defvar anki-mode-map
   (let ((map (make-sparse-keymap)))
     (define-key map "\M-{" 'anki-insert-cloze)
     (define-key map "<M-up>" 'anki-up-list)
     map)
   "Keymap for `anki-mode'.")

(add-to-list 'auto-mode-alist '("\\.anki\\'" . anki-mode))

(defvar anki-mode-syntax-table
   (let ((st (make-syntax-table)))
     st)
   "Syntax table for `anki-mode'.")


(defun anki-insert-cloze (&optional arg)
  "Enclose following ARG sexps in double curly brackets and insert
'c1::', then leave point after identifier. 

A negative ARG encloses the preceding ARG sexps instead.
No argument is equivalent to zero: just insert and leave point between.
If `parens-require-spaces' is non-nil, this command also inserts a space
before and after, depending on the surrounding characters.
If region is active, insert enclosing characters at region boundaries.

This command assumes point is not in a string or comment."
  (interactive "P")
  (insert-pair arg ?\{ ?\})
  (insert-pair arg ?\{ ?\})
  (down-list 2)
  (insert-string "c1::")
  (backward-char 2))

(defun anki-up-list (&optional arg)
  "When inside a cloze, move out of the expression and forward past it. "
  (interactive "P")
  (up-list arg)
  (up-list arg))

(defun anki-mode ()
  "Minor mode for editing files to be loaded into Anki. There's no SRS
  functionality here: it's just editing convenience. "
  (interactive)
  (kill-all-local-variables)
  (use-local-map anki-mode-map)
  (set-syntax-table anki-mode-syntax-table)
  (setq major-mode 'anki-mode)
  (setq mode-name "Anki")
  (run-hooks 'anki-mode-hook))

(provide 'anki-mode)

;;; anki-mode.el ends here

