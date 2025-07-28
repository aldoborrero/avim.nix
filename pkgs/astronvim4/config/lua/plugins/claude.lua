---@type LazySpec
return {
	"greggh/claude-code.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for git operations
	},
	keys = {
		{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
		{ "<leader>cC", "<cmd>ClaudeCodeContinue<cr>", desc = "Claude Code Continue" },
		{ "<leader>cV", "<cmd>ClaudeCodeVerbose<cr>", desc = "Claude Code Verbose" },
	},
	cmd = {
		"ClaudeCode",
		"ClaudeCodeContinue",
		"ClaudeCodeResume",
		"ClaudeCodeVerbose",
	},
	config = function()
		require("claude-code").setup({
			keymaps = {
				toggle = {
					normal = "<C-,>",
					terminal = "<C-,>",
					variants = {
						continue = "<leader>cC",
						verbose = "<leader>cV",
					},
				},
			},
		})
	end,
}
