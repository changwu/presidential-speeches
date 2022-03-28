;;;; Emacs Lisp to help remove raw HTML from Presidential speeches. ;;;;

;;; See the difference from commit 234f92e33 to commit addac276a for
;;; an example of what this code does.

(defun strip-common-html-from-speech ()
  "Clean common HTML from a raw Presidential speech transcript.  

Specifically, do the following in this order:

  - replace \"&nbsp;</p>\" with \"\"
  - replace remaining \"<p>\" and \"</p>\" with \"\"
  - replace \"&nbsp;<br\\\\s-*/>\" with \"\\n\"
  - replace \"<br\\\\s-*/>\" with \"\\n\"
  - replace \"&nbsp;\" with \" \"

Afterwards, the buffer should have only the text of the speech,
with no HTML elements."
  (interactive)
  (goto-char (point-min))
  (let ((replacements (list (cons "&nbsp;</?p>"       "")
                            (cons "</?p>"             "")
                            ;; Sometimes you get a repeat on the next
                            ;; line.  Handle that just one instance:
                            (cons "&nbsp;<br\\s-*/>\n&nbsp;<br\\s-*/>"  "\n")
                            (cons "<br\\s-*/>\n&nbsp;<br\\s-*/>"  "\n")
                            (cons "<br\\s-*/>\n<br\\s-*/>"  "\n")
                            (cons "&nbsp;<br\\s-*/>"  "\n")
                            (cons "<br\\\s-*/>"       "\n")
                            (cons "&nbsp;$"           "")
                            (cons "&nbsp;"            " "))))
    (dolist (elt replacements)
      (save-excursion
        (replace-regexp (car elt) (cdr elt) nil (point-min) (point-max)))
      )))
