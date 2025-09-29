{ pkgs, ... }:
{
  colorschemes.catppuccin = {
    enable = true;
  };

  globals = {
    mapleader = " ";
    maplocalleader = ",";
  };

  opts = {
    # Line numbers
    number = true;
    relativenumber = true;

    # Indentation
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;
    smartindent = true;

    # Search
    ignorecase = true;
    smartcase = true;
    hlsearch = true;
    incsearch = true;

    # UI
    termguicolors = true;
    signcolumn = "yes";
    wrap = false;
    scrolloff = 8;
    sidescrolloff = 8;
    cursorline = true;

    # Behavior
    mouse = "a";
    clipboard = "unnamedplus";
    swapfile = false;
    backup = false;
    undofile = true;

    # Performance
    updatetime = 50;
    timeoutlen = 300;

    # Splits
    splitbelow = true;
    splitright = true;
  };

  keymaps = [
    # Navigation
    {
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Navigate left";
    }
    {
      key = "<C-j>";
      action = "<C-w>j";
      options.desc = "Navigate down";
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
      options.desc = "Navigate up";
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Navigate right";
    }

    # Buffer navigation
    {
      key = "]b";
      action = "<cmd>bnext<CR>";
      options.desc = "Next buffer";
    }
    {
      key = "[b";
      action = "<cmd>bprevious<CR>";
      options.desc = "Previous buffer";
    }

    # Save
    {
      key = "<C-s>";
      action = "<cmd>w<CR>";
      options.desc = "Save file";
    }

    # Clear search highlights
    {
      key = "<Esc>";
      action = "<cmd>noh<CR>";
      options.desc = "Clear search highlights";
    }

    # Window splits
    {
      key = "|";
      action = "<cmd>vsplit<CR>";
      options.desc = "Vertical split";
    }
    {
      key = "\\";
      action = "<cmd>split<CR>";
      options.desc = "Horizontal split";
    }

    # File tree
    {
      key = "<leader>e";
      action = "<cmd>Neotree toggle<CR>";
      options.desc = "Toggle file explorer";
    }
    {
      key = "<leader>o";
      action.__raw = ''
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
          else
            vim.cmd.Neotree "focus"
          end
        end
      '';
      options.desc = "Toggle Explorer Focus";
    }

    # Dashboard
    {
      key = "<leader>H";
      action.__raw = ''
        function()
          if vim.bo.filetype == "snacks_dashboard" then
            vim.cmd("close")
          else
            require("snacks").dashboard()
          end
        end
      '';
      options.desc = "Home Screen";
    }

    # Snacks picker keymaps
    {
      key = "<leader><leader>";
      action.__raw = "function() require('snacks').picker.files() end";
      options.desc = "Find files";
    }
    {
      key = "<leader>ff";
      action.__raw = ''
        function()
          require("snacks").picker.files {
            hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat ".git" or {}, "type") == "directory",
          }
        end
      '';
      options.desc = "Find files";
    }
    {
      key = "<leader>fF";
      action.__raw = "function() require('snacks').picker.files { hidden = true, ignored = true } end";
      options.desc = "Find all files";
    }
    {
      key = "<leader>fg";
      action.__raw = "function() require('snacks').picker.git_files() end";
      options.desc = "Find git files";
    }
    {
      key = "<leader>fw";
      action.__raw = "function() require('snacks').picker.grep() end";
      options.desc = "Find words";
    }
    {
      key = "<leader>fW";
      action.__raw = "function() require('snacks').picker.grep { hidden = true, ignored = true } end";
      options.desc = "Find words in all files";
    }
    {
      key = "<leader>fa";
      action.__raw = ''function() require("snacks").picker.files { dirs = { vim.fn.stdpath "config" }, desc = "Config Files" } end'';
      options.desc = "Find config files";
    }
    {
      key = "<leader>fb";
      action.__raw = "function() require('snacks').picker.buffers() end";
      options.desc = "Find buffers";
    }
    {
      key = "<leader>fh";
      action.__raw = "function() require('snacks').picker.help() end";
      options.desc = "Find help";
    }
    {
      key = "<leader>fo";
      action.__raw = "function() require('snacks').picker.recent() end";
      options.desc = "Find old files";
    }
    {
      key = "<leader>fO";
      action.__raw = "function() require('snacks').picker.recent { filter = { cwd = true } } end";
      options.desc = "Find old files (cwd)";
    }
    {
      key = "<leader>fc";
      action.__raw = "function() require('snacks').picker.grep_word() end";
      options.desc = "Find word under cursor";
    }
    {
      key = "<leader>fC";
      action.__raw = "function() require('snacks').picker.commands() end";
      options.desc = "Find commands";
    }
    {
      key = "<leader>fk";
      action.__raw = "function() require('snacks').picker.keymaps() end";
      options.desc = "Find keymaps";
    }
    {
      key = "<leader>fm";
      action.__raw = "function() require('snacks').picker.man() end";
      options.desc = "Find man";
    }
    {
      key = "<leader>f'";
      action.__raw = "function() require('snacks').picker.marks() end";
      options.desc = "Find marks";
    }
    {
      key = "<leader>fr";
      action.__raw = "function() require('snacks').picker.registers() end";
      options.desc = "Find registers";
    }
    {
      key = "<leader>ft";
      action.__raw = "function() require('snacks').picker.colorschemes() end";
      options.desc = "Find themes";
    }
    {
      key = "<leader>fs";
      action.__raw = "function() require('snacks').picker.smart() end";
      options.desc = "Find buffers/recent/files";
    }
    {
      key = "<leader>fp";
      action.__raw = "function() require('snacks').picker.projects() end";
      options.desc = "Find projects";
    }
    {
      key = "<leader>fn";
      action.__raw = "function() require('snacks').picker.notifications() end";
      options.desc = "Find notifications";
    }
    {
      key = "<leader>f<CR>";
      action.__raw = "function() require('snacks').picker.resume() end";
      options.desc = "Resume previous search";
    }
    {
      key = "<leader>fl";
      action.__raw = "function() require('snacks').picker.lines() end";
      options.desc = "Find lines";
    }
    {
      key = "<leader>fu";
      action.__raw = "function() require('snacks').picker.undo() end";
      options.desc = "Find undo history";
    }

    # Git keymaps (if git is available)
    {
      key = "<leader>gb";
      action.__raw = "function() require('snacks').picker.git_branches() end";
      options.desc = "Git branches";
    }
    {
      key = "<leader>gc";
      action.__raw = "function() require('snacks').picker.git_log() end";
      options.desc = "Git commits (repository)";
    }
    {
      key = "<leader>gC";
      action.__raw = "function() require('snacks').picker.git_log { current_file = true, follow = true } end";
      options.desc = "Git commits (current file)";
    }
    {
      key = "<leader>gt";
      action.__raw = "function() require('snacks').picker.git_status() end";
      options.desc = "Git status";
    }
    {
      key = "<leader>gT";
      action.__raw = "function() require('snacks').picker.git_stash() end";
      options.desc = "Git stash";
    }
    {
      key = "<leader>go";
      action.__raw = "function() require('snacks').gitbrowse() end";
      options.desc = "Git browse (open)";
    }
    {
      mode = "x";
      key = "<leader>go";
      action.__raw = "function() require('snacks').gitbrowse() end";
      options.desc = "Git browse (open)";
    }

    # Diffview keymaps
    {
      key = "<leader>gd";
      action = "<cmd>DiffviewOpen<CR>";
      options.desc = "Open Diffview";
    }
    {
      key = "<leader>gh";
      action = "<cmd>DiffviewFileHistory<CR>";
      options.desc = "File history";
    }
    {
      key = "<leader>gH";
      action = "<cmd>DiffviewFileHistory %<CR>";
      options.desc = "Current file history";
    }
    {
      key = "<leader>gq";
      action = "<cmd>DiffviewClose<CR>";
      options.desc = "Close Diffview";
    }

    # Search and Replace (Spectre)
    {
      key = "<leader>sr";
      action = "<cmd>lua require('spectre').open()<CR>";
      options.desc = "Search and replace";
    }
    {
      key = "<leader>sw";
      action = "<cmd>lua require('spectre').open_visual({select_word=true})<CR>";
      options.desc = "Search current word";
    }
    {
      mode = "v";
      key = "<leader>sw";
      action = "<esc><cmd>lua require('spectre').open_visual()<CR>";
      options.desc = "Search selected text";
    }
    {
      key = "<leader>sp";
      action = "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>";
      options.desc = "Search in current file";
    }

    # Snacks utilities
    {
      key = "<leader>u|";
      action.__raw = "function() require('snacks').toggle.indent():toggle() end";
      options.desc = "Toggle indent guides";
    }
    {
      key = "<leader>uD";
      action.__raw = "function() require('snacks.notifier').hide() end";
      options.desc = "Dismiss notifications";
    }
    {
      key = "<leader>uZ";
      action.__raw = "function() require('snacks').toggle.zen():toggle() end";
      options.desc = "Toggle zen mode";
    }

    # Flash navigation
    {
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      action.__raw = "function() require('flash').jump() end";
      options.desc = "Flash jump";
    }
    {
      key = "S";
      mode = [
        "n"
        "x"
        "o"
      ];
      action.__raw = "function() require('flash').treesitter() end";
      options.desc = "Flash treesitter";
    }
    {
      key = "r";
      mode = "o";
      action.__raw = "function() require('flash').remote() end";
      options.desc = "Remote Flash";
    }
    {
      key = "R";
      mode = [
        "o"
        "x"
      ];
      action.__raw = "function() require('flash').treesitter_search() end";
      options.desc = "Flash treesitter search";
    }

    # Undotree
    {
      key = "<leader>uu";
      action = "<cmd>UndotreeToggle<CR>";
      options.desc = "Toggle undotree";
    }

    # Todo comments
    {
      key = "]t";
      action.__raw = "function() require('todo-comments').jump_next() end";
      options.desc = "Next todo comment";
    }
    {
      key = "[t";
      action.__raw = "function() require('todo-comments').jump_prev() end";
      options.desc = "Previous todo comment";
    }
    {
      key = "<leader>st";
      action.__raw = "function() require('snacks').picker.todo_comments() end";
      options.desc = "Search todo comments";
    }

    # LSP with Snacks
    {
      key = "<leader>lD";
      action.__raw = "function() require('snacks').picker.diagnostics() end";
      options.desc = "Search diagnostics";
    }
    {
      key = "<leader>ls";
      action.__raw = "function() require('snacks').picker.lsp_symbols() end";
      options.desc = "Search symbols";
    }

    # LSP
    {
      key = "gd";
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      options.desc = "Go to definition";
    }
    {
      key = "gD";
      action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
      options.desc = "Go to declaration";
    }
    {
      key = "gi";
      action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
      options.desc = "Go to implementation";
    }
    {
      key = "gr";
      action = "<cmd>Telescope lsp_references<CR>";
      options.desc = "Show references";
    }
    {
      key = "K";
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      options.desc = "Hover documentation";
    }
    {
      key = "<leader>la";
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      options.desc = "Code action";
    }
    {
      key = "<leader>lr";
      action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      options.desc = "Rename symbol";
    }
    {
      key = "<leader>lf";
      action.__raw = "function() require('conform').format({ async = true, lsp_fallback = true }) end";
      options.desc = "Format buffer";
    }
    {
      mode = "v";
      key = "<leader>lf";
      action.__raw = "function() require('conform').format({ async = true, lsp_fallback = true, range = { start = vim.api.nvim_buf_get_mark(0, '<'), ['end'] = vim.api.nvim_buf_get_mark(0, '>') } }) end";
      options.desc = "Format selection";
    }

    # Terminal and AI
    {
      key = "<F4>";
      action = "<cmd>ClaudeCode<CR>";
      options.desc = "Open Claude Code";
    }
    {
      key = "<F5>";
      action = "<cmd>ClaudeCodeContinue<CR>";
      options.desc = "Continue Claude Code conversation";
    }
    {
      key = "<F6>";
      action = "<cmd>lua require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit' }):toggle()<CR>";
      options.desc = "Open LazyGit";
    }
    {
      key = "<leader>gg";
      action = "<cmd>lua require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit' }):toggle()<CR>";
      options.desc = "Open LazyGit";
    }
    {
      key = "<F7>";
      action.__raw = ''
        function()
          local Terminal = require('toggleterm.terminal').Terminal
          if not _G.float_term then
            _G.float_term = Terminal:new({
              count = 1,
              direction = 'float',
              hidden = true,
              float_opts = {
                border = 'curved'
              }
            })
          end
          _G.float_term:toggle()
        end
      '';
      options.desc = "Toggle terminal";
    }

    # Terminal mode mappings
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Exit terminal mode";
    }
    {
      mode = "t";
      key = "<F7>";
      action = "<cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal from terminal mode";
    }

    # Harpoon keymaps
    {
      mode = "n";
      key = "<leader>ha";
      action.__raw = "function() require'harpoon':list():add() end";
      options.desc = "Harpoon add file";
    }
    {
      mode = "n";
      key = "<leader>hh";
      action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
      options.desc = "Harpoon quick menu";
    }
    {
      mode = "n";
      key = "<leader>h1";
      action.__raw = "function() require'harpoon':list():select(1) end";
      options.desc = "Harpoon file 1";
    }
    {
      mode = "n";
      key = "<leader>h2";
      action.__raw = "function() require'harpoon':list():select(2) end";
      options.desc = "Harpoon file 2";
    }
    {
      mode = "n";
      key = "<leader>h3";
      action.__raw = "function() require'harpoon':list():select(3) end";
      options.desc = "Harpoon file 3";
    }
    {
      mode = "n";
      key = "<leader>h4";
      action.__raw = "function() require'harpoon':list():select(4) end";
      options.desc = "Harpoon file 4";
    }
    {
      mode = "n";
      key = "<leader>h5";
      action.__raw = "function() require'harpoon':list():select(5) end";
      options.desc = "Harpoon file 5";
    }
    {
      mode = "n";
      key = "<leader>h6";
      action.__raw = "function() require'harpoon':list():select(6) end";
      options.desc = "Harpoon file 6";
    }
    {
      mode = "n";
      key = "<leader>h7";
      action.__raw = "function() require'harpoon':list():select(7) end";
      options.desc = "Harpoon file 7";
    }
    {
      mode = "n";
      key = "<leader>h8";
      action.__raw = "function() require'harpoon':list():select(8) end";
      options.desc = "Harpoon file 8";
    }
    {
      mode = "n";
      key = "<leader>h9";
      action.__raw = "function() require'harpoon':list():select(9) end";
      options.desc = "Harpoon file 9";
    }
    {
      mode = "n";
      key = "<leader>hn";
      action.__raw = "function() require'harpoon':list():next() end";
      options.desc = "Harpoon next";
    }
    {
      mode = "n";
      key = "<leader>hp";
      action.__raw = "function() require'harpoon':list():prev() end";
      options.desc = "Harpoon previous";
    }
    {
      mode = "n";
      key = "<leader>hd";
      action.__raw = "function() require'harpoon':list():remove() end";
      options.desc = "Remove current file from Harpoon";
    }
    {
      mode = "n";
      key = "<leader>hc";
      action.__raw = "function() require'harpoon':list():clear() end";
      options.desc = "Clear all Harpoon marks";
    }
  ];

  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
        ensure_installed = [
          "bash"
          "c"
          "cpp"
          "css"
          "dockerfile"
          "go"
          "hcl"
          "html"
          "javascript"
          "json"
          "lua"
          "markdown"
          "nix"
          "python"
          "rust"
          "terraform"
          "toml"
          "typescript"
          "vim"
          "vimdoc"
          "yaml"
        ];
      };
    };

    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        denols.enable = true;
        dockerls.enable = true;
        gopls.enable = true;
        helm_ls.enable = true;
        lua_ls.enable = true;
        marksman.enable = true;
        nil_ls.enable = true;
        pyright.enable = true;
        ruff.enable = true;
        taplo.enable = true;
        terraformls.enable = true;
        yamlls.enable = true;
        cssls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        tailwindcss.enable = true;
        starpls.enable = true;
      };
    };

    blink-cmp = {
      enable = true;
      settings = {
        keymap = {
          preset = "default";
          # Custom keymaps
          "<C-b>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-f>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<C-Space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<C-e>" = [
            "hide"
            "fallback"
          ];
          "<CR>" = [
            "accept"
            "fallback"
          ];
          "<Tab>" = [
            "select_next"
            "fallback"
          ];
          "<S-Tab>" = [
            "select_prev"
            "fallback"
          ];
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
          providers = {
            lsp = {
              name = "LSP";
              module = "blink.cmp.sources.lsp";
              fallbacks = [ "buffer" ];
            };
            path = {
              name = "Path";
              module = "blink.cmp.sources.path";
              score_offset = 3;
            };
            snippets = {
              name = "Snippets";
              module = "blink.cmp.sources.snippets";
              score_offset = -3;
            };
            buffer = {
              name = "Buffer";
              module = "blink.cmp.sources.buffer";
            };
          };
        };
        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
            };
          };
          menu = {
            draw = {
              columns = [
                {
                  __unkeyed-1 = "label";
                  gap = 1;
                }
                {
                  __unkeyed-1 = "kind_icon";
                  __unkeyed-2 = "kind";
                }
              ];
            };
          };
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };
        };
        fuzzy = {
          prebuilt_binaries = {
            download = true;
          };
        };
        snippets = {
          expand.__raw = "function(snippet) require('luasnip').lsp_expand(snippet) end";
          active.__raw = ''
            function(filter)
              if filter and filter.direction then
                return require("luasnip").jumpable(filter.direction)
              end
              return require("luasnip").in_snippet()
            end
          '';
          jump.__raw = "function(direction) require('luasnip').jump(direction) end";
        };
      };
    };

    luasnip = {
      enable = true;
      fromVscode = [
        {
          lazyLoad = true;
          paths = "${pkgs.vimPlugins.friendly-snippets}";
        }
      ];
    };

    lualine = {
      enable = true;
      settings = {
        options = {
          theme = "catppuccin";
          icons_enabled = true;
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
        };
      };
    };

    neo-tree = {
      enable = true;
      closeIfLastWindow = true;
      enableGitStatus = true;
      enableDiagnostics = true;
      sources = [
        "filesystem"
        "buffers"
        "git_status"
      ];
      sourceSelector = {
        winbar = true;
        contentLayout = "center";
      };
      window = {
        width = 30;
      };
      filesystem = {
        followCurrentFile = {
          enabled = true;
        };
        hijackNetrwBehavior = "open_current";
        useLibuvFileWatcher = true;
        filteredItems = {
          hideGitignored = true;
        };
      };
    };

    alpha.enable = false;

    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = {
            text = "│";
          };
          change = {
            text = "│";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          changedelete = {
            text = "~";
          };
        };
      };
    };

    fugitive.enable = true;

    diffview = {
      enable = true;
    };

    nvim-autopairs.enable = true;

    comment.enable = true;

    nvim-surround = {
      enable = true;
      settings = {
        keymaps = {
          insert = "<C-g>s";
          insert_line = "<C-g>S";
          normal = "ys";
          normal_cur = "yss";
          normal_line = "yS";
          normal_cur_line = "ySS";
          visual = "S";
          visual_line = "gS";
          delete = "ds";
          change = "cs";
          change_line = "cS";
        };
      };
    };

    indent-blankline.enable = true;

    toggleterm = {
      enable = true;
      settings = {
        size = 20;
        open_mapping = "[[<c-\\>]]";
        hide_numbers = true;
        shade_terminals = true;
        shading_factor = 2;
        start_in_insert = true;
        persist_size = true;
        direction = "float";
        float_opts = {
          border = "curved";
        };
      };
    };

    web-devicons.enable = true;

    snacks = {
      enable = true;
      settings = {
        bigfile = {
          enabled = true;
        };
        dashboard = {
          enabled = true;
          preset = {
            keys = [
              {
                key = "n";
                action = "<Leader>n";
                desc = "New File  ";
              }
              {
                key = "f";
                action = "<Leader>ff";
                desc = "Find File  ";
              }
              {
                key = "o";
                action = "<Leader>fo";
                desc = "Recents  ";
              }
              {
                key = "w";
                action = "<Leader>fw";
                desc = "Find Word  ";
              }
              {
                key = "'";
                action = "<Leader>f'";
                desc = "Bookmarks  ";
              }
              {
                key = "s";
                action = "<Leader>Sl";
                desc = "Last Session  ";
              }
            ];
            header = ''
               █████  ██    ██ ██ ███    ███
              ██   ██ ██    ██ ██ ████  ████
              ███████ ██    ██ ██ ██ ████ ██
              ██   ██  ██  ██  ██ ██  ██  ██
              ██   ██   ████   ██ ██      ██'';
          };
          sections = [
            {
              section = "header";
              padding = 5;
            }
            {
              section = "keys";
              gap = 1;
              padding = 3;
            }
          ];
        };
        notifier = {
          enabled = true;
        };
        quickfile = {
          enabled = true;
        };
        statuscolumn = {
          enabled = true;
        };
        words = {
          enabled = true;
        };
        indent = {
          enabled = true;
          indent = {
            char = "▏";
          };
          scope = {
            char = "▏";
          };
          animate = {
            enabled = false;
          };
        };
        scope = {
          enabled = true;
        };
        zen = {
          enabled = true;
          toggles = {
            dim = false;
            diagnostics = false;
            inlay_hints = false;
          };
          win = {
            width.__raw = "function() return math.min(120, math.floor(vim.o.columns * 0.75)) end";
            height = 0.9;
            backdrop = {
              transparent = false;
              win = {
                wo = {
                  winhighlight = "Normal:Normal";
                };
              };
            };
            wo = {
              number = false;
              relativenumber = false;
              signcolumn = "no";
              foldcolumn = "0";
              winbar = "";
              list = false;
              showbreak = "NONE";
            };
          };
        };
        picker = {
          enabled = true;
          ui_select = true;
        };
        gitbrowse = {
          enabled = true;
        };
      };
    };

    which-key = {
      enable = true;
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>f";
            group = "Find";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "Code";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "LSP";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "UI/Utils";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "Harpoon";
          }
        ];
      };
    };

    auto-save = {
      enable = true;
      settings = {
        enabled = true;
      };
    };

    rainbow-delimiters.enable = true;

    flash = {
      enable = true;
      settings = {
        jump.autojump = true;
        modes = {
          char = {
            jump_labels = true;
          };
        };
      };
    };

    undotree = {
      enable = true;
      settings = {
        SetFocusWhenToggle = true;
      };
    };

    todo-comments = {
      enable = true;
      settings = {
        signs = true;
        sign_priority = 8;
        keywords = {
          FIX = {
            icon = " ";
            color = "error";
            alt = [
              "FIXME"
              "BUG"
              "FIXIT"
              "ISSUE"
            ];
          };
          TODO = {
            icon = " ";
            color = "info";
          };
          HACK = {
            icon = " ";
            color = "warning";
          };
          WARN = {
            icon = " ";
            color = "warning";
            alt = [
              "WARNING"
              "XXX"
            ];
          };
          PERF = {
            icon = " ";
            alt = [
              "OPTIM"
              "PERFORMANCE"
              "OPTIMIZE"
            ];
          };
          NOTE = {
            icon = " ";
            color = "hint";
            alt = [ "INFO" ];
          };
          TEST = {
            icon = "⏲ ";
            color = "test";
            alt = [
              "TESTING"
              "PASSED"
              "FAILED"
            ];
          };
        };
      };
    };

    harpoon = {
      enable = true;
      enableTelescope = false;
    };

    project-nvim = {
      enable = true;
      enableTelescope = false;
    };

    claude-code = {
      enable = true;
      settings = {
        window = {
          split_ratio = 0.4;
          position = "horizontal";
          hide_numbers = false;
          hide_signcolumn = false;
        };
      };
    };

    spectre = {
      enable = true;
    };

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          css = [ "prettier" ];
          go = [
            "gofumpt"
            "goimports"
          ];
          html = [ "prettier" ];
          javascript = [ "deno" ];
          json = [ "prettier" ];
          lua = [ "stylua" ];
          markdown = [ "prettier" ];
          nix = [ "nixfmt-rfc-style" ];
          python = [
            "ruff_format"
            "ruff_organize_imports"
          ];
          rust = [ "rustfmt" ];
          sh = [ "shfmt" ];
          terraform = [ "terraform_fmt" ];
          toml = [ "taplo" ];
          typescript = [ "deno_fmt" ];
          yaml = [ "prettier" ];
          "_" = [ "trim_whitespace" ];
        };
        format_after_save = {
          lsp_fallback = true;
        };
        log_level = "warn";
        notify_on_error = true;
      };
    };
  };

  # Extra configuration
  extraConfigLua = ''
    -- Additional Lua configuration can go here

    -- Set up additional keymaps or plugin configurations
    vim.api.nvim_set_keymap('n', '<leader>/', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true, desc = "Toggle comment" })
    vim.api.nvim_set_keymap('v', '<leader>/', '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { noremap = true, silent = true, desc = "Toggle comment" })

    -- Custom Neo-tree commands
    require("neo-tree").setup({
      commands = {
        find_files_in_dir = function(state)
          local node = state.tree:get_node()
          local path = node.type == "file" and node:get_parent_id() or node:get_id()
          require("snacks").picker.files { cwd = path }
        end,
        find_all_files_in_dir = function(state)
          local node = state.tree:get_node()
          local path = node.type == "file" and node:get_parent_id() or node:get_id()
          require("snacks").picker.files { cwd = path, hidden = true, ignored = true }
        end,
        find_words_in_dir = function(state)
          local node = state.tree:get_node()
          local path = node.type == "file" and node:get_parent_id() or node:get_id()
          require("snacks").picker.grep { cwd = path }
        end,
        find_all_words_in_dir = function(state)
          local node = state.tree:get_node()
          local path = node.type == "file" and node:get_parent_id() or node:get_id()
          require("snacks").picker.grep { cwd = path, hidden = true, ignored = true }
        end,
        system_open = function(state)
          vim.ui.open(state.tree:get_node():get_id())
        end,
        parent_or_close = function(state)
          local node = state.tree:get_node()
          if node:has_children() and node:is_expanded() then
            state.commands.toggle_node(state)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        child_or_open = function(state)
          local node = state.tree:get_node()
          if node:has_children() then
            if not node:is_expanded() then -- if unexpanded, expand
              state.commands.toggle_node(state)
            else -- if expanded and has children, select the next child
              if node.type == "file" then
                state.commands.open(state)
              else
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
              end
            end
          else -- if has no children
            state.commands.open(state)
          end
        end,
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local vals = {
            ["BASENAME"] = modify(filename, ":r"),
            ["EXTENSION"] = modify(filename, ":e"),
            ["FILENAME"] = filename,
            ["PATH (CWD)"] = modify(filepath, ":."),
            ["PATH (HOME)"] = modify(filepath, ":~"),
            ["PATH"] = filepath,
            ["URI"] = vim.uri_from_fname(filepath),
          }

          local options = vim.tbl_filter(function(val) return vals[val] ~= "" end, vim.tbl_keys(vals))
          if vim.tbl_isempty(options) then
            vim.notify("No values to copy", vim.log.levels.WARN)
            return
          end
          table.sort(options)
          vim.ui.select(options, {
            prompt = "Choose to copy to clipboard:",
            format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
          }, function(choice)
            local result = vals[choice]
            if result then
              vim.notify(("Copied: `%s`"):format(result))
              vim.fn.setreg("+", result)
            end
          end)
        end,
      },
      filesystem = {
        window = {
          mappings = {
            f = { "show_help", nowait = false, config = { title = "Find Files", prefix_key = "f" } },
            ["f/"] = "filter_on_submit",
            ff = "find_files_in_dir",
            fF = "find_all_files_in_dir",
            fw = "find_words_in_dir",
            fW = "find_all_words_in_dir",
          },
        },
      },
    })

    -- Neo-tree event handlers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "neo-tree",
      callback = function()
        vim.opt_local.signcolumn = "auto"
        vim.opt_local.foldcolumn = "0"
      end,
    })
    -- Luasnip keymaps for jumping in snippets
    vim.keymap.set({"i", "s"}, "<C-j>", function()
      if require("luasnip").jumpable(1) then
        require("luasnip").jump(1)
      end
    end, { silent = true })

    vim.keymap.set({"i", "s"}, "<C-k>", function()
      if require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      end
    end, { silent = true })

  '';
}
