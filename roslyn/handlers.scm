(require "helix/editor.scm")
; (require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix. "helix/configuration.scm"))
; (require (prefix-in helix. "helix/misc.scm"))
(require (prefix-in textDocument. "commands/textdocument.scm"))
(require (prefix-in workspace. "commands/workspace.scm"))

(provide initialize)

(define (initialize)
  (_roslyn_projectNeedsRestore)
  (projectInitializationComplete)
  (_roslyn_projectHasUnresolvedDependencies)
  (refreshSourceGeneratedDocument))

; TODO: logging?

(define (log-unimplemented call args)
  (log::info! (string-append "Got LSP call '" call "' which is not implemented yet. Args were: " (to-string args))))

;; handler for 'workspace/_roslyn_projectNeedsRestore'
(define (_roslyn_projectNeedsRestore)
  (helix.register-lsp-call-handler "csharp"
                                     "workspace/_roslyn_projectNeedsRestore"
                                     ; TODO: make configurable if immediately or prompt
                                     ; something here is still very weird.
                                     (lambda (call-id args) (workspace._roslyn_restore args))))


;; handler for 'workspace/projectInitializationComplete'
(define (projectInitializationComplete)
  (helix.register-lsp-call-handler "csharp"
                                     "workspace/projectInitializationComplete"
                                     ; (lambda (call-id args) (for-each textDocument.diagnostic (map (lambda (path) (string-append "file://" path)) (map editor-document->path (editor-all-documents)))))))
                                     (lambda (call-id args) (let ((paths (map (lambda (path) (string-append "file://" path)) (map editor-document->path (editor-all-documents)))))
                                                                      (for-each textDocument.diagnostic paths)
                                                                      (for-each textDocument._vs_getProjectContexts paths)))))


;; handler for 'workspace/_roslyn_projectHasUnresolvedDependencies'
(define (_roslyn_projectHasUnresolvedDependencies)
  (helix.register-lsp-call-handler "csharp"
                                     "workspace/_roslyn_projectHasUnresolvedDependencies"
                                     ; TODO: let the user know? prompt if restore is desired?
                                     (lambda (call-id args) (log-unimplemented "workspace/_roslyn_projectHasUnresolvedDependencies" args))))

;; handler for 'workspace/refreshSourceGeneratedDocument'
(define (refreshSourceGeneratedDocument)
  (helix.register-lsp-call-handler "csharp"
                                     "workspace/refreshSourceGeneratedDocument"
                                     ; TODO: find out what we have to do..
                                     ; probably involves calling 'sourceGeneratedDocument/_roslyn_getText'
                                     (lambda (call-id args) (log-unimplemented "workspace/refreshSourceGeneratedDocument" args))))
