# Notes for development

## [steel](https://github.com/mattwparas/steel)

## [Book](https://mattwparas.github.io/steel/book/)

## [steel in hx](https://github.com/jdrst/helix/blob/steel-and-pull-diagnostics/STEEL.md)

- [how to implement lsp extension using steel?](https://github.com/mattwparas/steel/discussions/416)

#### [steel builtins](https://github.com/jdrst/helix/blob/steel-and-pull-diagnostics/steel-docs.md)


## roslyn

#### [roslyn commands](https://github.com/dotnet/vscode-csharp/blob/main/src/lsptoolshost/server/roslynProtocol.ts)

- according to someone from the roslyn team that is all

## what is steel/helix missing:

- a way to extend [lsp-capabilities](https://github.com/mattwparas/helix/issues/58)
- a way to handle unknown file uris (e.g. `roslyn-source-generated://...` for source generated documents)
- a way to hook into [codeAction/resolve] (roslyn sends `roslyn.client.fixAllCodeAction` and expects [`codeAction/resolveFixAll`](https://github.com/dotnet/vscode-csharp/blob/eda86add4c0b031cd8f9af52190849632a7ca427/src/lsptoolshost/server/roslynProtocol.ts#L339) with the `scope` as response)
