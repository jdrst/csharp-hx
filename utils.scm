(require "helix/editor.scm")
(require (prefix-in static. "helix/static.scm"))

(provide is-csharp-document?
         current-document
         get-file-uri
         to-rooted-file-uri)

(define (is-csharp-document? doc-id) (equal? (editor-document->language doc-id) "c-sharp"))

(define (current-document) (editor->doc-id (editor-focus)))

(define (get-file-uri doc-id) 
        (to-file-uri (editor-document->path doc-id)))

(define (to-rooted-file-uri path)
         (to-file-uri (string-append (static.get-helix-cwd) "/" path)))

(define (to-file-uri path) 
        (string-append "file://" path))
