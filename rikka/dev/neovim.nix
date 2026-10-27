{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ripgrep
    fd
  ];

  programs.neovim = {
    enable = true;
    configure = {
      customLuaRC = ''
        -- THEMES
        vim.opt.number = true
        vim.o.background = "dark"
        vim.cmd("highlight Normal guibg=#000000")
        vim.cmd("highlight NormalNC guibg=#000000")
        vim.opt.statuscolumn = ""
        vim.opt.cursorline = true
        local suisei_hl = vim.api.nvim_create_augroup("SuiseiHighlight", { clear = true })

        vim.api.nvim_create_autocmd("ColorScheme", {
          group = suisei_hl,
          pattern = "*",
          callback = function()
            vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#5EBCF6', bold = true })
              vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#161616'})
            end,
        })
        vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#5EBCF6', bold = true })
        vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#161616'})
        -- END OF THEMES

        -- TABBING
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true
        vim.opt.softtabstop = 2
        vim.opt.smarttab = true
        vim.opt.autoindent = true
        vim.opt.smartindent = true
        vim.opt.backspace = { "indent", "eol", "start" }
        -- END OF TABBING

        -- FILE-TYPE STYLE
        vim.g.rust_recommended_style = 0
        vim.g.python_recommended_style = 0
        
        -- ACTIVATE PLUGINS

        -- Autopairs
        require('nvim-autopairs').setup({
          disable_filetype = { "TelescopePrompt" , "vim" },
        })

        -- Nvim-tree-lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true
        ---@type nvim_tree.config
        local config = {
          sort = {
            sorter = "case_sensitive",
          },
          view = {
            width = 26,
          },
        }
        require("nvim-tree").setup(config)
        vim.keymap.set('n', '<M-e>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

        -- Nvim-treesitter-context
        require'treesitter-context'.setup{
          enable = true,
          max_lines = 1,
          line_numbers = true,
          mode = 'topline',
        }

        -- Indent-blankline-nvim
        require("ibl").setup()

        -- Cmp
        local cmp = require('cmp') 
        cmp.setup({
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body) 
            end,
          },
          mapping = cmp.mapping.preset.insert({            
            ['<Esc>'] = cmp.mapping.abort(),                    
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { 'i', 's' }),

            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),

          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'treesitter' },
          })
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local default_servers = { 
          'clangd', 
          'rust_analyzer', 
          'pyright', 
          'bashls', 
        }

        for _, lsp in ipairs(default_servers) do
          vim.lsp.config(lsp, {
            capabilities = capabilities,
          })
          vim.lsp.enable(lsp)
        end

        vim.lsp.config('lua_ls', {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
            }
          }
        })
        vim.lsp.enable('lua_ls')

        vim.lsp.config('nil_ls', {
          capabilities = capabilities,
          settings = {
            ['nil'] = {
              nix = {
                flake = {
                  autoArchive = false,
                },
              },
            },
          },
        })
        vim.lsp.enable('nil_ls')

        -- Telescope 
        local telescope = require('telescope')
        telescope.setup({
          defaults = {
            file_ignore_patterns = {
              "%.xlsx$", "%.docx",
              "%.png$", "%.jpg$", "%.jpeg$", "%.gif$", "%.webp$", "%.svg$", "%.mp3$", "%.mp4$", "%.flac", "%.opus$", "%.mkv$",
              "%.pdf$", "%.img$", "%.qcow2$", "%.iso$", "%.7z$", "%.zip$", "%.tar$", "%.tar%.gz$", "%.tar%.xz$", "%.tar%.zstd$",
              "%.o$", "%.so$", "%.bin$", "%.elf$", "%.log$",
              "^%.git/", "^node_modules/", "^%.cache/", "^target/", "^linux/", "^bsd/",
              "^compile/", "^Downloads/", "^Videos/", "^os/", "^Pictures/", "^college/",
              "^windows%-game/", "^Games/"
            },
          },
        })

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<M-o>', builtin.find_files, { noremap = true, silent = true })
        vim.keymap.set('n', '<M-g>', builtin.live_grep, { noremap = true, silent = true })

        -- Terminal (floating popup, runs zsh)
        local term = { buf = nil, win = nil }
        local term_shell = "${pkgs.zsh}/bin/zsh"

        local function term_float_config()
          local width = math.floor(vim.o.columns * 0.8)
          local height = math.floor(vim.o.lines * 0.8)
          return {
            relative = "editor",
            width = width,
            height = height,
            row = math.floor((vim.o.lines - height) / 2) - 1,
            col = math.floor((vim.o.columns - width) / 2),
            style = "minimal",
            border = "rounded",
            title = " Terminal ",
            title_pos = "center",
          }
        end

        local function toggle_terminal()
          -- hide the popup if it is currently visible
          if term.win and vim.api.nvim_win_is_valid(term.win) then
            vim.cmd("stopinsert")
            vim.api.nvim_win_hide(term.win)
            term.win = nil
            return
          end

          local fresh = not (term.buf and vim.api.nvim_buf_is_valid(term.buf))
          if fresh then
            term.buf = vim.api.nvim_create_buf(false, true)
          end

          term.win = vim.api.nvim_open_win(term.buf, true, term_float_config())

          if fresh then
            vim.fn.jobstart({ term_shell }, { term = true })
            -- press q in normal mode to hide the popup
            vim.keymap.set('n', 'q', toggle_terminal, { buffer = term.buf, silent = true, desc = "Hide terminal" })
          end

          vim.cmd("startinsert")
        end

        -- when the shell exits (e.g. `exit`), close the popup and forget the buffer
        vim.api.nvim_create_autocmd("TermClose", {
          callback = function(args)
            if args.buf == term.buf then
              local win = term.win
              local buf = term.buf
              term.buf = nil
              term.win = nil
              vim.schedule(function()
                if win and vim.api.nvim_win_is_valid(win) then
                  pcall(vim.api.nvim_win_close, win, true)
                end
                if vim.api.nvim_buf_is_valid(buf) then
                  pcall(vim.api.nvim_buf_delete, buf, { force = true })
                end
              end)
            end
          end,
        })

        -- keep the popup centered when the Neovim window is resized
        vim.api.nvim_create_autocmd("VimResized", {
          callback = function()
            if term.win and vim.api.nvim_win_is_valid(term.win) then
              vim.api.nvim_win_set_config(term.win, term_float_config())
            end
          end,
        })

        vim.api.nvim_create_user_command("Terminal", toggle_terminal, {})
        vim.keymap.set({ 'n', 't' }, '<M-t>', toggle_terminal, { noremap = true, silent = true, desc = "Toggle terminal" })
        -- leave terminal mode with Esc Esc
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = term.buf, silent = true })
        vim.keymap.set('t', '<M-c>', '<Esc>', { buffer = term.buf, silent = true })

        -- Alpha-nvim (Dashboard)
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')

        dashboard.section.header.val = {
          [[ _______  _____  _    _ ___     __ _    _ ]],
          [[|__   __|/ ____|| |  | |\\ \   / /| |  | |]],
          [[   | |  | (____ | |  | | \\ \_/ / | |  | |]],
          [[   | |   \___  \| |  | |  \\   /  | |  | |]],
          [[   | |   ____) || |__| |   || |   | |__| |]],
          [[   |_|  |_____/  \____/    ||_|    \____/ ]]
        }

        -- Make a new folder (relative paths are resolved from the current directory)
        local function make_folder()
          vim.ui.input({ prompt = "New folder name: ", completion = "dir" }, function(input)
            if not input or input == "" then
              return
            end

            local path = vim.fn.fnamemodify(vim.fn.expand(input), ":p")

            if vim.fn.isdirectory(path) == 1 then
              vim.notify("Folder already exists: " .. path, vim.log.levels.WARN)
              return
            end

            local ok = pcall(vim.fn.mkdir, path, "p")
            if ok and vim.fn.isdirectory(path) == 1 then
              vim.notify("Folder created: " .. path, vim.log.levels.INFO)
              -- refresh nvim-tree if it is loaded
              pcall(function() require("nvim-tree.api").tree.reload() end)
            else
              vim.notify("Failed to create folder: " .. path, vim.log.levels.ERROR)
            end
          end)
        end

        vim.api.nvim_create_user_command("MakeFolder", make_folder, {})

        dashboard.section.buttons.val = {
          dashboard.button("t", "  Terminal", "<cmd>Terminal<CR>"),
          dashboard.button("n", "  New file", "<cmd>ene <CR>"),
          dashboard.button("m", "  New folder", "<cmd>MakeFolder<CR>"),
          dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
          dashboard.button("r", "  Recent open file", "<cmd>Telescope oldfiles<CR>"),
          dashboard.button("<M-f>", "󰺄  Find words", "<cmd>Telescope live_grep<CR>"),
          dashboard.button("e", "󰈆  Exit", "<cmd>qa<CR>"),
        }

        alpha.setup(dashboard.opts)
        -- END OF ACTIVATE PLUGINS

        --ADDITIONAL OPTIONS
        vim.opt.mouse = 'a'
      '';

      packages.haruSuiseiNeovim = with pkgs.vimPlugins; {
        start = [
          nvim-autopairs
          nvim-tree-lua
          nvim-treesitter-context
          
          (nvim-treesitter.withPlugins (n: [
            n.nix
            n.python
            n.c
            n.cpp
            n.rust
            n.lua
            n.bash
          ]))

          indent-blankline-nvim
          cmp-treesitter
          cmp-nvim-lsp
          nvim-cmp
          nvim-lspconfig
          luasnip
          telescope-nvim
          plenary-nvim
          alpha-nvim
          nvim-web-devicons
        ];
      };
    };
  };
}
