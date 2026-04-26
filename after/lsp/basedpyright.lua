local function find_venv_python(root_dir)
	if not root_dir then
		return nil
	end

	local candidates = {
		root_dir .. "/.venv/bin/python",
		root_dir .. "/venv/bin/python",
	}

	local env_venv = vim.env.VIRTUAL_ENV
	if env_venv then
		table.insert(candidates, 1, env_venv .. "/bin/python")
	end

	for _, path in ipairs(candidates) do
		if vim.fn.executable(path) == 1 then
			return path
		end
	end
	return nil
end

return {
	before_init = function(_, config)
		local python_path = find_venv_python(config.root_dir)
		if not python_path then
			return
		end
		config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
			python = { pythonPath = python_path },
			basedpyright = {
				analysis = {
					diagnosticMode = "openFilesOnly",
				},
			},
		})
	end,
}
