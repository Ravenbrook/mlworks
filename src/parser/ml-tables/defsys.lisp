(in-package "CL-USER")

(defpackage "ML")

(defsystem::defsystem ml-parser
  (:default-pathname
   (directory-namestring *load-truename*))
  :members (ml-pgen
	    op-parser
	    new-tables
	    back-convert
	    )
  :rules ((:in-order-to :compile :all
			(:requires (:load :serial)))))

(compile-system 'ml-parser)
(load-system 'ml-parser)

