
(provide set-project-initialized
         is-project-initialized?)
; (provide project-initialized?)

; TODO: state handling
(define project-initialized? #f)

(define (set-project-initialized bool) (set! project-initialized? bool))
(define (is-project-initialized?) project-initialized?)
