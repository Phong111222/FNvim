-- Python LSP configuration
-- Function to find Python interpreter
local function get_python_path(workspace)
  -- First check if pyrightconfig.json exists and use it
  local pyright_config = workspace .. "/pyrightconfig.json"
  if vim.fn.filereadable(pyright_config) == 1 then
    local ok, config = pcall(vim.fn.json_decode, vim.fn.readfile(pyright_config))
    if ok and config.pythonPath then
      local python_path = config.pythonPath
      if not vim.startswith(python_path, "/") then
        python_path = workspace .. "/" .. python_path
      end
      if vim.fn.filereadable(python_path) == 1 then
        return python_path
      end
    end
  end

  -- Check for common virtual environment patterns
  local venv_paths = {
    workspace .. "/lc-academy-env/bin/python",
    workspace .. "/.venv/bin/python",
    workspace .. "/venv/bin/python",
    workspace .. "/env/bin/python",
  }

  for _, path in ipairs(venv_paths) do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end

  -- Check for Poetry
  if vim.fn.executable("poetry") == 1 then
    local handle = io.popen("cd " .. vim.fn.shellescape(workspace) .. " && poetry env info -p 2>/dev/null")
    if handle then
      local poetry_env = handle:read("*a"):gsub("%s+$", "")
      handle:close()
      if poetry_env and poetry_env ~= "" then
        local poetry_python = poetry_env .. "/bin/python"
        if vim.fn.filereadable(poetry_python) == 1 then
          return poetry_python
        end
      end
    end
  end

  -- Check for Pipenv
  if vim.fn.executable("pipenv") == 1 then
    local handle = io.popen("cd " .. vim.fn.shellescape(workspace) .. " && pipenv --py 2>/dev/null")
    if handle then
      local pipenv_python = handle:read("*a"):gsub("%s+$", "")
      handle:close()
      if pipenv_python and pipenv_python ~= "" and vim.fn.filereadable(pipenv_python) == 1 then
        return pipenv_python
      end
    end
  end

  -- Check for Conda
  if os.getenv("CONDA_PREFIX") then
    local conda_python = os.getenv("CONDA_PREFIX") .. "/bin/python"
    if vim.fn.filereadable(conda_python) == 1 then
      return conda_python
    end
  end

  -- Fall back to system Python
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return {
  root_dir = function(fname)
    local util = require('lspconfig.util')
    return util.root_pattern("pyrightconfig.json", "pyproject.toml", "setup.py", ".git")(fname)
  end,
  on_new_config = function(new_config, new_root_dir)
    local python_path = get_python_path(new_root_dir)
    new_config.settings = new_config.settings or {}
    new_config.settings.python = new_config.settings.python or {}
    new_config.settings.python.pythonPath = python_path
  end,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        autoImportCompletions = true,
      },
    },
  },
}
