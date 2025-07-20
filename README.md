# csharp.hx

**This is heavily WIP. Expect things to break and/or not work**

# Installation

## Prerequisites

- [SofusA/csharp-language-server](https://github.com/SofusA/csharp-language-server)
- helix PR [#8675](https://github.com/helix-editor/helix/pull/8675)
- helix PR [#11315](https://github.com/helix-editor/helix/pull/11315)

(You can use my rebased branch [here](https://github.com/jdrst/helix/tree/steel-and-pull-diagnostics))

Probably:
`forge pkg install --git https://github.com/jdrst/csharp.hx.git`

then in your `init.scm`

`(require "csharp-hx/csharp-hx.scm")`

## Commands

Currently this only adds a few commands to helix. Namely:

- `:dotnet-restore`: restore via roslyn lsp.  
- `:solution-open`: open solution in roslyn lsp.
- `:project-open`: open project(s) in roslyn lsp.
- `:dotnet`: run a dotnet cli command.
- `:dotnet-build`: shortcut for `:dotnet build <current-solution>`
- `:dotnet-test`: shortcut for `:dotnet test <current-solution>`


