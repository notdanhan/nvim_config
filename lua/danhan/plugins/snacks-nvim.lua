return {
	"snacks.nvim",
	opts = {
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = false }, -- we set this in options.lua
		toggle = { map = LazyVim.safe_keymap_set },
		words = { enabled = true },
		dashboard = {
			width = 80,
			row = nil,
			col = nil,
			pane_gap = 4,
			autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
			preset = {
				-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
				---@type fun(cmd:string, opts:table)|nil
				pick = nil,
				-- Used by the `keys` section to show keymaps.
				-- Set your custom keymaps here.
				-- When using a function, the `items` argument are the default keymaps.
				---@type snacks.dashboard.Item[]
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				header = [[



           I GOT SOMETHING TO WORK!
                 FANTASTIC !
              __      _______ ______
          ╱    /\\__/\\       //      ╲╲
        ______⊂╱    ( ´∇`  )     // ⊃     ||╲ フ 🡖
      ,´__▔▔▔▔╱  ▔╱▔  ⌒▔▔▔▔╱▔▔▔▔ 🡖▔ ▔▔▔▔▔🡖 ▔▔▔▔ |
    ,╱_ _╱   /-o—/ ___ ╱▔▔╱ ___/\\  |     ▔ | /\\__|
   ,========————´=============/⌒ ╲=/=======||🡖 ||
   | __  |  TYBG  |   __ "    |⌒| |/    ___/|  )╯
   )|🞕|_∈≡≡≡≡≡≡≡≡≡∋__|🞕|"  __|| ╯ ╯__ -‒‒‒‒‒┘  ╯
    ▔╲ ▔╲__╯▔▔▔▔▔▔▔▔三三三▔╲  ╲__╯ ▔▔     三三三三╯
     三三三三三三三三三三三三三三三三三三三三三三三三三三三三
       三三三三三三三三三三三三三三三三三三三三三三三三三三三三

         Get in the EVA or Mr. Squidward will have to do it again]],
			},
			-- item field formatters
			formats = {
				icon = function(item)
					--if item.file and item.icon == "file" or item.icon == "directory" then
					--	return M.icon(item.file, item.icon)
					--end
					if item.file and item.icon == "file" then
						return { "", width = 2, hl = "icon" }
					end
					if item.file and item.icon == "directory" then
						return { "", width = 2, hl = "icon" }
					end
					return { item.icon, width = 2, hl = "icon" }
				end,
				footer = { "%s", align = "center" },
				header = { "%s", align = "center" },
				file = function(item, ctx)
					local fname = vim.fn.fnamemodify(item.file, ":~")
					fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
					if #fname > ctx.width then
						local dir = vim.fn.fnamemodify(fname, ":h")
						local file = vim.fn.fnamemodify(fname, ":t")
						if dir and file then
							file = file:sub(-(ctx.width - #dir - 2))
							fname = dir .. "/…" .. file
						end
					end
					local dir, file = fname:match("^(.*)/(.+)$")
					return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
				end,
			},
			sections = {
				{ section = "header", align = "center" },
				{ section = "keys", gap = 1, padding = 1 },
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {
						{
							icon = " ",
							title = "Git Status",
							cmd = "git --no-pager diff --stat -B -M -C",
							height = 12,
						},
					}
					return vim.tbl_map(function(cmd)
						return vim.tbl_extend("force", {
							pane = 2,
							section = "terminal",
							enabled = in_git,
							padding = 1,
							ttl = 5 * 60,
							indent = 3,
						}, cmd)
					end, cmds)
				end,
				{ section = "startup" },
			},
		},
	},
	-- stylua: ignore
	keys = {
		{ "<leader>n", function()
			if Snacks.config.picker and Snacks.config.picker.enabled then
				Snacks.picker.notifications()
			else
				Snacks.notifier.show_history()
			end
		end, desc = "Notification History" },
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
	},
}
