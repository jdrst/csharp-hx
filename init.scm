(require (prefix-in handlers. "roslyn/handlers.scm"))
(require "csharp-hx.scm")


(provide
  open-helix-scm 
  open-init-scm 
  dotnet-restore
  solution-open
  project-open
  dotnet-build
  dotnet-test
  dotnet)


(handlers.initialize)
