-- Terraform LSP configuration
return {
  filetypes = { "terraform", "tf", "hcl" },
  settings = {
    terraform = {
      timeout = "30s",
    },
  },
}
