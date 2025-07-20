(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix. "helix/configuration.scm"))
(require (prefix-in helix. "helix/misc.scm"))
(require (prefix-in helix.static. "helix/static.scm"))

(provide open-helix-scm open-init-scm dotnet-restore _roslyn_projectNeedsRestore)

(define (open-helix-scm)
  (helix.open (helix.static.get-helix-scm-path)))

(define (open-init-scm)
  (helix.open (helix.static.get-init-scm-path)))

;; project needs restore handler
(define (_roslyn_projectNeedsRestore)
  (helix.register-lsp-notification-handler "csharp"
                                     "workspace/_roslyn_projectNeedsRestore"
                                     (lambda (args) (log::info! (to-string args)) (dotnet-restore args) )))


;; dotnet restore command
(define (dotnet-restore . args) 
  (helix.send-lsp-command "csharp" "workspace/_roslyn_restore" (string->jsexpr "{\"projectFilePaths\": []}") (lambda (res) (log::info! (to-string res)))))
