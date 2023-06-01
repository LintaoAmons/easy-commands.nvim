local default_config = {
  ["RunCurrentLineAndOutputWithPrePostFix"] = {
    prefix = "```bash",
    postfix = "```"
  },
  ["RunSelectedAndOutputWithPrePostFix"] = {
    prefix = "```bash",
    postfix = "```"
  },
  ["AskChatGPT"] = {
    keyFilePath = vim.env.HOME .. "/chatGPTkey"
  }
}

local Config = {}
Config.config = default_config

Config.setup = function(user_config)
  Config.config = vim.tbl_deep_extend("force", default_config, user_config)
end

Config.getConfig = function()
  return Config.config
end

return Config
