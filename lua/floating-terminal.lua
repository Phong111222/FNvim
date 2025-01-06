local state = {
	floating = {
		buf = -1,
		win = -1,
		name = nil, -- Store the buffer name
	},
}

local renameBuffer = function()
	-- Rename the terminal buffer (prompt user for the new name)
	local new_name = vim.fn.input("Enter new terminal name: ", "terminal_" .. os.date("%Y%m%d%H%M%S"), "file")
	if new_name ~= "" then
		-- Rename the buffer to the new name
		vim.cmd("file " .. "terminal:" .. new_name)
	end
end

-- Function to create a floating window
local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	-- Calculate the position to center the window
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal", -- No borders or extra UI elements
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

-- Toggle the floating terminal
local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		-- Prompt for a name if the buffer doesn't exist
		if not vim.api.nvim_buf_is_valid(state.floating.buf) then
			state.floating.name = input_name
			state.floating.buf = vim.api.nvim_create_buf(false, true)
		end

		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
			renameBuffer()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

-- Create user commands
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

-- Key mappings
vim.keymap.set(
	{ "n", "t" }, -- Modes: normal and terminal
	"<space>tt", -- Key mapping
	toggle_terminal,
	{ desc = "Toggle Terminal" }
)
