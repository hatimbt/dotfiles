require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'nord',
		section_separators = '',
		component_separators = '',
	},
	sections = {
		lualine_c = {
			{
				'filename',
				path = 1,
			}
		}
	}
}
