(require (prefix-in helix. "helix/misc.scm"))
(require (prefix-in helix. "helix/commands.scm"))

(provide _roslyn_restore)

(define (_roslyn_restore projects)
  (helix.send-lsp-command "csharp"
                          "workspace/_roslyn_restore"
                          projects
                          ; TODO: callback for partial results? this seems to be called when every message has arrived. maybe via spawn-native-thread or the other undocumented future thang?
                          ; TODO: errorhandling?
                          (lambda (res) (for-each (lambda (hm) (helix.set-status! (hash-get hm 'message))) res))))


