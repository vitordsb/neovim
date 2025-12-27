-- Enable filetype detection, plugins and indentation
vim.cmd [[filetype plugin indent on]]

local o = vim.opt

-- Line numbers
o.number = true                      -- show the absolute line number for the current line
o.relativenumber = true              -- show relative line numbers for other lines

-- Cursor and indentation
o.cursorline = true                  -- highlight the line the cursor is on
o.expandtab = true                   -- convert tabs to spaces
o.shiftwidth = 2                     -- number of spaces to use for each step of (auto)indent
o.softtabstop = 2                    -- number of spaces a <Tab> counts for while performing editing operations
o.tabstop = 2                        -- number of spaces that a <Tab> in the file counts for

-- Search behavior
o.ignorecase = true                  -- ignore case when searching...
o.smartcase = true                   -- ...unless the pattern contains uppercase characters

-- File encoding
o.fileencoding = 'utf-8'

-- User interface
o.mouse = 'a'                        -- enable mouse support in all modes
o.hlsearch = true                    -- highlight search matches
o.incsearch = true                   -- show search matches as you type
o.swapfile = false                   -- disable swap files
o.backup = false                     -- disable backup files
o.undofile = true                    -- enable persistent undo history
o.wrap = true                        -- wrap long lines at word boundaries
o.linebreak = true                   -- wrap lines at convenient points
o.termguicolors = true               -- enable true colour support
o.breakindentopt = 'shift:2,min:20'  -- how far wrapped lines should be indented
o.cmdheight = 0                      -- reduce the space of the command line when not needed
o.breakindent = true                 -- wrapped lines should continue visually indented
o.lazyredraw = true                  -- do not redraw while executing macros
o.synmaxcol = 250                    -- do not syntax highlight lines after this column
o.hidden = true                      -- allow switching buffers without saving
o.equalalways = false                -- do not automatically resize windows when splitting
o.scrolloff = 20                      -- keep 20 lines visible above/below the cursor
o.backupskip = '/tmp/*,/private/tmp/*' -- never create backup files in temp dirs
o.laststatus = 3                     -- global statusline (1 hides it, 3 shows one for all windows)
o.updatetime = 200                   -- faster completion & swap file updates
o.clipboard = 'unnamedplus'          -- use the system clipboard
o.completeopt = 'menu,menuone,noselect' -- better completion experience
o.virtualedit = 'block'              -- allow virtual block selection over nothing
o.fillchars = 'eob: '                -- don't display ~ on empty lines

-- Remove automatic comment insertion on new lines
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})
