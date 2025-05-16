return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      djlsp = {
        cmd = { "djlsp" },
        root_dir = require("lspconfig.util").root_pattern("manage.py", ".git"),
        init_options = {
          django_settings_module = "", -- Leave empty for auto-detection
          docker_compose_file = "docker-compose.yml",
          docker_compose_service = "django",
        },
      },
    },
  },
}
