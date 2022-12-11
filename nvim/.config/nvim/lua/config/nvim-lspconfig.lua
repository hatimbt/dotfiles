-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
--vim.opt.shortmess = vim.opt.shortmess + "c"

local function on_attach(client, buffer)
	-- This callback is called when the LSP is atttached/enabled for this buffer
	-- we could set keymaps related to LSP, etc here.
end

require('lspconfig')['rust_analyzer'].setup{
	on_attach = on_attach,
	-- Server-specific settings...
	settings = {
      		["rust-analyzer"] = {
			-- enable clippy on save
			checkOnSave = {
				command = "clippy",
			},
		}
	}
}
