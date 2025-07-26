

(provide set-project-initialized
         is-project-initialized?
         set-current-solution
         try-get-current-solution)

; TODO: state handling
; TODO: is there a better way than this?
(define state (mutable-vector #f ""))
(define project-initialized? #f)

(define (set-project-initialized bool) (vector-set! state 0 bool))
(define (is-project-initialized?) (vector-ref state 0))

(define (set-current-solution solution) (vector-set! state 1 solution))
(define (try-get-current-solution)
         (cond ((string=? (vector-ref state 1) "") #f)
         (else (vector-ref state 1))))
