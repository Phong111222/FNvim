local M = {}

local SEPARATOR = " -- "

-- Persist last prompt across picker invocations so toggling off/on
-- restores the previous search text and globs.
local last_prompt = ""

local function build_rg_args(prompt)
	if not prompt or prompt == "" then
		return nil
	end

	local search, glob_str = prompt, nil
	local sep = prompt:find(" %-%- ")
	if sep then
		search = prompt:sub(1, sep - 1)
		glob_str = prompt:sub(sep + #SEPARATOR)
	end

	if search == "" then
		return nil
	end

	local args = {
		"rg",
		"--color=never",
		"--no-heading",
		"--with-filename",
		"--line-number",
		"--column",
		"--smart-case",
		"--no-ignore",
		"--hidden",
		"--glob",
		"!.git/",
	}

	if glob_str and glob_str ~= "" then
		for pat in glob_str:gmatch("[^,]+") do
			local trimmed = pat:match("^%s*(.-)%s*$")
			if trimmed ~= "" then
				table.insert(args, "--glob")
				table.insert(args, trimmed)
			end
		end
	end

	table.insert(args, "--")
	table.insert(args, search)
	return args
end

function M.live_grep_globs(opts)
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local make_entry = require("telescope.make_entry")
	local action_state = require("telescope.actions.state")
	local conf = require("telescope.config").values
	local sorters = require("telescope.sorters")

	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	pickers
		.new(opts, {
			prompt_title = "Live Grep (text -- glob1,!exclude1,glob2)",
			default_text = last_prompt,
			finder = finders.new_job(
				build_rg_args,
				opts.entry_maker or make_entry.gen_from_vimgrep(opts),
				opts.max_results,
				opts.cwd
			),
			previewer = conf.grep_previewer(opts),
			sorter = sorters.empty(),
			attach_mappings = function(prompt_bufnr, _)
				vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
					buffer = prompt_bufnr,
					callback = function()
						local picker = action_state.get_current_picker(prompt_bufnr)
						if picker then
							last_prompt = picker:_get_prompt() or last_prompt
						end
					end,
				})
				return true
			end,
		})
		:find()
end

function M.reset_live_grep_globs()
	last_prompt = ""
end

return M
