# Neovim Configuration

This configuration uses the integrate lua JIT in neovim.

Uses [packer.nvim](https://github.com/wbthomason/packer.nvim) as the package manager.

## Packages
- [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)
- [casonadams/walh](https://github.com/casonadams/walh)
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

## TODO
- Autocompletion for `rust` [sharksforarms/neovim-rust](https://github.com/sharksforarms/neovim-rust)
- Fuzzy finder integration with [lotabout/skim](https://github.com/lotabout/skim)

Some sources for future reference:
- [Rust and Neovim - A Thorough Guide and Walkthrough](https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/)

## Windows Setup
To use Emacs on windows, `cd` into the home directory, and create a soft symbolic link with `~\AppData\Local\nvim` as the `<linked-location>` and `~\dotfiles\nvim\.config\nvim` as the target <directory-location>. The base directories for `nvim` are provided [here](https://neovim.io/doc/user/starting.html#base-directories).