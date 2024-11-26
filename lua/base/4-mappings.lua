-- Keybindings (qwerty).

-- DESCRIPTION:
-- All mappings are defined here.

--    Sections:
--       ## Base bindings
--       -> icons displayed on which-key.nvim
--       -> standard operations
--       -> clipboard
--       -> search highlighting
--       -> improved tabulation
--       -> improved gg
--       -> packages
--       -> buffers/tabs                       [buffers]
--       -> ui toggles                         [ui]
--       -> shifted movement keys
--       -> cmdline autocompletion
--       -> special cases

--       ## Plugin bindings
--       -> alpha-nvim
--       -> git                                [git]
--       -> file browsers
--       -> session manager
--       -> smart-splits.nvim
--       -> aerial.nvim
--       -> litee-calltree.nvim
--       -> telescope.nvim                     [find]
--       -> toggleterm.nvim
--       -> dap.nvim                           [debugger]
--       -> tests                              [tests]
--       -> nvim-ufo
--       -> code documentation                 [docs]
--       -> ask chatgpt                        [neural]
--       -> mason-lspconfig.nvim               [lsp]

--
--   KEYBINDINGS REFERENCE
--   -------------------------------------------------------------------
--   |        Mode  | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |
--   Command        +------+-----+-----+-----+-----+-----+------+------+
--   [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
--   n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
--   [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
--   i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
--   c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
--   v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
--   x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
--   s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
--   o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
--   t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
--   l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
--   -------------------------------------------------------------------

-- NOTE: VARIABLES
local M = {}
-- TODO: refactor all functions declared here
local utils = require("base.utils")
local get_icon = utils.get_icon
local is_available = utils.is_available
local ui = require("base.utils.ui")
local maps = require("base.utils").get_mappings_template()
-- local is_android = vim.fn.isdirectory('/data') == 1 -- true if on android
-- TODO: refactor. see utils.notify and others in this file
-- HACK:
-- Ensure that nvim-notify is loaded
local notify = require("notify")

-- NOTE: BASE BINDINGS

-- NOTE: WHICH-KEY ICONS
local icons = {
  a = { desc = get_icon("Action", true) .. " Actions" },
  ad = { desc = get_icon("Delete", true) .. " Delete" },
  b = { desc = get_icon("Buffer", true) .. " Buffers" },
  bs = { desc = get_icon("Sort", true) .. " Sort Buffers" },
  c = { desc = get_icon("Compiler", true) .. " Compiler" },
  d = { desc = get_icon("Debugger", true) .. " Debugger" },
  dc = { desc = get_icon("Docs", true) .. " Docs" },
  f = { desc = get_icon("Find", true) .. " Find" },
  g = { desc = get_icon("Git", true) .. " Git" },
  i = { desc = get_icon("Insert", true) .. " Insert" },
  l = { desc = get_icon("LSP", true) .. " LSP" },
  m = { desc = get_icon("Markdown", true) .. " Markdown" },
  n = { desc = get_icon("Neovim", true) .. " Neovim" },
  p = { desc = get_icon("Packages", true) .. " Packages" },
  s = { desc = get_icon("Session", true) .. " Session" },
  t = { desc = get_icon("Terminal", true) .. " Terminal" },
  tt = { desc = get_icon("Test", true) .. " Test" },
  u = { desc = get_icon("UI", true) .. " UI" },
  x = { desc = get_icon("Scratchpads", true) .. " Scratchpads" },
}

-- NOTE: GENERAL KEYMAPS

maps.n["j"] =
{ "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "  Move cursor down" }
maps.n["k"] =
{ "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "  Move cursor up" }

maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "  Save file" }
maps.n["<leader>W"] =
{ function() vim.cmd("SudaWrite") end, desc = "  Save as sudo" }

maps.n["<leader>+"] = { "<cmd>enew<cr>", desc = "  New file" }

-- commenting
-- TODO: change binding
maps.n["<Leader>/"] = { "gcc", remap = true, desc = "  Toggle comment line" }
maps.x["<Leader>/"] = { "gc", remap = true, desc = "  Toggle comment" }

-- FIX: gc conflict. Run checkhealth which-key
maps.n["gca"] = { "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>",
  desc = "  Add comment above" }
maps.n["gco"] = { "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>",
  desc = "  Add comment below" }

-- FIX: there's a flickering in the heirline mode when moving lines

-- Move Lines
maps.n["<A-j>"] = { "<cmd>execute 'move .+' . v:count1<cr>==",
  desc = "  Move line down", noremap = true, silent = true }

maps.n["<A-k>"] = { "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==",
  desc = "  Move line up", noremap = true, silent = true }

maps.i["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi",
  desc = "  Move line down", noremap = true, silent = true }

maps.i["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi",
  desc = "  Move line up", noremap = true, silent = true }

maps.v["<A-j>"] = { ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
  desc = "  Move line down", noremap = true, silent = true }

maps.v["<A-k>"] = { ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
  desc = "  Move line up", noremap = true, silent = true }

-- FIX:
-- maps.n["gx"] =
-- { utils.open_with_program, desc = "Open the file under cursor with a program" }

maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.i["<C-BS>"] = { "<C-W>", desc = "Enable CTRL+backsace to delete" }
maps.n["0"] = { "^", desc = "Go to the fist character of the line" }
maps.v["0"] = { "^", desc = "Go to the fist character of the line" }
maps.n["«"] = { "$", desc = "Go to the last character of the line" }
maps.n["»"] = { "0", desc = "Go to the first position of the line" }
maps.v["»"] = { "0", desc = "Go to the first position of the line" }
maps.v["«"] = { "$", desc = "Go to the last character of the line" }

-- Navigation, find and center page
maps.n["n"] = { "nzzzv", desc = "Find forwards and center" }
maps.n["N"] = { "Nzzzv", desc = "Find backwards and center" }
maps.n["G"] = { "Gzz", desc = "Go to page bottom and center" }
maps.n["*"] = { "*zz",  desc = "TODO" }
maps.n["#"] = { "#zz", desc = "TODO" }
maps.n["g*"] = { "g*zz", desc = "TODO" }
maps.n["g#"] = { "g#zz", desc = "TODO" }
maps.n["<PageDown>"] = { "<C-d>zz", desc = "Page down and center" }
maps.n["<PageUp>"] = { "<C-u>zz", desc = "Page up and center" }
maps.n["<kPageDown>"] = { "<C-d>zz", desc = "Page down and center" }
maps.n["<kPageUp>"] = { "<C-u>zz", desc = "Page up and center" }

-- NOTE: KEYPAD/KEYCODES
-- https://neovim.io/doc/user/intro.html#Terminal-mode
-- key-notation key-codes keycodes
maps.n["<Home>"] = { "gg", desc = "Go to top of page" }
maps.n["<kHome>"] = { "gg", desc = "Go to top of page" }
maps.n["<kUp>"] = { "gg", desc = "Go to top of page" }
maps.n["<kEnd>"] = { "Gzz", desc = "Go to bottom of page" }
maps.n["<kDown>"] = { "Gzz", desc = "Go to bottom of page" }
maps.n["<kLeft>"] = { "^", desc = "Go to first non blank character in line" }
maps.n["<kRight>"] = { "$", desc = "Go to last character in line" }


-- NOTE: QUIT NEOVIM
maps.n["<leader>sq"] = {
  -- function()
  --   -- Ask user for confirmation
  --   local choice = vim.fn.confirm("Do you really want to exit nvim?", "&Yes\n&No", 2)
  --   if choice == 1 then
  --     -- If user confirms, but there are still files to be saved: Ask
  --     vim.cmd('confirm quit')
  --   end
  -- end,
  "<cmd>wqa<cr>",
  desc = "  Quit Neovim",
}

maps.n["<leader>sQ"] = { "<cmd>qall<cr>", desc = "  Force quit Neovim" }

maps.n["<Tab>"] = {
  "<Tab>",
  noremap = true,
  silent = true,
  expr = false,
  desc = "FIX: Prevent TAB from behaving like <C-i>",
}

-- NOTE: CLIPBOARD

-- only useful when the option clipboard is commented on ./1-options.lua
maps.n["<C-y>"] = { '"+y<esc>', desc = "Copy to cliboard" }
maps.x["<C-y>"] = { '"+y<esc>', desc = "Copy to cliboard" }
maps.n["<C-d>"] = { '"+y<esc>dd', desc = "Copy to clipboard and delete line" }
maps.x["<C-d>"] = { '"+y<esc>dd', desc = "Copy to clipboard and delete line" }
maps.n["<C-p>"] = { '"+p<esc>', desc = "Paste from clipboard in normal mode" }

vim.api.nvim_set_keymap('i', '<C-v>', '<C-r>+', {
  desc = "Paste from clipboard in insert mode",
  noremap = true, silent = true })

-- Make 'c' key not copy to clipboard when changing a character.
maps.n["c"] = { '"_c', desc = "Change without yanking" }
maps.n["C"] = { '"_C', desc = "Change without yanking" }
maps.x["c"] = { '"_c', desc = "Change without yanking" }
maps.x["C"] = { '"_C', desc = "Change without yanking" }

-- Make 'x' key not copy to clipboard when deleting a character.
maps.n["x"] = {
  -- Also let's allow 'x' key to delete blank lines in normal mode.
  function()
    if vim.fn.col "." == 1 then
      local line = vim.fn.getline "."
      if line:match "^%s*$" then
        vim.api.nvim_feedkeys('"_dd', "n", false)
        vim.api.nvim_feedkeys("$", "n", false)
      else
        vim.api.nvim_feedkeys('"_x', "n", false)
      end
    else
      vim.api.nvim_feedkeys('"_x', "n", false)
    end
  end,
  desc = "Delete character without yanking it",
}
maps.x["x"] = { '"_x', desc = "Delete all characters in line" }

-- Same for shifted X
maps.n["X"] = {
  -- Also let's allow 'x' key to delete blank lines in normal mode.
  function()
    if vim.fn.col "." == 1 then
      local line = vim.fn.getline "."
      if line:match "^%s*$" then
        vim.api.nvim_feedkeys('"_dd', "n", false)
        vim.api.nvim_feedkeys("$", "n", false)
      else
        vim.api.nvim_feedkeys('"_X', "n", false)
      end
    else
      vim.api.nvim_feedkeys('"_X', "n", false)
    end
  end,
  desc = "Delete before character without yanking it",
}
maps.x["X"] = { '"_X', desc = "Delete all characters in line" }

-- Override nvim default behavior so it doesn't auto-yank
-- when pasting on visual mode.
maps.x["p"] = { "P", desc = "Paste previously yanked content" }
maps.x["P"] = { "p", desc = "Yank what we want to override, then paste" }

-- NOTE:
-- TODO:
-- set other keybindings
-- if vim.g.neovide then
  -- map('n', '<C-s>', ':w<CR>') -- Save
  -- map('v', '<C-c>', '"+y') -- Copy
  -- map('n', '<C-v>', '"+P') -- Paste normal mode
  -- map('v', '<C-v>', '"+P') -- Paste visual mode
  -- map('c', '<C-v>', '<C-R>+') -- Paste command mode
-- end

-- TODO:
-- set other keybindings
-- Allow clipboard copy paste in neovim
-- vim.api.nvim_set_keymap('',  '<C-v>', '+p<CR>', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('t', '<C-v>', '<C-R>+', { noremap = true, silent = true})
-- vim.api.nvim_set_keymap('v', '<C-v>', '<C-R>+', { noremap = true, silent = true})

-- search highlighting
-- use ESC to clear hlsearch, while preserving its original functionality.
--
-- TIP: If you prefer,  use <leader>ENTER instead of <ESC>
--      to avoid triggering it by accident.
maps.n["<ESC>"] = {
  function()
    if vim.fn.hlexists("Search") then
      vim.cmd("nohlsearch")
    else
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<ESC>", true, true, true),
        "n",
        true
      )
    end
  end,
}

-- Exit out of insert mode
maps.i["jk"] = { "<esc>", desc = "Exit insert mode with jk" }
maps.i["kj"] = { "<esc>", desc = "Exit insert mode with kj" }

-- Improved tabulation
maps.x["<S-Tab>"] = { "<gv", desc = "unindent line" }
maps.x["<Tab>"] = { ">gv", desc = "indent line" }
maps.x["<"] = { "<gv", desc = "unindent line" }
maps.x[">"] = { ">gv", desc = "indent line" }

-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "Decrease indentation (in visual mode)" }
maps.v[">"] = { ">gv", desc = "Increase indentation (in visual mode)" }

-- Improved gg
maps.n["gg"] = {
  -- function()
  --   vim.g.minianimate_disable = true
  --   if vim.v.count > 0 then
  --     vim.cmd("normal! " .. vim.v.count .. "gg")
  --   else
  --     vim.cmd("normal! gg0")
  --   end
  --   vim.g.minianimate_disable = false
  -- end,
  desc = "gg and go to the first position",
}
maps.n["G"] = {
  -- function()
  --   vim.g.minianimate_disable = true
  --   vim.cmd("normal! G$")
  --   vim.g.minianimate_disable = false
  -- end,
  desc = "G and go to the last position",
}
maps.x["gg"] = {
  -- function()
  --   vim.g.minianimate_disable = true
  --   if vim.v.count > 0 then
  --     vim.cmd("normal! " .. vim.v.count .. "gg")
  --   else
  --     vim.cmd("normal! gg0")
  --   end
  --   vim.g.minianimate_disable = false
  -- end,
  desc = "gg and go to the first position (visual)",
}
maps.x["G"] = {
  -- function()
  --   vim.g.minianimate_disable = true
  --   vim.cmd("normal! G$")
  --   vim.g.minianimate_disable = false
  -- end,
  desc = "G and go to the last position (visual)",
}
maps.n["<C-a>"] = { -- to move to the previous position press ctrl + oo
  -- function()
  --   vim.g.minianimate_disable = true
  --   vim.cmd("normal! gg0vG$")
  --   vim.g.minianimate_disable = false
  -- end,
  desc = "Visually select all",
}

-- NOTE: LAZY
maps.n["<leader>p"] = icons.p
maps.n["<leader>pu"] =
{ function() require("lazy").check() end, desc = "󰒲  Open Lazy" }
maps.n["<leader>pU"] =
{ function() require("lazy").update() end, desc = "  Update Lazy" }

-- NOTE: MASON
if is_available("mason.nvim") then
  maps.n["<leader>pm"] = { "<cmd>Mason<cr>", desc = "  Open Mason " }
  maps.n["<leader>pM"] = { "<cmd>MasonUpdateAll<cr>",
    desc = "  Update Mason" }
end

-- NOTE: TREESITTER
if is_available("nvim-treesitter") then
  maps.n["<leader>pT"] = { "<cmd>TSUpdate<cr>",
    desc = "  Update Treesitter" }
  maps.n["<leader>pt"] = { "<cmd>TSInstallInfo<cr>",
    desc = "  Open Treesitter" }
end

-- NOTE: DISTRO UPDATER
maps.n["<leader>pD"] = { "<cmd>DistroUpdate<cr>",
  desc = "  Update the distro" }
maps.n["<leader>pv"] = { "<cmd>DistroReadVersion<cr>",
  desc = "  Check the distro version" }
maps.n["<leader>pc"] = { "<cmd>DistroReadChangelog<cr>",
  desc = "  Read the distro changelog" }

-- NOTE: BUFFERS
maps.n["<leader>b"] = icons.b

maps.n["<leader>ba"] = {
  function() vim.cmd("wa") end,
  desc = "󰆔  Write all changed buffers",
}
maps.n["<leader>bc"] = {
  "ggVG<cr>",
  desc = "  Select the buffer content",
}

-- NOTE: SCRATCHPADS
maps.n["<leader>x"] = icons.x
  -- desc = "  Open markdown scratchpad",

-- Function to open a scratchpad with proper filename display
function OpenScratchpad(filename)
    vim.cmd('tabnew')
    vim.cmd('edit ' .. filename)
end

-- Create keybindings for specific scratchpads
vim.api.nvim_set_keymap('n', '<leader>xm',
  ':lua OpenScratchpad("~/tmp/test.md")<cr>', {
    desc = "  Open a markdown scratchpad",
    noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>xj',
  ':lua OpenScratchpad("~/tmp/test.js")<cr>', {
    desc = "  Open a javascript scratchpad",
    noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>xc',
  ':lua OpenScratchpad("~/tmp/test.css")<cr>', {
    desc = "  Open a css scratchpad",
    noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>xh',
  ':lua OpenScratchpad("~/tmp/test.html")<cr>', {
    desc = "  Open a html scratchpad",
    noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>xp',
  ':lua OpenScratchpad("~/tmp/test.py")<cr>', {
    desc = "  Open a python scratchpad",
    noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>xr',
  ':lua OpenScratchpad("~/tmp/test.rb")<cr>', {
    desc = "  Open a ruby scratchpad",
    noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>xs',
  ':lua OpenScratchpad("~/tmp/test.sh")<cr>', {
    desc = "  Open a shell scratchpad",
    noremap = true, silent = true })

maps.n["<leader>bk"] = {
  function() require("heirline-components.buffer").close_all() end,
  desc = "  Close all buffers",
}
maps.n["<leader>bl"] = {
  function() require("heirline-components.buffer").close_left() end,
  desc = "  Close all buffers to the left",
}
maps.n["<leader>bo"] = {
  function() require("heirline-components.buffer").close_all(true) end,
  desc = "  Close all buffers except current",
}
maps.n["<leader>br"] = {
  function() require("heirline-components.buffer").close_right() end,
  desc = "  Close all buffers to the right",
}
maps.n["<leader>bs"] = icons.bs

-- Function to select and sort the entire buffer content
function SelectAndSortBuffer()
    -- Select the entire buffer
    vim.cmd('normal! ggVG')

    -- Sort the selected content
    vim.cmd('sort')
end

-- Create the custom command
vim.api.nvim_create_user_command('SortBuffer', function()
    SelectAndSortBuffer()
end, { nargs = 0 })

-- Set up the keybinding
vim.api.nvim_set_keymap('n', '<leader>bsc', ':SortBuffer<cr>', {
  desc = "Sort buffer content",
  noremap = true, silent = true })

maps.n["<leader>bse"] = {
  function() require("heirline-components.buffer").sort "extension" end,
  desc = "  Sort by extension",
}
maps.n["<leader>bsr"] = {
  function() require("heirline-components.buffer").sort "unique_path" end,
  desc = "  Sort by relative path",
}
maps.n["<leader>bsp"] = {
  function() require("heirline-components.buffer").sort "full_path" end,
  desc = "  Sort by full path",
}
maps.n["<leader>bsi"] = {
  function() require("heirline-components.buffer").sort "bufnr" end,
  desc = "  Sort by buffer number",
}
maps.n["<leader>bsm"] = {
  function() require("heirline-components.buffer").sort "modified" end,
  desc = "  Sort by modification",
}
maps.n["<leader>bt"] = {
  "<cmd>tabnew<cr>",
  desc = "  Open a new tab",
}
maps.n["<leader>bw"] = {
  "ggVGd",
  desc = "  Wipe buffer content",
}
maps.n["<leader>by"] = {
  "ggVGy",
  desc = "  Yank buffer content",
}

-- FIX: disable treesitter todo syntax coloring!?? conflicts with todo-comments

-- NOTE: BUFFERS QUICK BINDINGS

maps.n["<leader>k"] = {
  function() require("heirline-components.buffer").wipe() end,
  desc = "  Close window and buffer",
}
maps.n["<leader>c"] = {
  function() require("heirline-components.buffer").close() end,
  desc = "  Close buffer, keep window",
}
maps.n["<leader>q"] = {
  "<cmd>bdelete!<cr>",
  desc = "  Force close buffer",
}
maps.n["º"] = {
  function()
    require("heirline-components.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
  end,
  desc = "  Next buffer",
}
maps.n["+"] = {
  function()
    require("heirline-components.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
  end,
  desc = "  Previous buffer",
}
maps.n[">b"] = {
  function()
    require("heirline-components.buffer").move(vim.v.count > 0 and vim.v.count or 1)
  end,
  desc = "  Move buffer tab right",
}
maps.n["<b"] = {
  function()
    require("heirline-components.buffer").move(-(vim.v.count > 0 and vim.v.count or 1))
  end,
  desc = "  Move buffer tab left",
}
maps.n["<leader>v"] = {
  function()
    require("heirline-components.all").heirline.buffer_picker(
      function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end
    )
  end,
  desc = "  Select buffer from tabline",
}
maps.n["<leader>r"] = {
  function()
    require("heirline-components.all").heirline.buffer_picker(
      function(bufnr) require("heirline-components.buffer").close(bufnr) end
    )
  end,
  desc = "󰆤  Delete buffer from tabline",
}
-- quick movement aliases
maps.n["<C-k>"] = {
  function()
    require("heirline-components.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
  end,
  desc = "  Next buffer",
}
maps.n["<C-j>"] = {
  function()
    require("heirline-components.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
  end,
  desc = "  Previous buffer",
}

maps.n["+"] = { "<cmd>bprevious<cr>", desc = "  Go to previous buffer" }
maps.n["-"] = { "<cmd>b#<cr>", desc = "  Toggle with the last buffer" }
maps.n["<Tab>"] = { "<cmd>b#<cr>", desc = "  Toggle with the last buffer" }
maps.n["gb"] = { "<cmd>bprevious<cr>", desc = "  Go to previous buffer" }
maps.n["gl"] = { "<cmd>b#<cr>", desc = " Toggle with the last buffer" }

-- FIX: huge delay. see commands/keymaps
-- Lags because gnn is bound to "Start selecting nodes with nvim-treesitter"
maps.n["gn"] = { "<cmd>bnext<cr>", desc = "  Go to next buffer" }
-- maps.n["gn"] = { "<cmd>bnext<cr>", desc = "  Go to next buffer", noremap = true }
-- :map gn
-- :map gnn
-- See: nvim-treesitter/incremental_selection.lua


-- NOTE: TABS

maps.n["gt"] = { "<cmd>tabp<cr>", desc = "  Go to previous tab" }
maps.n["gy"] = { "<cmd>tabn<cr>", desc = "  Go to next tab" }
maps.n["º"] = { "<cmd>bnext<cr>", desc = "  Go to next buffer" }

maps.n["]t"] = { function() vim.cmd.tabnext() end, desc = "  Next tab" }
maps.n["[t"] = { function() vim.cmd.tabprevious() end, desc = "  Previous tab" }

-- NOTE: WINDOWS/SPLITS

maps.n["ç"] = { "<cmd>wincmd w<cr>", desc = "  Switch between windows" }

maps.n["<leader>bq"] = {     -- Closes the window
  function()
    vim.cmd("silent! close") -- Be aware you can't close the last window
  end,
  desc = "  Close window",
}

-- TODO:
-- Close buffer keeping the window → Without confirmation.
-- maps.n["<leader>X"] = {
--   function() require("heirline-components.buffer").close(0, true) end,
--   desc = "Force close buffer",

-- Split the window
maps.n["|"] = { "<cmd>vsplit<cr>", desc = "  Split window vertically " }
maps.n["_"] = { "<cmd>split<cr>", desc = "  Split window horizontally" }

-- Pick which window to split
maps.n["<leader>b-"] = {
  function()
    require("heirline-components.all").heirline.buffer_picker(function(bufnr)
      vim.cmd.split()
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "  Split buffer horizontal from tabline",
}
maps.n["<leader>b|"] = {
  function()
    require("heirline-components.all").heirline.buffer_picker(function(bufnr)
      vim.cmd.vsplit()
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "  Split buffer vertically from tabline",
}

-- NOTE: SMART-SPLITS
if is_available("smart-splits.nvim") then
  maps.n["<C-h>"] = {
    function() require("smart-splits").move_cursor_left() end,
    desc = " Move to left split",
  }
  maps.n["<C-j>"] = {
    function() require("smart-splits").move_cursor_down() end,
    desc = "Move to below split",
  }
  maps.n["<C-k>"] = {
    function() require("smart-splits").move_cursor_up() end,
    desc = "Move to above split",
  }
  maps.n["<C-l>"] = {
    function() require("smart-splits").move_cursor_right() end,
    desc = " Move to right split",
  }
  maps.n["<C-Up>"] = {
    function() require("smart-splits").resize_up() end,
    desc = "Resize split up",
  }
  maps.n["<C-Down>"] = {
    function() require("smart-splits").resize_down() end,
    desc = "Resize split down",
  }
  maps.n["<C-Left>"] = {
    function() require("smart-splits").resize_left() end,
    desc = "Resize split left",
  }
  maps.n["<C-Right>"] = {
    function() require("smart-splits").resize_right() end,
    desc = "Resize split right",
  }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = " Move to left split" }
  maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-l>"] = { "<C-w>l", desc = " Move to right split" }
  maps.n["<C-Up>"] = { "<cmd>resize -2<cr>", desc = "Resize split up" }
  maps.n["<C-Down>"] = { "<cmd>resize +2<cr>", desc = "Resize split down" }
  maps.n["<C-Left>"] =
  { "<cmd>vertical resize -2<cr>", desc = "Resize split left" }
  maps.n["<C-Right>"] =
  { "<cmd>vertical resize +2<cr>", desc = "Resize split right" }
end

maps.n["<S-Down>"] = {
  function() vim.api.nvim_feedkeys("5j", "n", true) end,
  desc = "Fast move down",
}
maps.n["<S-Up>"] = {
  function() vim.api.nvim_feedkeys("5k", "n", true) end,
  desc = "Fast move up",
}

-- NOTE: ZEN MODE
if is_available("zen-mode.nvim") then
  maps.n["<leader>uz"] =
  { function() ui.toggle_zen_mode() end, desc = "  Toggle Zen mode" }
end

-- NOTE: UI TOGGLES
maps.n["<leader>u"] = icons.u
if is_available("nvim-autopairs") then
  maps.n["<leader>ua"] = { ui.toggle_autopairs, desc = "  Toggle autopairs" }
end
maps.n["<leader>ub"] = { ui.toggle_background, desc = "  Toggle background" }
if is_available("nvim-cmp") then
  maps.n["<leader>uc"] = { ui.toggle_cmp, desc = "  Toggle autocompletion" }
end
if is_available("nvim-colorizer.lua") then
  maps.n["<leader>uC"] =
  { "<cmd>ColorizerToggle<cr>", desc = "  Toggle highlighting" }
end
maps.n["<leader>ud"] = { ui.toggle_diagnostics, desc = "Diagnostics" }
maps.n["<leader>uD"] = { ui.set_indent, desc = "Change indent setting" }
maps.n["<leader>ug"] = { ui.toggle_signcolumn, desc = "Signcolumn" }
maps.n["<leader>ul"] = { ui.toggle_statusline, desc = "Statusline" }
maps.n["<leader>un"] = { ui.change_number, desc = "Change line numbering" }
maps.n["<leader>uP"] = { ui.toggle_paste, desc = "Paste mode" }
maps.n["<leader>us"] = { ui.toggle_spell, desc = "Spellcheck" }
maps.n["<leader>uS"] = { ui.toggle_conceal, desc = "Conceal" }
maps.n["<leader>ut"] = { ui.toggle_tabline, desc = "Tabline" }
maps.n["<leader>uu"] = { ui.toggle_url_effect, desc = "URL highlight" }
maps.n["<leader>uw"] = { ui.toggle_wrap, desc = "Wrap" }
maps.n["<leader>uy"] = { ui.toggle_buffer_syntax, desc = "Syntax highlight (buffer)" }
maps.n["<leader>uh"] = { ui.toggle_foldcolumn, desc = "Foldcolumn" }
maps.n["<leader>uN"] =
{ ui.toggle_ui_notifications, desc = "UI notifications" }
if is_available("lsp_signature.nvim") then
  maps.n["<leader>up"] = { ui.toggle_lsp_signature, desc = "LSP signature" }
end

-- TODO: delete mini-animate reference
-- if is_available("mini.animate") then
--   maps.n["<leader>uA"] = { ui.toggle_animations, desc = "Animations" }
-- end

-- shifted movement keys ----------------------------------------------------
maps.n["<S-Down>"] = {
  function() vim.api.nvim_feedkeys("7j", "n", true) end,
  desc = "Fast move down",
}
maps.n["<S-Up>"] = {
  function() vim.api.nvim_feedkeys("7k", "n", true) end,
  desc = "Fast move up",
}
maps.n["<S-PageDown>"] = {
  function()
    local current_line = vim.fn.line "."
    local total_lines = vim.fn.line "$"
    local target_line = current_line + 1 + math.floor(total_lines * 0.20)
    if target_line > total_lines then target_line = total_lines end
    vim.api.nvim_win_set_cursor(0, { target_line, 0 })
    vim.cmd("normal! zz")
  end,
  desc = "Page down exactly a 20% of the total size of the buffer",
}
maps.n["<S-PageUp>"] = {
  function()
    local current_line = vim.fn.line "."
    local target_line = current_line - 1 - math.floor(vim.fn.line "$" * 0.20)
    if target_line < 1 then target_line = 1 end
    vim.api.nvim_win_set_cursor(0, { target_line, 0 })
    vim.cmd("normal! zz")
  end,
  desc = "Page up exactly 20% of the total size of the buffer",
}

-- cmdline autocompletion ---------------------------------------------------
maps.c["<Up>"] = {
  function() return vim.fn.wildmenumode() == 1 and "<Left>" or "<Up>" end,
  noremap = true,
  expr = true,
  desc = "Wildmenu fix for neovim bug #9953",
}
maps.c["<Down>"] = {
  function() return vim.fn.wildmenumode() == 1 and "<Right>" or "<Down>" end,
  noremap = true,
  expr = true,
  desc = "Wildmenu fix for neovim bug #9953",
}
maps.c["<Left>"] = {
  function() return vim.fn.wildmenumode() == 1 and "<Up>" or "<Left>" end,
  noremap = true,
  expr = true,
  desc = "Wildmenu fix for neovim bug #9953",
}
maps.c["<Right>"] = {
  function() return vim.fn.wildmenumode() == 1 and "<Down>" or "<Right>" end,
  noremap = true,
  expr = true,
  desc = "Wildmenu fix for neovim bug #9953",
}

-- special cases ------------------------------------------------------------
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Make q close help, man, quickfix, dap floats",
  callback = function(args)
    local buftype =
        vim.api.nvim_get_option_value("buftype", { buf = args.buf })
    if vim.tbl_contains({ "help", "nofile", "quickfix" }, buftype) then
      vim.keymap.set(
        "n", "q", "<cmd>close<cr>",
        { buffer = args.buf, silent = true, nowait = true }
      )
    end
  end,
})
vim.api.nvim_create_autocmd("CmdwinEnter", {
  desc = "Make q close command history (q: and q?)",
  callback = function(args)
    vim.keymap.set(
      "n", "q", "<cmd>close<cr>",
      { buffer = args.buf, silent = true, nowait = true }
    )
  end,
})

-- -------------------------------------------------------------------------
--
-- ## Plugin bindings
--
-- -------------------------------------------------------------------------

-- alpha-nvim --------------------------------------------------------------
if is_available("alpha-nvim") then
  maps.n["<leader>bh"] = {
    function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      if #wins > 1
          and vim.api.nvim_get_option_value("filetype", { win = wins[1] })
          == "neo-tree"
      then
        vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
      end
      require("alpha").start(false, require("alpha").default_config)
      vim.b.miniindentscope_disable = true
    end,
    desc = "  Go to dashboard",
  }
end

-- [git] -----------------------------------------------------------
-- gitsigns.nvim
maps.n["<leader>g"] = icons.g
if is_available("gitsigns.nvim") then
  maps.n["<leader>g"] = icons.g
  maps.n["]g"] =
  { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
  maps.n["[g"] = {
    function() require("gitsigns").prev_hunk() end,
    desc = "Previous Git hunk",
  }
  maps.n["<leader>gl"] = {
    function() require("gitsigns").blame_line() end,
    desc = "View Git blame",
  }
  maps.n["<leader>gL"] = {
    function() require("gitsigns").blame_line { full = true } end,
    desc = "View full Git blame",
  }
  maps.n["<leader>gp"] = {
    function() require("gitsigns").preview_hunk() end,
    desc = "Preview Git hunk",
  }
  maps.n["<leader>gh"] = {
    function() require("gitsigns").reset_hunk() end,
    desc = "Reset Git hunk",
  }
  maps.n["<leader>gr"] = {
    function() require("gitsigns").reset_buffer() end,
    desc = "Reset Git buffer",
  }
  maps.n["<leader>gs"] = {
    function() require("gitsigns").stage_hunk() end,
    desc = "Stage Git hunk",
  }
  maps.n["<leader>gS"] = {
    function() require("gitsigns").stage_buffer() end,
    desc = "Stage Git buffer",
  }
  maps.n["<leader>gu"] = {
    function() require("gitsigns").undo_stage_hunk() end,
    desc = "Unstage Git hunk",
  }
  maps.n["<leader>gd"] = {
    function() require("gitsigns").diffthis() end,
    desc = "View Git diff",
  }
end
-- git fugitive
if is_available("vim-fugitive") then
  maps.n["<leader>gP"] = {
    function() vim.cmd(":GBrowse") end,
    desc = "Open in github ",
  }
end
-- git client
if vim.fn.executable "lazygit" == 1 then -- if lazygit exists, show it
  maps.n["<leader>gg"] = {
    function()
      local git_dir = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
      if git_dir ~= "" then
        vim.cmd("TermExec cmd='lazygit && exit'")
      else
        utils.notify("Not a git repository", vim.log.levels.WARN)
      end
    end,
    desc = "ToggleTerm lazygit",
  }
end
if vim.fn.executable "gitui" == 1 then -- if gitui exists, show it
  maps.n["<leader>gg"] = {
    function()
      local git_dir = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
      if git_dir ~= "" then
        if vim.fn.executable "keychain" == 1 then
          vim.cmd('TermExec cmd="eval `keychain --eval ~/.ssh/github.key` && gitui && exit"')
        else
          vim.cmd("TermExec cmd='gitui && exit'")
        end
      else
        utils.notify("Not a git repository", vim.log.levels.WARN)
      end
    end,
    desc = "ToggleTerm gitui",
  }
end

-- NOTE: YAZI
if is_available("yazi.nvim") and vim.fn.executable("yazi") == 1 then
  maps.n["<leader>y"] = {
    -- TODO: use 'Yazi toggle' instead once yazi v0.4.0 is released.
    "<cmd>Yazi<CR>",
    desc = "󰇥  Yazi",
  }
end

-- NOTE: NEOTREE
if is_available("neo-tree.nvim") then
  maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "󰙅  Toggle Neotree" }
end

-- NOTE: SESSION MANAGER

maps.n["<leader>s"] = icons.s

if is_available("neovim-session-manager") then
  maps.n["<leader>sl"] = {
    "<cmd>SessionManager! load_last_session<cr>",
    desc = "  Load last session",
  }
  maps.n["<leader>sf"] =
  { "<cmd>SessionManager! load_session<cr>", desc = "  Search sessions" }
  maps.n["<leader>ss"] = {
    "<cmd>SessionManager! save_current_session<cr>",
    desc = "  Save this session",
  }
  maps.n["<leader>s."] = {
    "<cmd>SessionManager! load_current_dir_session<cr>",
    desc = "  Load current directory session",
  }
end

-- if is_available("resession.nvim") then
--   maps.n["<leader>s"] = icons.S
--   maps.n["<leader>sl"] = {
--     function() require("resession").load "Last Session" end,
--     desc = "  Load last session",
--   }
--   maps.n["<leader>ss"] =
--   { function() require("resession").save() end, desc = "  Save this session" }
--   maps.n["<leader>st"] = {
--     function() require("resession").save_tab() end,
--     desc = "  Save this tab's session",
--   }
--   maps.n["<leader>sd"] =
--   { function() require("resession").delete() end, desc = "  Delete a session" }
--   maps.n["<leader>sf"] =
--   { function() require("resession").load() end, desc = "  Load a session" }
--   maps.n["<leader>s."] = {
--     function()
--       require("resession").load(vim.fn.getcwd(), { dir = "dirsession" })
--     end,
--     desc = "  Load current directory session",
--   }
-- end

-- NOTE: AERIAL.NVIM
if is_available("aerial.nvim") then
  maps.n["<leader>i"] =
  { function() require("aerial").toggle() end, desc = "  Toggle Aerial" }
end

-- letee-calltree.nvimm ------------------------------------------------------------
if is_available("litee-calltree.nvim") then
  -- For every buffer, look for the one with filetype "calltree" and focus it.
  local calltree_delay = 1500 -- first run? wait a bit longer.
  local function focus_calltree()
    -- Note: No go to the previous cursor position, press ctrl+i / ctrl+o
    vim.defer_fn(function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })

        if ft == "calltree" then
          vim.api.nvim_set_current_win(win)
          return true
        end
      end
    end, calltree_delay)
    calltree_delay = 100
  end
  maps.n["gj"] = {
    function()
      vim.lsp.buf.incoming_calls()
      focus_calltree()
    end,
    desc = "Call tree (incoming)"
  }
  maps.n["gJ"] =
  {
    function()
      vim.lsp.buf.outgoing_calls()
      focus_calltree()
    end,
    desc = "Call tree (outgoing)"
  }
end

-- telescope.nvim [find] ----------------------------------------------------
if is_available("telescope.nvim") then
  maps.n["<leader>f"] = icons.f
  maps.n["<leader>gb"] = {
    function() require("telescope.builtin").git_branches() end,
    desc = "Git branches",
  }
  maps.n["<leader>gc"] = {
    function()
      require("telescope.builtin").git_commits()
    end,
    desc = "Git commits (repository)"
  }
  maps.n["<leader>gC"] = {
    function()
      require("telescope.builtin").git_bcommits()
    end,
    desc = "Git commits (current file)"
  }
  maps.n["<leader>gt"] = {
    function() require("telescope.builtin").git_status() end,
    desc = "Git status",
  }
  maps.n["<leader>f<cr>"] = {
    function() require("telescope.builtin").resume() end,
    desc = "Resume previous search",
  }
  maps.n["<leader>f'"] = {
    function() require("telescope.builtin").marks() end,
    desc = "Find marks",
  }
  maps.n["<leader>nf"] = {
    function()
      local cwd = vim.fn.stdpath "config" .. "/.."
      local search_dirs = { vim.fn.stdpath "config" }
      if #search_dirs == 1 then cwd = search_dirs[1] end -- if only one directory, focus cwd
      require("telescope.builtin").find_files {
        prompt_title = "Config Files",
        search_dirs = search_dirs,
        cwd = cwd,
        follow = true,
      } -- call telescope
    end,
    desc = "  Find nvim config files",
  }
  maps.n["<leader><leader>"] = {
    function() require("telescope.builtin").buffers() end,
    desc = "  Find buffers",
  }
  maps.n["<leader>fw"] = {
    function() require("telescope.builtin").grep_string() end,
    desc = "Find word under cursor in project",
  }
  maps.n["<leader>nc"] = {
    function() require("telescope.builtin").commands() end,
    desc = "  Find commands",
  }
  -- NOTE: disabled by upstream
  -- Let's disable this. It is way too imprecise. Use rnvimr instead.
  maps.n["<leader>,"] = {
    function()
      require("telescope.builtin").find_files { hidden = true, no_ignore = true }
    end,
    desc = "  Find in all files",
  }
  -- maps.n["<leader>fF"] = {
  --   function() require("telescope.builtin").find_files() end,
  --   desc = "Find files (no hidden)",
  -- }
  maps.n["<leader>nt"] = {
    function() require("telescope.builtin").help_tags() end,
    desc = "  Find help tag",
  }
  maps.n["<leader>nk"] = {
    function() require("telescope.builtin").keymaps() end,
    desc = "  Find keybinding",
  }
  maps.n["<leader>mm"] = {
    function() require("telescope.builtin").man_pages() end,
    desc = "  Find manpage",
  }
  if is_available("nvim-notify") then
    maps.n["<leader>fn"] = {
      function() require("telescope").extensions.notify.notify() end,
      desc = "  Find notifications",
    }
  end
  maps.n["<leader>fo"] = {
    function() require("telescope.builtin").oldfiles() end,
    desc = "  Find recent files",
  }
  maps.n["<leader>fv"] = {
    function() require("telescope.builtin").registers() end,
    desc = "Find vim registers",
  }
  maps.n["<leader>nc"] = {
    function()
      -- load color schemes before listing them
      pcall(vim.api.nvim_command, "doautocmd User LoadColorSchemes")

      -- Open telescope
      pcall(require("telescope.builtin").colorscheme, {
        enable_preview = true,
        ignore_builtins = true
      })
    end,
    desc = "  Find themes",
  }
  maps.n["<leader>ff"] = {
    function()
      require("telescope.builtin").live_grep({
        additional_args = function(args)
          args.additional_args = { "--hidden", "--no-ignore" }
          return args.additional_args
        end,
      })
    end,
    desc = "  Find in project",
  }
  maps.n["<leader>fF"] = {
    function() require("telescope.builtin").live_grep() end,
    desc = "  Find in project (no hidden)",
  }
  maps.n["<leader>z"] = {
    function() require("telescope.builtin").current_buffer_fuzzy_find() end,
    desc = "  Fuzzy find in current buffer",
  }

  -- Some lsp keymappings are here because they depend on telescope
  maps.n["<leader>l"] = icons.l
  maps.n["<leader>ls"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbol in buffer", -- Useful to find every time a variable is assigned.
  }
  maps.n["gs"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbol in buffer", -- Useful to find every time a variable is assigned.
  }

  -- extra - project.nvim
  if is_available("project.nvim") then
    maps.n["<leader>fp"] = {
      function() vim.cmd("Telescope projects") end,
      desc = "Find project",
    }
  end

  -- extra - spectre.nvim (search and replace in project)
  if is_available("nvim-spectre") then
    maps.n["<leader>fr"] = {
      function() require("spectre").toggle() end,
      desc = "Find and replace in project",
    }
    maps.n["<leader>fb"] = {
      function() require("spectre").toggle { path = vim.fn.expand "%:t:p" } end,
      desc = "Find and replace in buffer",
    }
  end

  -- extra - luasnip
  if is_available("LuaSnip") and is_available("telescope-luasnip.nvim") then
    maps.n["<leader>fs"] = {
      function() require("telescope").extensions.luasnip.luasnip {} end,
      desc = "Find snippets",
    }
  end

  -- extra - nvim-neoclip (neovim internal clipboard)
  --         Specially useful if you disable the shared clipboard in options.
  if is_available("nvim-neoclip.lua") then
    maps.n["<leader>fy"] = {
      function() require("telescope").extensions.neoclip.default() end,
      desc = "Find yank history",
    }
    maps.n["<leader>fq"] = {
      function() require("telescope").extensions.macroscope.default() end,
      desc = "Find macro history",
    }
  end

  -- extra - undotree
  if is_available("telescope-undo.nvim") then
    maps.n["<leader>fu"] = {
      function() require("telescope").extensions.undo.undo() end,
      desc = "Find in undo tree",
    }
  end

  -- extra - compiler
  if is_available("compiler.nvim") and is_available("overseer.nvim") then
    maps.n["<leader>m"] = icons.c
    maps.n["<leader>mm"] = {
      function() vim.cmd("CompilerOpen") end,
      desc = "Open compiler",
    }
    maps.n["<leader>mr"] = {
      function() vim.cmd("CompilerRedo") end,
      desc = "Compiler redo",
    }
    maps.n["<leader>mt"] = {
      function() vim.cmd("CompilerToggleResults") end,
      desc = "compiler results",
    }
    maps.n["<F6>"] = {
      function() vim.cmd("CompilerOpen") end,
      desc = "Open compiler",
    }
    maps.n["<S-F6>"] = {
      function() vim.cmd("CompilerRedo") end,
      desc = "Compiler redo",
    }
    maps.n["<S-F7>"] = {
      function() vim.cmd("CompilerToggleResults") end,
      desc = "compiler resume",
    }
  end
end

-- toggleterm.nvim ----------------------------------------------------------
if is_available("toggleterm.nvim") then
  maps.n["<leader>t"] = icons.t
  maps.n["<leader>tt"] =
  { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" }
  maps.n["<leader>th"] = {
    "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
    desc = "Toggleterm horizontal split",
  }
  maps.n["<leader>tv"] = {
    "<cmd>ToggleTerm size=80 direction=vertical<cr>",
    desc = "Toggleterm vertical split",
  }
  maps.n["<F7>"] = { "<cmd>ToggleTerm<cr>", desc = "terminal" }
  maps.t["<F7>"] = maps.n["<F7>"]
  maps.n["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
  maps.t["<C-'>"] = maps.n["<F7>"] -- requires terminal that supports binding <C-'>
end

-- extra - improved terminal navigation
maps.t["<C-h>"] =
{ "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" }
maps.t["<C-j>"] =
{ "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" }
maps.t["<C-k>"] =
{ "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" }
maps.t["<C-l>"] =
{ "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" }


-- dap.nvim [debugger] -----------------------------------------------------
-- Depending your terminal some F keys may not work. To fix it:
-- modified function keys found with `showkey -a` in the terminal to get key code
-- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
if is_available("nvim-dap") then
  maps.n["<leader>d"] = icons.d
  maps.x["<leader>d"] = icons.d

  -- F keys
  maps.n["<F5>"] = {
    function()
      require("dap").continue()
    end,
    desc = "Debugger: Start"
  }
  maps.n["<S-F5>"] =
  { function() require("dap").terminate() end, desc = "Debugger: Stop" }
  maps.n["<C-F5>"] = {
    function() require("dap").restart_frame() end, desc = "Debugger: Restart" }
  maps.n["<F9>"] = {
    function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
  maps.n["<S-F9>"] = {
    function()
      vim.ui.input({ prompt = "Condition: " }, function(condition)
        if condition then require("dap").set_breakpoint(condition) end
      end)
    end,
    desc = "Debugger: Conditional Breakpoint",
  }
  maps.n["<F10>"] =
  { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
  maps.n["<S-F10>"] =
  { function() require("dap").step_back() end, desc = "Debugger: Step Back" }
  maps.n["<F11>"] =
  { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
  maps.n["<S-F11>"] =
  { function() require("dap").step_out() end, desc = "Debugger: Step Out" }

  -- Space + d
  maps.n["<leader>db"] = {
    function() require("dap").toggle_breakpoint() end,
    desc = "Breakpoint (F9)",
  }
  maps.n["<leader>dB"] = {
    function() require("dap").clear_breakpoints() end,
    desc = "Clear Breakpoints",
  }
  maps.n["<leader>dc"] =
  { function() require("dap").continue() end, desc = "Start/Continue (F5)" }
  maps.n["<leader>dC"] = {
    function()
      vim.ui.input({ prompt = "Condition: " }, function(condition)
        if condition then require("dap").set_breakpoint(condition) end
      end)
    end,
    desc = "Conditional Breakpoint (S-F9)",
  }
  maps.n["<leader>do"] =
  { function() require("dap").step_over() end, desc = "Step Over (F10)" }
  maps.n["<leader>do"] =
  { function() require("dap").step_back() end, desc = "Step Back (S-F10)" }
  maps.n["<leader>db"] =
  { function() require("dap").step_into() end, desc = "Step Into (F11)" }
  maps.n["<leader>dO"] =
  { function() require("dap").step_out() end, desc = "Step Out (S-F11)" }
  maps.n["<leader>dq"] =
  { function() require("dap").close() end, desc = "Close Session" }
  maps.n["<leader>dQ"] = {
    function() require("dap").terminate() end,
    desc = "Terminate Session (S-F5)",
  }
  maps.n["<leader>dp"] =
  { function() require("dap").pause() end, desc = "Pause" }
  maps.n["<leader>dr"] =
  { function() require("dap").restart_frame() end, desc = "Restart (C-F5)" }
  maps.n["<leader>dR"] =
  { function() require("dap").repl.toggle() end, desc = "REPL" }
  maps.n["<leader>ds"] =
  { function() require("dap").run_to_cursor() end, desc = "Run To Cursor" }

  if is_available("nvim-dap-ui") then
    maps.n["<leader>dE"] = {
      function()
        vim.ui.input({ prompt = "Expression: " }, function(expr)
          if expr then require("dapui").eval(expr, { enter = true }) end
        end)
      end,
      desc = "Evaluate Input",
    }
    maps.x["<leader>dE"] =
    { function() require("dapui").eval() end, desc = "Evaluate Input" }
    maps.n["<leader>du"] =
    { function() require("dapui").toggle() end, desc = "Debugger UI" }
    maps.n["<leader>dh"] = {
      function() require("dap.ui.widgets").hover() end,
      desc = "Debugger Hover",
    }
  end
end

-- testing [tests] -------------------------------------------------
-- neotest
maps.n["<leader>T"] = icons.tt
maps.x["<leader>T"] = icons.tt
if is_available("neotest") then
  maps.n["<leader>Tu"] = {
    function() require("neotest").run.run() end,
    desc = "Unit",
  }
  maps.n["<leader>Ts"] = {
    function() require("neotest").run.stop() end,
    desc = "Stop unit",
  }
  maps.n["<leader>Tf"] = {
    function() require("neotest").run.run(vim.fn.expand "%") end,
    desc = "File",
  }
  maps.n["<leader>Td"] = {
    function() require("neotest").run.run { strategy = "dap" } end,
    desc = "Unit in debugger",
  }
  maps.n["<leader>Tt"] = {
    function() require("neotest").summary.toggle() end,
    desc = "Neotest summary",
  }
  maps.n["<leader>TT"] = {
    function() require("neotest").output_panel.toggle() end,
    desc = "Output panel",
  }
end

-- Extra - nvim-coverage
--         Your project must generate coverage/lcov.info for this to work.
--
--         On jest, make sure your packages.json file has this:
--         "test": "jest --coverage"
--
--         If you use other framework or language, refer to nvim-coverage docs:
--         https://github.com/andythigpen/nvim-coverage/blob/main/doc/nvim-coverage.txt
if is_available("nvim-coverage") then
  maps.n["<leader>Tc"] = {
    function()
      require("coverage").load(false)
      require("coverage").summary()
    end,
    desc = "Coverage",
  }
  maps.n["<leader>TC"] = {
    function()
      ui.toggle_coverage_signs()
    end,
    desc = "Coverage signs (toggle)",
  }
end

-- Extra - nodejs testing commands
maps.n["<leader>Ta"] = {
  function() vim.cmd("TestNodejs") end,
  desc = "All",
}
maps.n["<leader>Te"] = {
  function() vim.cmd("TestNodejsE2e") end,
  desc = "E2e",
}

-- nvim-ufo [code folding] --------------------------------------------------
if is_available("nvim-ufo") then
  maps.n["zR"] =
  { function() require("ufo").openAllFolds() end, desc = "Open all folds" }
  maps.n["zM"] =
  { function() require("ufo").closeAllFolds() end, desc = "Close all folds" }
  maps.n["zr"] = {
    function() require("ufo").openFoldsExceptKinds() end,
    desc = "Fold less",
  }
  maps.n["zm"] =
  { function() require("ufo").closeFoldsWith() end, desc = "Fold more" }
  maps.n["zp"] = {
    function() require("ufo").peekFoldedLinesUnderCursor() end,
    desc = "Peek fold",
  }
  maps.n["zn"] =
  {
    function() require("ufo").openFoldsExceptKinds({ 'comment' }) end,
    desc = "Fold comments"
  }
  maps.n["zN"] =
  {
    function() require("ufo").openFoldsExceptKinds({ 'region' }) end,
    desc = "Fold region"
  }
end

-- code docmentation [docs] -------------------------------------------------

if is_available("markdown-preview.nvim") or is_available("markmap.nvim") or is_available("dooku.nvim") then
  maps.n["<leader>D"] = icons.dc

  -- Markdown preview
  if is_available("markdown-preview.nvim") then
    maps.n["<leader>Dp"] = {
      function() vim.cmd("MarkdownPreview") end,
      desc = "Markdown preview",
    }
  end

  -- Markdown Mindmap
  if is_available("markmap.nvim") then
    maps.n["<leader>Dm"] = {
      function()
        if is_android then
          vim.cmd("MarkmapWatch")
        else
          vim.cmd("MarkmapOpen")
        end
      end,
      desc = "Markmap",
    }
  end

  if is_available("dooku.nvim") then
    maps.n["<leader>Dd"] = {
      function() vim.cmd(":DookuGenerate") end,
      desc = "Open documentation",
    }
  end
end

-- [neural] -----------------------------------------------------------------
if is_available("neural") or is_available("copilot") then
  maps.n["<F2>"] = {
    function() require("neural").prompt() end,
    desc = "Ask chatgpt",
  }
end

-- TODO: delete hop.nvim reference
-- hop.nvim ----------------------------------------------------------------
-- if is_available("hop.nvim") then
--   -- Note that Even though we are using ENTER for hop, you can still select items
--   -- from special menus like 'quickfix', 'q?' and 'q:' with <C+ENTER>.
--
--   maps.n["<C-m>"] = { -- The terminal undersand C-m and ENTER as the same key.
--     function()
--       require("hop")
--       vim.cmd("silent! HopWord")
--     end,
--     desc = "Hop to word",
--   }
--   maps.x["<C-m>"] = { -- The terminal undersand C-m and ENTER as the same key.
--     function()
--       require("hop")
--       vim.cmd("silent! HopWord")
--     end,
--     desc = "Hop to word",
--   }
-- end

-- mason-lspconfig.nvim [lsp] -------------------------------------------------
-- WARNING: Don't delete this section, or you won't have LSP keymappings.

--A function we call from the script to start lsp.
--@return table lsp_mappings
function M.lsp_mappings(client, bufnr)
  -- Helper function to check if any active LSP clients
  -- given a filter provide a specific capability.
  -- @param capability string The server capability to check for (example: "documentFormattingProvider").
  -- @param filter vim.lsp.get_clients.filter|nil A valid get_clients filter (see function docs).
  -- @return boolean # `true` if any of the clients provide the capability.
  local function has_capability(capability, filter)
    for _, lsp_client in ipairs(vim.lsp.get_clients(filter)) do
      if lsp_client.supports_method(capability) then return true end
    end
    return false
  end

  local lsp_mappings = require("base.utils").get_mappings_template()

  -- Diagnostics
  lsp_mappings.n["<leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
  lsp_mappings.n["[d"] = { function()
      -- TODO: Delete after dropping nvim 0.10 support.
      if vim.fn.has('nvim-0.11') == 1 then vim.diagnostic.jump({ count = -1 })
      else vim.diagnostic.goto_prev() end end, desc = "Previous diagnostic"
  }
  lsp_mappings.n["]d"] = { function()
    -- TODO: Delete after dropping nvim 0.10 support.
    if vim.fn.has('nvim-0.11') == 1 then vim.diagnostic.jump({ count = 1 })
    else vim.diagnostic.goto_next() end end, desc = "Next diagnostic" }

  -- Diagnostics
  lsp_mappings.n["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" }
  if is_available("telescope.nvim") then
    lsp_mappings.n["<leader>lD"] =
      { function() require("telescope.builtin").diagnostics() end, desc = "Diagnostics" }
  end

  -- LSP info
  if is_available("mason-lspconfig.nvim") then
    lsp_mappings.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" }
  end

  if is_available("none-ls.nvim") then
    lsp_mappings.n["<leader>lI"] = { "<cmd>NullLsInfo<cr>", desc = "Null-ls information" }
  end

  -- Code actions
  lsp_mappings.n["<leader>la"] = {
    function() vim.lsp.buf.code_action() end,
    desc = "LSP code action",
  }
  lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]

  -- Codelens
  utils.add_autocmds_to_buffer("lsp_codelens_refresh", bufnr, {
    events = { "InsertLeave" },
    desc = "Refresh codelens",
    callback = function(args)
      if client.supports_method "textDocument/codeLens" then
        if vim.g.codelens_enabled then vim.lsp.codelens.refresh({ bufnr = args.buf }) end
      end
    end,
  })
  if client.supports_method "textDocument/codeLens" then -- on LspAttach
    if vim.g.codelens_enabled then vim.lsp.codelens.refresh({ bufnr = 0 }) end
  end

  lsp_mappings.n["<leader>ll"] = {
    function()
      vim.lsp.codelens.run()
      vim.lsp.codelens.refresh({ bufnr = 0 })
    end,
    desc = "LSP CodeLens run",
  }
  lsp_mappings.n["<leader>uL"] = {
    function() ui.toggle_codelens() end,
    desc = "CodeLens",
  }

  -- Formatting (keymapping)
  local formatting = require("base.utils.lsp").formatting
  local format_opts = require("base.utils.lsp").format_opts
  lsp_mappings.n["<leader>lf"] = {
    function()
      vim.lsp.buf.format(format_opts)
      vim.cmd("checktime") -- Sync buffer with changes
    end,
    desc = "Format buffer",
  }
  lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]

  -- Formatting (command)
  vim.api.nvim_buf_create_user_command(
    bufnr,
    "Format",
    function() vim.lsp.buf.format(format_opts) end,
    { desc = "Format file with LSP" }
  )

  -- Autoformatting (autocmd)
  local autoformat = formatting.format_on_save
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

  -- guard clauses
  local is_autoformat_enabled = autoformat.enabled
  local is_filetype_allowed = vim.tbl_isempty(autoformat.allow_filetypes or {})
      or vim.tbl_contains(autoformat.allow_filetypes, filetype)
  local is_filetype_ignored = vim.tbl_isempty(
    autoformat.ignore_filetypes or {}
  ) or not vim.tbl_contains(autoformat.ignore_filetypes, filetype)

if is_autoformat_enabled and is_filetype_allowed and is_filetype_ignored then
    utils.add_autocmds_to_buffer("lsp_auto_format", bufnr, {
      events = "BufWritePre", -- Trigger before save
      desc = "Autoformat on save",
      callback = function()
        -- guard clause: has_capability
        if
            not has_capability("textDocument/formatting", { bufnr = bufnr })
        then
          utils.del_autocmds_from_buffer("lsp_auto_format", bufnr)
          return
        end

        -- Get autoformat setting (buffer or global)
        local autoformat_enabled = vim.b.autoformat_enabled
            or vim.g.autoformat_enabled
        local has_no_filter = not autoformat.filter
        local passes_filter = autoformat.filter and autoformat.filter(bufnr)

        -- Use these variables in the if condition
        if autoformat_enabled and (has_no_filter or passes_filter) then
          vim.lsp.buf.format(
            vim.tbl_deep_extend("force", format_opts, { bufnr = bufnr })
          )
        end
      end,
    })

    -- Key mappings for toggling autoformat (buffer/global)
    lsp_mappings.n["<leader>uf"] = {
      function() require("base.utils.ui").toggle_buffer_autoformat() end,
      desc = "Toggle buffer autoformat",
    }
    lsp_mappings.n["<leader>uF"] = {
      function() require("base.utils.ui").toggle_autoformat() end,
      desc = "Toggle global autoformat",
    }
  end

  -- Highlight references when cursor holds
  utils.add_autocmds_to_buffer("lsp_document_highlight", bufnr, {
    {
      events = { "CursorHold", "CursorHoldI" },
      desc = "highlight references when cursor holds",
      callback = function()
        if has_capability("textDocument/documentHighlight", { bufnr = bufnr }) then
          vim.lsp.buf.document_highlight()
        end
      end,
    },
    {
      events = { "CursorMoved", "CursorMovedI", "BufLeave" },
      desc = "clear references when cursor moves",
      callback = function() vim.lsp.buf.clear_references() end,
    },
  })

  -- Other LSP mappings
  lsp_mappings.n["<leader>lL"] = {
    function() vim.api.nvim_command(':LspRestart') end,
    desc = "LSP refresh",
  }

  -- Goto definition / declaration
  lsp_mappings.n["gd"] = {
    function() vim.lsp.buf.definition() end,
    desc = "Goto definition of current symbol",
  }
  lsp_mappings.n["gD"] = {
    function() vim.lsp.buf.declaration() end,
    desc = "Goto declaration of current symbol",
  }

  -- Goto implementation
  lsp_mappings.n["gI"] = {
    function() vim.lsp.buf.implementation() end,
    desc = "Goto implementation of current symbol",
  }

  -- Goto type definition
  lsp_mappings.n["gT"] = {
    function() vim.lsp.buf.type_definition() end,
    desc = "Goto definition of current type",
  }

  -- Goto references
  lsp_mappings.n["<leader>lR"] = {
    function() vim.lsp.buf.references() end,
    desc = "Hover references",
  }
  lsp_mappings.n["gr"] = {
    function() vim.lsp.buf.references() end,
    desc = "References of current symbol",
  }

  -- Goto help
  lsp_mappings.n["gh"] = {
    function() vim.lsp.buf.hover() end,
    desc = "Hover help",
  }
  lsp_mappings.n["gH"] = {
    function() vim.lsp.buf.signature_help() end,
    desc = "Signature help",
  }

  lsp_mappings.n["<leader>lh"] = {
    function() vim.lsp.buf.hover() end,
    desc = "Hover help",
  }
  lsp_mappings.n["<leader>lH"] = {
    function() vim.lsp.buf.signature_help() end,
    desc = "Signature help",
  }

  -- Goto man
  lsp_mappings.n["gm"] = {
    function() vim.api.nvim_feedkeys("K", "n", false) end,
    desc = "Hover man",
  }
  lsp_mappings.n["<leader>lm"] = {
    function() vim.api.nvim_feedkeys("K", "n", false) end,
    desc = "Hover man",
  }

  -- Rename symbol
  lsp_mappings.n["<leader>lr"] = {
    function() vim.lsp.buf.rename() end,
    desc = "Rename current symbol",
  }

  -- Toggle inlay hints
  if vim.b.inlay_hints_enabled == nil then vim.b.inlay_hints_enabled = vim.g.inlay_hints_enabled end
  if vim.b.inlay_hints_enabled then vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end
  lsp_mappings.n["<leader>uH"] = {
    function() require("base.utils.ui").toggle_buffer_inlay_hints(bufnr) end,
    desc = "LSP inlay hints (buffer)",
  }

  -- Toggle semantic tokens
  if vim.g.semantic_tokens_enabled then
    vim.b[bufnr].semantic_tokens_enabled = true
    lsp_mappings.n["<leader>uY"] = {
      function() require("base.utils.ui").toggle_buffer_semantic_tokens(bufnr) end,
      desc = "LSP semantic highlight (buffer)",
    }
  else
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- LSP based search
  lsp_mappings.n["<leader>lS"] = { function() vim.lsp.buf.workspace_symbol() end, desc = "Search symbol in workspace" }
  lsp_mappings.n["gS"] = { function() vim.lsp.buf.workspace_symbol() end, desc = "Search symbol in workspace" }

  -- LSP telescope
  if is_available("telescope.nvim") then -- setup telescope mappings if available
    if lsp_mappings.n.gd then lsp_mappings.n.gd[1] = function() require("telescope.builtin").lsp_definitions() end end
    if lsp_mappings.n.gI then
      lsp_mappings.n.gI[1] = function() require("telescope.builtin").lsp_implementations() end
    end
    if lsp_mappings.n.gr then lsp_mappings.n.gr[1] = function() require("telescope.builtin").lsp_references() end end
    if lsp_mappings.n["<leader>lR"] then
      lsp_mappings.n["<leader>lR"][1] = function() require("telescope.builtin").lsp_references() end
    end
    if lsp_mappings.n.gy then
      lsp_mappings.n.gy[1] = function() require("telescope.builtin").lsp_type_definitions() end
    end
    if lsp_mappings.n["<leader>lS"] then
      lsp_mappings.n["<leader>lS"][1] = function()
        vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
          if query then
            -- word under cursor if given query is empty
            if query == "" then query = vim.fn.expand "<cword>" end
            require("telescope.builtin").lsp_workspace_symbols {
              query = query,
              prompt_title = ("Find word (%s)"):format(query),
            }
          end
        end)
      end
    end
    if lsp_mappings.n["gS"] then
      lsp_mappings.n["gS"][1] = function()
        vim.ui.input({ prompt = "Symbol Query: (leave empty for word under cursor)" }, function(query)
          if query then
            -- word under cursor if given query is empty
            if query == "" then query = vim.fn.expand "<cword>" end
            require("telescope.builtin").lsp_workspace_symbols {
              query = query,
              prompt_title = ("Find word (%s)"):format(query),
            }
          end
        end)
      end
    end
  end

  return lsp_mappings
end

-- NOTE: ACTIONS
maps.n["<leader>a"] = icons.a
maps.v["<leader>as"] =  { "<cmd>sort<cr>", desc = "  Sort selection range" }
maps.n["<leader>ad"] = icons.ad
maps.n["<leader>adb"] = { "<cmd>g /^$/d<cr>", desc = "  Delete all the blank lines" }

-- TODO:
-- maps.n["gx"] =
-- { utils.open_with_program, desc = "Open the file under cursor with a program" }

-- HACK: doesn't save the file and return to normal mode
-- maps.n["<leader>adr"] = { ':call feedkeys("ggVGdi")<cr>:w<cr><esc>', { noremap = true, noremap = true, silent = true, desc = 'Reset the buffer content and edit' } }

-- TODO: refactor to functions
-- Remove duplicate lines in a file
function remove_duplicates()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local seen = {}
  local new_lines = {}
  for _, line in ipairs(lines) do
    if not seen[line] then
      table.insert(new_lines, line)
      seen[line] = true
    end
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
end

-- Remove duplicate lines in a file
vim.api.nvim_set_keymap('n', '<leader>add', ':lua remove_duplicates()<cr>',
  { noremap = true, silent = true, desc = '  Remove duplicate lines' })

-- Function to cut lines containing a specific word, save them to the
-- clipboard, remove only the created blank lines, and notify
function CutLinesAndRemoveCreatedBlanks()
  local word = vim.fn.input("Enter the word: ")
  local lines_to_cut = {}
  local lines_to_remove = {}

  -- Find lines containing the word and mark them for removal
  for i = 1, vim.fn.line('$') do
      local line = vim.fn.getline(i)
      if line:find(word) then
          table.insert(lines_to_cut, line)
          table.insert(lines_to_remove, i)
      end
  end

  -- Remove marked lines
  for i = #lines_to_remove, 1, -1 do
      vim.fn.setline(lines_to_remove[i], "")
  end

  -- Remove only the blank lines created by the cut operation
  for i = vim.fn.line('$'), 1, -1 do
      if vim.fn.getline(i) == "" and i == lines_to_remove[#lines_to_remove] then
          vim.fn.deletebufline('%', i)
          table.remove(lines_to_remove)
      end
  end

  -- Join lines with newline character and save to clipboard
  local text = table.concat(lines_to_cut, "\n")
  vim.fn.setreg('+', text)

  -- Notify how many lines were cut
  notify(#lines_to_cut .. " lines were cut and saved to the clipboard", "info")
end

-- Function to cut lines containing a specific word, save them to the clipboard, remove all blank lines in the file, and notify
function CutLinesAndRemoveAllBlanks()
    local word = vim.fn.input("Enter the word: ")
    local lines_to_cut = {}
    local total_lines = vim.fn.line('$')

    -- Find lines containing the word and mark them for removal
    for i = 1, total_lines do
        local line = vim.fn.getline(i)
        if line:find(word) then
            table.insert(lines_to_cut, line)
            vim.fn.setline(i, "")
        end
    end

    -- Remove all blank lines
    for i = total_lines, 1, -1 do
        local line = vim.fn.getline(i)
        if line == "" then
            vim.fn.deletebufline('%', i)
        end
    end

    -- Join lines with newline character and save to clipboard
    local text = table.concat(lines_to_cut, "\n")
    vim.fn.setreg('+', text)

    -- Notify how many lines were cut
    notify(#lines_to_cut .. " lines were cut and saved to the clipboard", "info")
end

-- Create the custom commands
vim.api.nvim_create_user_command('CutLinesCreatedBlanks', function()
    CutLinesAndRemoveCreatedBlanks()
end, { nargs = 0 })

vim.api.nvim_create_user_command('CutLinesAllBlanks', function()
    CutLinesAndRemoveAllBlanks()
end, { nargs = 0 })

-- Set up the keybindings
vim.api.nvim_set_keymap('n', '<leader>ab', ':CutLinesAllBlanks<cr>', {
  desc = "  Cut lines with specific regex (purge blanks)",
  noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ar', ':CutLinesCreatedBlanks<cr>',
  { desc = "  Cut lines with specific regex",
    noremap = true, silent = true })

-- NOTE: NEOVIM
maps.n["<leader>n"] = icons.n

-- NOTE: INSERT
maps.n["<leader>i"] = icons.i

-- TODO: refactor to functions
-- Function to insert a code block at the cursor position, position the cursor, and enter insert mode
function InsertCodeBlock()
    local code_block = {
        "``` shell",
        "",
        "```",
    }
    -- Insert code block at the cursor position
    vim.api.nvim_put(code_block, 'c', true, true)
    -- Move the cursor to the middle line of the code block
    local row = vim.fn.line('.')
    vim.api.nvim_win_set_cursor(0, {row - 1, 5})  -- Adjust the cursor to be inside the code block
    -- Enter insert mode
    vim.cmd('startinsert')
end

-- Create the custom command
vim.api.nvim_create_user_command('InsertCodeBlock', function()
    InsertCodeBlock()
end, { nargs = 0 })

-- Set up the keybinding
vim.api.nvim_set_keymap('n', '<leader>is', ':InsertCodeBlock<CR>', {
  desc = "  Insert shell block",
  noremap = true, silent = true })


-- TODO: move to functions
-- TEST:
-- Function to open a Markdown file and jump to a specific section
function OpenMarkdownSection()
    -- Get the line under the cursor
    local line = vim.fn.getline('.')
    -- Extract the file path and anchor from the link
    local file, anchor = line:match('%[.-%]%((.-)#(.-)%)')

    -- Handle case where only file path is provided (no anchor)
    if not file then
        file = line:match('%[.-%]%((.-)%)')
    end

    if file then
        -- Resolve the file path relative to the current file's directory
        local current_file = vim.fn.expand('%:p')
        local current_dir = vim.fn.fnamemodify(current_file, ':h')
        local full_path = vim.fn.fnamemodify(current_dir .. '/' .. file, ':p')

        -- Check if the file is already open in a buffer
        local buf_exists = false
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_get_name(buf) == full_path then
                vim.api.nvim_set_current_buf(buf)
                buf_exists = true
                break
            end
        end

        if not buf_exists then
            -- Open the file if it's not already open
            vim.cmd('edit ' .. full_path)
        end

        if anchor then
            -- Use a precise search pattern for the anchor
            local search_pattern = '\\V##\\s' .. anchor:gsub('%-', ' ')

            -- Go to the start of the file before searching
            vim.cmd('normal! gg')

            -- Search for the anchor heading in the file
            local found = vim.fn.search(search_pattern, 'W')

            if found == 0 then
                -- Attempt to search with case insensitivity as a fallback
                local insensitive_search_pattern = '\\c##\\s' .. anchor:gsub('%-', ' '):lower()
                found = vim.fn.search(insensitive_search_pattern, 'W')

                if found == 0 then
                    vim.api.nvim_err_writeln("Section not found: " .. anchor)
                end
            end
        end
    else
        vim.api.nvim_err_writeln("No file link found at the cursor position")
    end
end

-- Create the custom command
vim.api.nvim_create_user_command('OpenMarkdownSection', function()
    OpenMarkdownSection()
end, { nargs = 0 })

-- Set up the keybinding
vim.api.nvim_set_keymap('n', 'gf', ':OpenMarkdownSection<CR>', { noremap = true, silent = true })
-- TEST:



-- NOTE: IMPORT MAPPINGS
utils.set_mappings(maps)
return M
