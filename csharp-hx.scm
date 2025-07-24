(require "helix/editor.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require (prefix-in helix. "helix/configuration.scm"))
(require (prefix-in helix. "helix/misc.scm"))
(require (prefix-in helix.static. "helix/static.scm"))
(require (prefix-in workspace. "roslyn/commands/workspace.scm"))

(provide
  open-helix-scm 
  open-init-scm 
  dotnet-restore
  solution-open
  project-open
  dotnet-build
  dotnet-test
  dotnet)

(define *current-solution* "")

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
  (define *solution-open* solution)
  (helix.send-lsp-command "csharp" "solution/open" (hash "solution" solution)))

;;@doc
;; load (a) project(s)
;; projects: the project(s) to load
(define (project-open . projects)
  (helix.send-lsp-command "csharp" "project/open" (hash "projects" projects)))

;;@doc
;; run dotnet build
;; shortcut for ':dotnet build <currently-loaded-solution>'
(define (dotnet-build)
  ; TODO: do we want/need this?
  ; (if (emtpy? *current-solution*)
  ;     (helix.set-status! "no solution loaded")
      (dotnet (list "build" *current-solution*)))

;;@doc
;; run dotnet test
;; shortcut for ':dotnet test <currently-loaded-solution>'
(define (dotnet-test)
  ; TODO: do we want/need this?
  ; (if (emtpy? *current-solution*)
  ;     (helix.set-status! "no solution loaded")
      (dotnet (list "test" *current-solution*)))

;;@doc
;; run a dotnet cli command
;; args: the args for the cli
(define (dotnet . args)
      (helix.run-shell-command (string-join (cons "dotnet" args) " ")))


