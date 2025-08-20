# Notes for development

## [steel](https://github.com/mattwparas/steel)

## [Book](https://mattwparas.github.io/steel/book/)

## [steel in hx](https://github.com/jdrst/helix/blob/steel-and-pull-diagnostics/STEEL.md)

- [how to implement lsp extension using steel?](https://github.com/mattwparas/steel/discussions/416)

#### [steel builtins](https://github.com/jdrst/helix/blob/steel-and-pull-diagnostics/steel-docs.md)


## roslyn

#### [roslyn commands](https://github.com/dotnet/vscode-csharp/blob/main/src/lsptoolshost/server/roslynProtocol.ts)

- according to someone from the roslyn team that is all

### lsp extension TODOs

#### likely wanted/needed

- [x] send `project/open`
- [x] send `solution/open`
- [x] send `workspace/_roslyn_restore`
- [x] handle `workspace/_roslyn_projectNeedsRestore`
  - [ ] maybe via prompt (configurable)?
- [x] handle `workspace/projectInitializationComplete`
- [x] send `textDocument/_vs_getProjectContexts`
  - [ ] handle anonymous workspace stuff then
- [ ] send `textDocument/runTests`
- [ ] send `codeAction/resolveFixAll`
- [ ] send `codeAction/resolveFixAll`
- [ ] send `workspace/_roslyn_restorableProjects`
- [ ] send `sourceGeneratedDocument/_roslyn_getText`
- [ ] handle `workspace/refreshSourceGeneratedDocument`
- [ ] handle `window/_roslyn_showToast`

#### unsure 
- [ ] send `workspace/buildOnlyDiagnosticIds`
- [ ] send `workspace/_vs_registerSolutionSnapshot`
- [ ] send `textDocument/_vs_onAutoInsert`
- [ ] send `workspace/debugConfiguration`
- [ ] [? `roslyn.client.completionComplexEdit`](https://github.com/dotnet/roslyn/blob/main/src/LanguageServer/Protocol/Handler/Completion/CompletionResultFactory.cs)

## what is steel/helix missing:

- [x] a way to determine if an open buffer [is relevant for our lsp](https://github.com/mattwparas/helix/pull/53)
- [ ] a way to extend [lsp-capabilities](https://github.com/mattwparas/helix/issues/58)
- [ ] a way to handle unknown file uris (e.g. `roslyn-source-generated://...` for source generated documents)
- [ ] a way to hook into `codeAction/resolve` (roslyn sends [`roslyn.client.fixAllCodeAction` or `roslyn.client.nestedCodeAction`](https://github.com/dotnet/roslyn/blob/main/src/LanguageServer/Protocol/Handler/CodeActions/CodeActionsHandler.cs) and expects [`codeAction/resolveFixAll`](https://github.com/dotnet/vscode-csharp/blob/eda86add4c0b031cd8f9af52190849632a7ca427/src/lsptoolshost/server/roslynProtocol.ts#L339) with the `scope` as response)
