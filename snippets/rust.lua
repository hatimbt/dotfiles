local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Rust Snippets", { clear = true })
local file_pattern = "*.rs"

local function cs(trigger, nodes, opts) --{{{
	local snippet = s(trigger, nodes)
	local target_table = snippets

	local pattern = file_pattern
	local keymaps = {}

	if opts ~= nil then
		-- check for custom pattern
		if opts.pattern then
			pattern = opts.pattern
		end

		-- if opts is a string
		if type(opts) == "string" then
			if opts == "auto" then
				target_table = autosnippets
			else
				table.insert(keymaps, { "i", opts })
			end
		end

		-- if opts is a table
		if opts ~= nil and type(opts) == "table" then
			for _, keymap in ipairs(opts) do
				if type(keymap) == "string" then
					table.insert(keymaps, { "i", keymap })
				else
					table.insert(keymaps, keymap)
				end
			end
		end

		-- set autocmd for each keymap
		if opts ~= "auto" then
			for _, keymap in ipairs(keymaps) do
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = pattern,
					group = group,
					callback = function()
						vim.keymap.set(keymap[1], keymap[2], function()
							ls.snip_expand(snippet)
						end, { noremap = true, silent = true, buffer = true })
					end,
				})
			end
		end
	end

	table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Snippets --

-- Create a region of code
cs("region",
fmt([[
// region:    --- {}

{}

// endregion: --- Modules
]], {
	i(1, "Modules"),
	i(2, ""),
}))

cs("rs-main-01",
fmt([[
// region:    --- Modules

mod error;

pub use error::{{Error, Result}}
{}
// endregion: --- Modules

fn main() -> Result<()> {{
	{}println!(Hello, world!);

	Ok(())
}}

]], {
	i(1, ""),
	i(2, ""),
}))

cs("rs-main-02-async",
fmt([[
// region:    --- Modules

mod error;

pub use error::{{Error, Result}};
{}
// endregion: --- Modules

#[tokio::main]
async fn main() -> Result<()> {{
	{}println!("Hello, world!");

	Ok(())
}}

]], {
	i(1, ""),
	i(2, ""),
}))

cs("rs-main-03-early-dev",
fmt([[
pub type Result<T> = core::result::Result<T, Error>;
pub type Error = Box<dyn std::error::Error>; // For early dev.
{}
fn main() -> Result<()> {{
	{}println!("Hello, world!");

	Ok(())
}}

]], {
	i(1, ""),
	i(2, ""),
}))

cs("rs-main-04-early-dev-async",
fmt([[
pub type Result<T> = core::result::Result<T, Error>;
pub type Error = Box<dyn std::error::Error>; // For early dev.
{}
#[tokio::main]
async fn main() -> Result<()> {{
	{}println!("Hello, world!");

	Ok(())
}}

]], {
	i(1, ""),
	i(2, ""),
}))

cs("rs-lib-01",
fmt([[
// region:    --- Modules

mod error{};

pub use error::{{Error, Result}};

// endregion: --- Modules

]], {
	i(1, ""),
}))

cs("rs-lib-02-early-dev",
fmt([[
// region:    --- Modules

pub type Result<T> = core::result::Result<T, Error>;
pub type Error = Box<dyn std::error::Error>; // For early dev.
{}
// endregion: --- Modules

]], {
	i(1, ""),
}))

cs("rs-example-01",
fmt([[
fn main() -> Result<(), Box<dyn std::error::Error>> {{
	{}println!("Hello, world!");

	Ok(())
}}

]], {
	i(1, ""),
}))

cs("rs-example-02-async",
fmt([[
#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {{
	{}println!("Hello, world!");

	Ok(())
}}

]], {
	i(1, ""),
}))



-- Snippets --

return snippets, autosnippets
