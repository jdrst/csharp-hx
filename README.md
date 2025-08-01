# csharp-hx

**This is heavily WIP. Expect things to break and/or not work**

# Installation

## Prerequisites

- Install [SofusA/csharp-language-server](https://github.com/SofusA/csharp-language-server)
- helix PR [#8675](https://github.com/helix-editor/helix/pull/8675)
- helix PR [#11315](https://github.com/helix-editor/helix/pull/11315)
- steel PR [#45](https://github.com/mattwparas/helix/pull/45)
- steel PR [#53](https://github.com/mattwparas/helix/pull/53)

If you want to try, i'd advise using [my frankenfork here](https://github.com/jdrst/helix/tree/steel-and-pull-diagnostics) (might be broken, no promises).

To get everything ready, just run `cargo xtask steel`.


## Installation

`forge pkg install --git https://github.com/jdrst/csharp-hx.git`

then in your `init.scm`

`(require "csharp-hx/init.scm")`

## Current state

- Handle `workspace/_roslyn_projectNeedsRestore` by immediately restoring via roslyn (`workspace/_roslyn_restore`)
- Handle `workspace/projectInitializationComplete` and call `textDocument/diagnostic` and `textDocument/_vs_getProjectContexts` for every open (csharp) buffer

## Commands

Currently this only adds a few commands to helix. Namely:

- `:dotnet-restore`: restore via roslyn lsp.  
- `:solution-open`: open solution in roslyn lsp.
- `:project-open`: open project(s) in roslyn lsp.
- `:dotnet`: run a dotnet cli command.
- `:dotnet-build`: shortcut for `:dotnet build <current-solution>`
- `:dotnet-test`: shortcut for `:dotnet test <current-solution>`


