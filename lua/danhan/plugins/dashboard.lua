return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	enabled = true,

	keys = {
		{ "<leader>aa", "<cmd>Dashboard<cr>", desc = "Dashboard display" },
	},

	opts = function()
    -- stylua: ignore
		local logo = {
'',
'',
'',
'           I GOT SOMETHING TO WORK!',
'                 FANTASTIC !',
'              __      _______ ______',
'         ╱    /\\__/\\       //      ╲╲',
'        ______⊂╱    ( ´∇`  )     // ⊃     ||╲ フ 🡖',
'      ,´__▔▔▔▔╱  ▔╱▔  ⌒▔▔▔▔╱▔▔▔▔ 🡖▔ ▔▔▔▔▔🡖 ▔▔▔▔ |',
'    ,╱_ _╱   /-o—/ ___ ╱▔▔╱ ___/\\  |     ▔ | /\\__|',
'   ,========————´=============/⌒ ╲=/=======||🡖 ||',
'   | __  |  TYBG  |   __ "    |⌒| |/    ___/|  )╯',
'   )|🞕|_∈≡≡≡≡≡≡≡≡≡∋__|🞕|"  __|| ╯ ╯__ -‒‒‒‒‒┘  ╯',
'    ▔╲ ▔╲__╯▔▔▔▔▔▔▔▔三三三▔╲  ╲__╯ ▔▔     三三三三╯',
'     三三三三三三三三三三三三三三三三三三三三三三三三三三三三',
'       三三三三三三三三三三三三三三三三三三三三三三三三三三三三',
'',
'         My somewhat scuffed neovim config',
'',
		}
		local icons = require("danhan.core.icons")

		local opts = {
			theme = "doom",
			hide = {
				statusline = false,
			},

			config = {
				header = logo,
        -- stylua: ignore
        center = {
          { key = "n", icon = icons.ui.NewFile, desc = " New File", action = "ene | startinsert" },
          { key = "r", icon = icons.ui.Files, desc = " Recent Files", action = [[lua LazyVim.pick("oldfiles")()]]},
          { key = "f", icon = icons.ui.FindFile, desc = " Find File ", action = [[lua LazyVim.pick()]]},
          { key = "e", icon = icons.ui.Files, desc = " File Explorer", action = "Neotree"},
          { key = "t", icon = icons.ui.Text, desc = " Find Text", action = [[lua LazyVim.pick("live_grep")()]]},
          { key = "h", icon = icons.ui.Check, desc = " Check Health", action = "checkhealth"},
          { key = "m", icon = icons.ui.Mason, desc = " Mason", action = "Mason" },
          { key = "l", icon = icons.ui.Event, desc =  " Lazy", action = "Lazy" },
          { key = "c", icon = icons.ui.Gear, desc = " Config", action = [[lua LazyVim.pick.config_files()()]] },
          { key = "q", icon = icons.ui.Quit, desc = " Quit", action = "qa"},
        },

				footer = function()
					local ui = require("danhan.core.icons").ui
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return {
						ui.Lazy .. "Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. " ms",
					}
				end,
			},
		}

		for _, button in ipairs(opts.config.center) do
			button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			button.key_format = " %s"
		end

		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "DashboardLoaded",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		return opts
	end,
}
