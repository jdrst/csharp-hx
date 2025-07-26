(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix. "helix/configuration.scm"))
(require (prefix-in helix. "helix/misc.scm"))
(require (prefix-in helix.static. "helix/static.scm"))
(require (prefix-in workspace. "roslyn/commands/workspace.scm"))
(require (prefix-in utils. "utils.scm"))
(require (prefix-in state. "roslyn/state.scm"))

(provide
  open-helix-scm 
  open-init-scm 
  dotnet-restore
  solution-open
  project-open
  dotnet-build
  dotnet-test
  dotnet)


(define (open-helix-scm)
  (helix.open (helix.static.get-helix-scm-path)))

(define (open-init-scm)
  (helix.open (helix.static.get-init-scm-path)))


;;@doc
;; dotnet restore via roslyn lsp
;; projects: the projects to restore, leave empty for all
(define (dotnet-restore . projects)
  (workspace._roslyn_restore (to-project-file-paths projects)))


(define (to-project-file-paths projects)
      (hash "projectFilePaths" projects))

;;@doc
;; load a solution
;; solution: the solution to load
(define (solution-open solution)
  ; TODO: do we need to check if not string/single item?
  ; TODO: does a null (void) reponse mean "ok"? (probably)
  ; TODO: when we call this without a solution already opened, we somehow need to know that the workspace switched?
  (helix.send-lsp-command "csharp" "solution/open"
                         (hash "solution" (utils.to-rooted-file-uri solution))
                         (lambda (res) (if (void? res)
                                           (state.set-current-solution solution)))))

;;@doc
;; load (a) project(s)
;; projects: the project(s) to load
(define (project-open . projects)
  ; TODO handle stuff.. bad support atm
  (helix.send-lsp-command "csharp" "project/open"
                          (hash "projects" (map utils.to-rooted-file-uri (projects)))
                          (lambda (res) (log::info! (to-string res)))))

;;@doc
;; run dotnet build
;; shortcut for ':dotnet build <currently-loaded-solution>'
(define (dotnet-build)
        (let ((solution (state.try-get-current-solution)))
        (if solution
              (dotnet "build" solution)
              (helix.set-status! "Can't build. No solution loaded."))))

;;@doc
;; run dotnet test
;; shortcut for ':dotnet test <currently-loaded-solution>'
(define (dotnet-test)
        (let ((solution (state.try-get-current-solution)))
        (if solution
              (dotnet "test" solution)
              (helix.set-status! "Can't test. No solution loaded."))))

;;@doc
;; run a dotnet cli command
;; args: the args for the cli
(define (dotnet . args)
      (helix.run-shell-command (string-join (cons "dotnet" args) " ")))


