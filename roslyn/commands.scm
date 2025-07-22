; (require "helix/editor.scm")
; (require (prefix-in helix. "helix/commands.scm"))
; (require (prefix-in helix. "helix/configuration.scm"))
(require (prefix-in helix. "helix/misc.scm"))

(provide roslyn-restore
         pull-diagnostics)

(define (roslyn-restore projects)
  (helix.send-lsp-command "csharp"
                          "workspace/_roslyn_restore"
                          projects
                          ; TODO: callback for partial results? this seems to be called when every message has arrived. maybe via spawn-native-thread or the other undocumented future thang?
                          (lambda (res) (for-each (lambda (hm) (helix.set-status! (hash-get hm 'message))) res))))

(define (pull-diagnostics document-id)
  (helix.send-lsp-command "csharp"
                          "textDocument/diagnostic"
                          (hash "textDocument" (hash "uri" document-id))
                          (lambda (res) (log::info! (string-append "diagnostic result:" (to-string res))))))
