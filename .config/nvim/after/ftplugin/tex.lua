-- Disable line wrapping
vim.opt_local.wrap = false

-- Disable automatic hard line breaks
vim.opt_local.textwidth = 0

-- Remove 't' from formatoptions to prevent auto-wrapping of text
vim.opt_local.formatoptions:remove('t')
