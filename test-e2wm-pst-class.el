;; How to run:
;;   emacs -batch \
;;       -L PATH/TO/E2WM/ \
;;       -L PATH/TO/WINDOW-LAYOUT/ \
;;       -l PATH/TO/test-e2wm-pst-class.el \
;;       -f ert-run-tests-batch-and-exit


(require 'ert)
(require 'e2wm)


(ert-deftest e2wm-pst-class-simple-inheritance ()
  (let* ((expected-result 1)
         (super-class
          (make-e2wm:$pst-class :init (lambda () expected-result)))
         (class
          (make-e2wm:$pst-class
           :extend super-class
           :init (lambda () (e2wm:$pst-class-super))))
         (result (e2wm:method-call
                  #'e2wm:$pst-class-init class nil)))
    (should (equal result expected-result))))


(ert-deftest e2wm-pst-class-grandchild ()
  (let* ((expected-result 1)
         (grand-class
          (make-e2wm:$pst-class :init (lambda () expected-result)))
         (super-class
          (make-e2wm:$pst-class
           :extend grand-class
           :init (lambda () (e2wm:$pst-class-super))))
         (class
          (make-e2wm:$pst-class
           :extend super-class
           :init (lambda () (e2wm:$pst-class-super))))
         (result (e2wm:method-call
                  #'e2wm:$pst-class-init class nil)))
    (should (equal result expected-result))))


(ert-deftest e2wm-pst-class-struct-access ()
  (let* ((expected-result 'test-class-name)
         (class
          (make-e2wm:$pst-class
           :init (lambda () (e2wm:$pst-class-name e2wm:@pst-class))
           :name expected-result))
         (result (e2wm:method-call
                  #'e2wm:$pst-class-init class nil)))
    (should (equal result expected-result))))


(defstruct (e2wm:$test-pst-class (:include e2wm:$pst-class)) test-slot)

(ert-deftest e2wm-pst-class-struct-inheritance ()
  (let* ((expected-result 1)
         (class
          (make-e2wm:$test-pst-class
           :init (lambda () (e2wm:$test-pst-class-test-slot e2wm:@pst-class))
           :test-slot expected-result))
         (result (e2wm:method-call
                  #'e2wm:$pst-class-init class nil)))
    (should (equal result expected-result))))
