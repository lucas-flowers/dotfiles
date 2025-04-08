-- Incantation (translated from the original init.vim) to use plain vim's configuration
vim.cmd.set('runtimepath^=~/.vim runtimepath+=~/.vim/after')
vim.o.packpath = vim.o.runtimepath
vim.cmd.source("~/.vim/vimrc")

-- Further Lua configuration is below. I assume it's desirable to run Lua
-- (i.e., neovim-specific config) after plain vim config is set up, but I could
-- be wrong.
require("config")

