local keymap = require 'koeila.utils.keymap'

local keymaps = {
  lsp = {
    n = {
      ['[d'] = { '<CMD>lua vim.diagnostic.goto_prev()<CR>', '[LSP]: Go to next diagnostic' },
      [']d'] = { '<CMD>lua vim.diagnostic.goto_next()<CR>', '[LSP]: Go to previous diagnostic' },
      ['gD'] = { '<CMD>lua vim.lsp.buf.declaration()<CR>', '[LSP]: Go to declaration' },
      ['gd'] = { '<CMD>lua vim.lsp.buf.definition()<CR>', '[LSP]: Go to definition [Implementation]' },
      ['K'] = { '<CMD>lua vim.lsp.buf.hover()<CR>', '[LSP]: Get variable docs' },
      ['<leader>K'] = { '<CMD>DocsViewToggle<CR>', '[LSP]: Get variable docs on panel' },
      ['<leader>k'] = { '<CMD>lua vim.lsp.buf.signature_help()<CR>',
        '[LSP]: Parameters of a function and their descriptions' },
      ['<leader>rn'] = { '<CMD>lua vim.lsp.buf.rename()<CR>', '[LSP]: Rename variable' },
      ['<leader>ca'] = { '<CMD>lua vim.lsp.buf.code_action()<CR>', '[LSP]: Code actions' },
      ['<leader>fm'] = { '<CMD>lua vim.lsp.buf.format({ async = true })<CR>', '[LSP]: Format code' },
    },
  },

  dap = {
    n = {
      ['<leader>b'] = { '<CMD>DapToggleBreakpoint<CR>', '[DAP]: Toggle breakpoint' },
      ['<leader>lb'] = { '<CMD>lua  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', '[DAP]: Breakpoint log' },
      ['<F8>'] = { '<CMD>DapTerminate<CR>', '[DAP]: Terminate' },
      ['<F9>'] = { '<CMD>DapContinue<CR>', '[DAP]: Continue' },
      ['<F10>'] = { '<CMD>DapStepInto<CR>', '[DAP]: Step into' },
      ['<F11>'] = { '<CMD>DapStepOver<CR>', '[DAP]: Step over' },
      ['<F12>'] = { '<CMD>DapStepOut<CR>', '[DAP]: Step out' }
    }
  },

  terminal = {
    attach = {
      t = {
        ['<esc>'] = { [[<C-\><C-n>]], 'Terminal escape mode' },
        ['jj'] = { [[<C-\><C-n>]], '' },
        ['<C-h>'] = { [[<Cmd>wincmd h<CR>]], '' },
        ['<C-j>'] = { [[<Cmd>wincmd j<CR>]], '' },
        ['<C-k>'] = { [[<Cmd>wincmd k<CR>]], '' },
        ['<C-l>'] = { [[<Cmd>wincmd l<CR>]], '' },
        ['<C-w>'] = { [[<C-\><C-n><C-w>]], '' }
      },
    },
    normal = {
      n = {
        -- ['<C-t>'] = { '<cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>', 'Terminal: Open horizontal' },
        ['<C-t>'] = { '<cmd>lua _TERM_HORIZONTAL()<CR>', 'Terminal: Open horizontal' },
        ['<leader>tg'] = { '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Terminal: Open lazygit' },
        ['<leader>tn'] = { '<cmd>lua _NODE_TOGGLE()<CR>', 'Terminal: Open node' },
        ['<leader>tt'] = { '<cmd>lua _HTOP_TOGGLE()<CR>', 'Terminal: Open Htop' },
        ['<leader>tp'] = { '<cmd>lua _PYTHON_TOGGLE()<CR>', 'Terminal: Open python' }
      }
    }
  },

  telescope = {
    n = {
      ['<leader>ff'] = { '<cmd>lua require("telescope.builtin").find_files({ previewer = false })<cr>',
        'Telescope: Find files' },
      ['<leader>fg'] = { '<cmd>lua require("telescope.builtin").live_grep()<cr>', 'Telescope: Find grep' },
      ['<leader>fb'] = { '<cmd>lua require("telescope.builtin").buffers({ previewer = false })<cr>',
        'Telescope: Find buffers' },
      ['<leader>fh'] = { '<cmd>lua require("telescope.builtin").help_tags()<cr>', 'Telescope: Find buffers' },
      ['<leader>tk'] = { '<cmd>lua require("telescope.builtin").keymaps()<cr>', 'Telescope: Keymaps' },
      ['<leader>th'] = { '<cmd>lua require("koeila.utils.theme").change()<cr>', 'Telescope: Theme changer' },
    }
  },

  neotree = {
    n = {
      ['<C-n>'] = { '<cmd>Neotree toggle<cr>', 'File explore: Neotree toggle' },
    }
  },

  todo_comment = {
    n = {
      [']t'] = { '<CMD>lua require("todo-comments").jump_next()<CR>', 'Next todo comment' },
      ['[t'] = { '<CMD>lua require("todo-comments").jump_prev()<CR>', 'Previous todo comment' },
      ['<leader>td'] = { '<CMD>TodoTelescope<CR>', 'Open TODOS with telescope' }
    }
  },

  symbols = {
    n = {
      ['<leader><Tab>'] = { '<cmd>SymbolsOutline<CR>', 'Open symbols tree' }
    }
  },

  fold = {
    n = {
      ['<leader>W'] = { '<cmd>lua require("ufo").openAllFolds()<CR>', 'Open fold' },
      ['<leader>w'] = { '<cmd>lua require("ufo").closeAllFolds()<CR>', 'Close fold' },
    }
  },

  code_runner = {
    n = {
      ['<leader>8'] = { '<cmd>RunCode<CR>', 'Run code' },
    }
  }
}

return {
  set_lsp = function(bufnr)
    keymap.set_buffer(bufnr, keymaps.lsp)
  end,

  set_terminal = {
    buffer = function(bufnr)
      keymap.set_buffer(bufnr, keymaps.terminal.attach)
      keymap.set_buffer(bufnr, keymaps.terminal.normal)
    end,

    handlers = function()
      local Terminal = require('toggleterm.terminal').Terminal

      local term = Terminal:new({
        hidden = true,
        direction = "horizontal",
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })
      function _TERM_HORIZONTAL()
        term:toggle()
      end

      local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      local node = Terminal:new({ cmd = 'node', hidden = true })
      function _NODE_TOGGLE()
        node:toggle()
      end

      local htop = Terminal:new({ cmd = 'htop', hidden = true })
      function _HTOP_TOGGLE()
        htop:toggle()
      end

      local python = Terminal:new({ cmd = 'python', hidden = true })
      function _PYTHON_TOGGLE()
        python:toggle()
      end

      keymap.set_buffer(0, keymaps.terminal.normal)
    end
  },

  set_telescope = function()
    keymap.set(keymaps.telescope)
  end,

  set_neotree = function()
    keymap.set(keymaps.neotree)
  end,

  set_todo = function()
    keymap.set(keymaps.todo_comment)
  end,

  set_symbols = function()
    keymap.set(keymaps.symbols)
  end,

  set_fold = function()
    keymap.set(keymaps.fold)
  end,

  set_code_run = function()
    keymap.set(keymaps.code_runner)
  end,

  set_dap = function()
    keymap.set(keymaps.dap)
  end
}
