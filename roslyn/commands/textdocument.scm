(require (prefix-in helix. "helix/misc.scm"))

(provide diagnostic
         _vs_getProjectContexts)

(define (diagnostic document-id)
  (helix.send-lsp-command "csharp"
                          "textDocument/diagnostic"
                          (hash "textDocument" (hash "uri" document-id))
                          (lambda (res) (log::info! (string-append "diagnostic result:" (to-string res))))))


; TODO: in vscode this might get called when the "active editor" changes. that should correspond to switching the buffer in helix. maybe we can 'register-hook!'
; for now we just call this and ignore the result 
(define (_vs_getProjectContexts document-id)
  (helix.send-lsp-command "csharp"
                          "textDocument/_vs_getProjectContexts"
                          (hash "_vs_textDocument" (hash "uri" document-id))
                          (lambda (res) (log::info! (string-append "_vs_getProjectContexts result:" (to-string res))))))
