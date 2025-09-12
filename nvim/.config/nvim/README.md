# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# roslyn

- Install [roslyn nuget](https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer.linux-x64/overview) as per [instructions](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#roslyn_ls).
- Unzip and make executable:
```
mkdir -p ~/.local/share/roslyn-ls
unzip Downloads/Microsoft.CodeAnalysis.LanguageServer.<version>.nupkg -d ~/.local/share/roslyn-ls
chmod +x ~/.local/share/roslyn-ls/content/LanguageServer/linux-x64/Microsoft.CodeAnalysis.LanguageServer
```
- Bump the number of file watchers (not sure if this is permanent):
```
sudo sysctl fs.inotify.max_user_instances=1024
```
