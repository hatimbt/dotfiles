(define-module (thayyil utils)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1))

;; Helper for removing #<unspecified> from a list.
;; This means that we easily can conditionally add services to the list:
;;
;; @example
;; (list
;;   (simple-service ...)
;;   (simple-service ...)
;;   (when add-keybindings? (simple-service ...)))
;; @end example
(define-public (make-service-list . services)
  (filter (lambda (v) (not (unspecified? v))) services))