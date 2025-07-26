(require "helix/editor.scm")
(require (prefix-in helix. "helix/misc.scm"))
(require (prefix-in state. "../state.scm"))
(require (prefix-in utils. "../../utils.scm"))


(provide diagnostic
         _vs_getProjectContexts)

(define (diagnostic document-uri)
  (helix.send-lsp-command "csharp"
                          "textDocument/diagnostic"
                          (hash "textDocument" (hash "uri" document-uri))
                          (lambda (res) (log::info! (string-append "diagnostic result:" (to-string res))))))



; TODO: in vscode this might get called when the "active editor" changes. that should correspond to switching the buffer in helix. we can 'register-hook!'
; todo: show diagnostic/warning if in temp workspace. for now we just call this and log the result
(define (_vs_getProjectContexts document-uri)
  (helix.send-lsp-command "csharp"
                          "textDocument/_vs_getProjectContexts"
                          (hash "_vs_textDocument" (hash "uri" document-uri))
                          (lambda (res) (log::info! (string-append "_vs_getProjectContexts result:" (to-string res))))))

; hook to get notified when the current buffer loses focus. calls _vs_getProjectContexts on the active buffer if we're initialized       
(register-hook! 'document-focus-lost
                ; (lambda (_) (if (utils.is-csharp-document? (utils.current-document))
                (lambda (_) (if (and (state.is-project-initialized?) (utils.is-csharp-document? (utils.current-document)))
                                (_vs_getProjectContexts (editor-document->path (utils.current-document))))))

; (require "helix/editor.scm") (define (is-csharp-document?) (equal? (editor-document->language (editor->doc-id (editor-focus))) "c-sharp")) (is-csharp-document?)
; (require "helix/editor.scm") (define (is-csharp-document? doc-id) (equal? (editor-document->language doc-id) "c-sharp")) (is-csharp-document? (editor->doc-id (editor-focus)))
; (require "helix/editor.scm") (define (current-document) (editor->doc-id (editor-focus))) (define (is-csharp-document? doc-id) (equal? (editor-document->language doc-id) "c-sharp")) (is-csharp-document? (current-document))
