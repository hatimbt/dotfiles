(define-module (thayyil features dtao-guile)
  #:use-module (srfi srfi-1)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (rde features)
  #:use-module (rde features predicates)
  #:use-module (dtao-guile home-service)
  #:export (feature-statusbar-dtao-guile))

(define (thayyil-dtao-guile-left-blocks)
  (append
   (map
    (lambda (tag)
      (let ((str (string-append "^p(8)" (number->string tag) "^p(8)"))
	    (index (- tag 1)))
	(dtao-block
	 (interval 0)
	 (events? #t)
	 (click `(match button
		   (0 (dtao:view ,index))))
	 (render `(cond
		   ((dtao:selected-tag? ,index)
		    ,(format #f "^bg(~a)^fg(~a)~a^fg()^bg()"
			     "#ffcc00"
			     "#191919"
			     str))
		   ((dtao:urgent-tag? ,index)
		    ,(format #f "^bg(~a)^fg(~a)~a^fg()^bg()"
			     "#ff0000"
			     "#ffffff"
			     str))
		   ((dtao:active-tag? ,index)
		    ,(format #f "^bg(~a)^fg(~a)~a^fg()^bg()"
			     "#323232"
			     "#ffffff"
			     str))
		   (else ,str))))))
    (iota 9 1))
   (list
    (dtao-block
     (events? #t)
     (click `(dtao:next-layout))
     (render `(string-append "^p(4)" (dtao:get-layout)))))))

(define (thayyil-dtao-guile-center-blocks)
  (list
   (dtao-block
    (events? #t)
    (render `(dtao:title)))))

(define (thayyil-dtao-guile-right-blocks)
  (list
   (dtao-block
    (interval 1)
    (render `(strftime "%A, %d %b (w.%V) %T" (localtime (current-time)))))
   (dtao-block
    (position "right")
    (interval 10)
    (render
     `(let* ((port (open-input-file ,"/sys/class/power_supply/BAT0/capacity"))
	     (result (read-line port))
	     (percent (string->number result)))
	(close-port port)
	(string-append "^fg("
		       (cond
			((<= percent 20) ,"#ff0000")
			((<= percent 50) ,"#ffffff")
			(else ,"#00ff00"))
		       ")" result "%^fg()"))))))

(define* (feature-statusbar-dtao-guile)
  "Install and configure dtao-guile."

  ;; Statusbar height
  (define height 25)

    (define (get-home-services config)
      "Return a list of home services required by dtao-guile."
      (list
          (service home-dtao-guile-service-type
	    (home-dtao-guile-configuration
	     (auto-start? #t)
	     (config
	      (dtao-config
	       (block-spacing 0)
	       (modules '((ice-9 match)
			  (ice-9 popen)
			  (ice-9 rdelim)
			  (srfi srfi-1)))
	       (padding-left 0)
	       (padding-top 0)
	       (padding-bottom 0)
	       (height 25)
	       ;; Ensure that blocks have spacing between them
	       (delimiter-right " ")
	       (left-blocks (thayyil-dtao-guile-left-blocks))
	       (right-blocks (thayyil-dtao-guile-right-blocks))
	       (center-blocks (thayyil-dtao-guile-center-blocks))))))))

      (feature
       (name 'statusbar-dtao-guile)
       (values `((statusbar? . #t)
                 (statusbar-height . ,height)
                 (dtao-guile . #t)))
       (home-services-getter get-home-services)))