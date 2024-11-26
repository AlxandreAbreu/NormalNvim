-- ### Icons

-- DESCRIPTION:
-- Here you can change the icons displayed in NormalNvim.
--
-- If you can't see the default icons:
-- Install nerd fonts and set it as your term font: https://www.nerdfonts.com/

--    Sections:
--      -> which-key
--      -> heirline-components (tabline)
--      -> heirline-components (winbar)
--      -> heirline-components (statuscolumn)
--      -> heirline-components (statusline)
--      -> heirline-components (misc)
--      -> Neotree
--      -> Git
--      -> DAP
--      -> Telescope
--      -> Nvim-lightbulb
--      -> Alpha
--      -> Mason
--      -> Render-markdown

return {

  -- NOTE: WHICH-KEY

  Action = "󰮯 ",
  Buffer = " ",
  Compiler = " ",
  Debugger = " ",
  Docs = " ",
  Find = " ",
  Git = " ",
  Insert = " ",
  LSP = " ", -- 
  Neovim = " ",
  Packages = " ",
  Run = " ", -- 󰑮
  Scratchpads = " ",
  Session = " ",
  Sort = " ", -- 󰒺
  Terminal = " ",
  Test = " ", -- 󰙨
  UI = " ", --  

  -- Heirline-components - tabline
  BufferClose = "󰅖",
  FileModified = "",
  FileReadOnly = "",
  ArrowLeft = "",
  ArrowRight = "",
  TabClose = "󰅙",

  -- Heirline-components - winbar
  CompilerPlay = "",
  CompilerStop = "",
  CompilerRedo = "",
  NeoTree = "",
  Aerial = "" ,
  ZenMode = "󰰶",
  BufWrite = "",
  BufWriteAll = "",
  Ellipsis = "…",
  BreadcrumbSeparator = "",

  -- Heirline-components - statuscolumn
  FoldClosed = "",
  FoldOpened = "",
  FoldSeparator = " ",

  -- Heirline-components - statusline
  ActiveLSP = "",
  ActiveTS = "",
  Environment = "",
  DiagnosticError = "",
  DiagnosticHint = "󰌵",
  DiagnosticInfo = "󰋼",
  DiagnosticWarn = "",
  LSPLoading1 = "",
  LSPLoading2 = "󰀚",
  LSPLoading3 = "",
  SearchCount = "",
  MacroRecording = "",
  ToggleResults = "󰑮",

  -- Heirline-components - misc
  Paste = "󰅌",
  PathSeparator = "",

  -- Neotree
  FolderClosed = "",
  FolderEmpty = "",
  FolderOpen = "",
  Diagnostic = "󰒡",
  DefaultFile = "󰈙",

  -- Git
  GitBranch = "",
  GitAdd = "",
  GitChange = "",
  GitDelete = "",
  GitConflict = "",
  GitIgnored = "◌",
  GitRenamed = "➜",
  GitSign = "▎",
  GitStaged = "✓",
  GitUnstaged = "✗",
  GitUntracked = "★",

  -- DAP
  DapBreakpoint = "",
  DapBreakpointCondition = "",
  DapBreakpointRejected = "",
  DapLogPoint = ".>",
  DapStopped = "󰁕",

  -- Telescope
  PromptPrefix = "❯",

  -- Nvim-lightbulb
  Lightbulb = "💡",

  -- Alpha
  GreeterNew = "📄",
  GreeterRecent = "🌺",
  GreeterYazi = "🦆",
  GreeterSessions = "🔎",
  GreeterProjects = "💼",
  GreeterPlug = "",

  -- Mason
  MasonInstalled = "✓",
  MasonUninstalled = "✗",
  MasonPending = "⟳",

  -- Render-markdown
  RenderMarkdown = { ' ', ' ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },

  -- Custom
  Delete = " ",
  Markdown = " ",
}

-- NOTE: START

-- TODO: icons NormalNivm
-- https://github.com/NormalNvim/NormalNvim/blob/main/lua/base/icons/icons.lua

-- NOTE: see pommodoro video, icon = '󰅶' 󰍡 󰈸 󰽥 󱄅  󰇮
--  󰖟 󰷐 󰌠 󰴭 󰓻 󰌌 󰗀  󰡨 󰌷 󰃤 󰀫 󰜎 
-- 󰀠 󰀚 󰀦 󰢚 󰀫 󰀬 󰗗 󰀯 󰗘 󰳨 󰵈 󰮬 󰎑
-- 󱆃 󰂵 󰚑 󰧑 󰃢 󰃣 󰳳 󰗝 󰻝  󰘸 󰝴 󰞷
-- 󰎠 󰚤 󰟢 󰐥 󰐪 󰿘 󰚧 󰐰 󰐟
-- 󰐼 󰢎 󰑴 󰒲 󰚌 󰒺 󰓆 󰣀 󰓙 󱔁
-- 󰓹
-- 󰜺 󰣖 󰙀 󰆍 󰨾 󱃘 󰆙 󰓹 󱈸 󰈉 󰛐
-- 󰭎 󰓾 󰔌 󰦨 󱎫
-- move to: 󱁥
-- compare: 󰆊
-- 󰆕 󰆣 󰙴 󰆞 󰆴 󰇂 󰾰
-- 󰱣 󰗮 󱡷
--  󰤖 󰸆  󱊕 󱊖 󱊗 󱊘 󱊙 󱗃

-- NOTE: NVIM-WEB-DEVICONS
-- Run :NvimWebDeviconsHiTest to see all icons and their highlighting

-- NOTE: BIGGER ICONS
-- 󰸞 󰪛 󱎸 󰽤  ●󰕛 󰕜 󰉋 󱔢   󰎔  ?
-- 󰺮     
--   󰠥   
--      
--             
--        
--         
--                
--              
--        
--  
--    
-- 󱋣 󰲂 󰉋 󰚝 󱍓  󰖷 󰟵 󱩼 󰻲 󰟀 󰭟 󰋊 󰷐 󰐪
--        󰣉 󰙏
--      
-- 󰇗 󰽉 󰇚 󰇮 󰺢 󰇾 󰥣 󰈇 󰈈 󰈊 󰈊 󰈲 
-- 󰵲 󰊓 󰊢 󰋦 󰠬 󰌌 󰌨 󰌷 󰌽 󰌵      
-- 󰕒      󰀡 󰜎
-- 󰇮 󰆼 󰁯 󰘨  󰦪 󰛖          
--             󰡰    
--             
--             
--                 
--           
--            󰒓
--        󰏪       
--            
--             
--           
--           
--           
--          
--        
--      󰘨
-- NOTE:
-- actions:
--   󰮯 󰑮            
--          
--            
--               
--              
--           
--          
-- ai:    
-- insert: 
-- regex:   
-- zen: 
-- delete:   
-- alert:     󱡝 
-- arrow:                   󰊍  
-- buffers:     󰊠     󰕮    
-- checkhealth:       󱖫 󰩂 󰿶 
-- colorschemes:   
-- commands:       
-- comments:     󱐐 󱜸 󱐑 󱋑 󱐏 󰭺 󰻞   󰗞 󰠗 󱗡 󰆈 󰨺 󱗟 󰧥 󱖰
-- compiler: 
-- config:     
-- dashboard:
-- toggle:      
-- database:
-- debug: 
-- directory:  󰇖
-- docs:       󰓫      
-- files:  󱞞    
-- find:    
-- flash:    
-- fzf: 󱡠
-- git:   󰊢  󰽜 
-- harpoon: 󱡀
-- highlights: 
-- lazy: 󰒲 󰒳
-- logos:               
-- lsp:     
-- macros: 󰮯  
-- mason:   󱌢
-- motion: 󱖲
-- mouse:  -> hardline plugin
-- neotree: 
-- notifications:   
-- packages:  
-- pomodoro:      
-- power: ⏻
-- prefixer: 
-- project: 󰐱 diagram    sitemap:  certificate: 
-- save: 󰆔  󰉉 󰆓  󰘛
-- scratchpads: 
-- session/quit:     
-- sniper:  󰣉
-- sort:           󰒼 󰒽 󰒿 
-- split: 󰤻 󰤼
-- sudo:          
-- tabs: 
-- tailwind: 󱏿
-- telescope: 󰭎  
-- test    
-- translate: 󰗊 
-- treesitter:  
-- trouble: 󰙅
-- vanish: 󰟼        󰀸 󱓽
-- virus: 󱎶  
-- window:        󰘖 󰘕 󰨤 󰁁 󰁨  󰴣 󰴤 󰕮    
-- yank:   
-- 󰙬 󱈓 󰙮 󰧻 󰃉

-- TODO: https://github.com/LunarVim/Launch.nvim/blob/master/lua/user/icons.lua
-- return {
--   kind = {
--     Array = " ",
--     Boolean = " ",
--     Class = " ",
--     Color = " ",
--     Constant = " ",
--     Constructor = " ",
--     Enum = " ",
--     EnumMember = " ",
--     Event = " ",
--     Field = " ",
--     File = " ",
--     Folder = "󰉋 ",
--     Function = " ",
--     Interface = " ",
--     Key = " ",
--     Keyword = " ",
--     Method = " ",
--     -- Module = " ",
--     Module = " ",
--     Namespace = " ",
--     Null = "󰟢 ",
--     Number = " ",
--     Object = " ",
--     Operator = " ",
--     Package = " ",
--     Property = " ",
--     Reference = " ",
--     Snippet = " ",
--     String = " ",
--     Struct = " ",
--     Text = " ",
--     TypeParameter = " ",
--     Unit = " ",
--     Value = " ",
--     Variable = " ",
--   },
--   git = {
--     LineAdded = " ",
--     LineModified = " ",
--     LineRemoved = " ",
--     FileDeleted = " ",
--     FileIgnored = "◌",
--     FileRenamed = " ",
--     FileStaged = "S",
--     FileUnmerged = "",
--     FileUnstaged = "",
--     FileUntracked = "U",
--     Diff = " ",
--     Repo = " ",
--     Octoface = " ",
--     Copilot = " ",
--     Branch = "",
--   },
--   ui = {
--     ArrowCircleDown = "",
--     ArrowCircleLeft = "",
--     ArrowCircleRight = "",
--     ArrowCircleUp = "",
--     BoldArrowDown = "",
--     BoldArrowLeft = "",
--     BoldArrowRight = "",
--     BoldArrowUp = "",
--     BoldClose = "",
--     BoldDividerLeft = "",
--     BoldDividerRight = "",
--     BoldLineLeft = "▎",
--     BoldLineMiddle = "┃",
--     BoldLineDashedMiddle = "┋",
--     BookMark = "",
--     BoxChecked = " ",
--     Bug = " ",
--     Stacks = "",
--     Scopes = "",
--     Watches = "󰂥",
--     DebugConsole = " ",
--     Calendar = " ",
--     Check = "",
--     ChevronRight = "",
--     ChevronShortDown = "",
--     ChevronShortLeft = "",
--     ChevronShortRight = "",
--     ChevronShortUp = "",
--     Circle = " ",
--     Close = "󰅖",
--     CloudDownload = " ",
--     Code = "",
--     Comment = "",
--     Dashboard = "",
--     DividerLeft = "",
--     DividerRight = "",
--     DoubleChevronRight = "»",
--     Ellipsis = "",
--     EmptyFolder = " ",
--     EmptyFolderOpen = " ",
--     File = " ",
--     FileSymlink = "",
--     Files = " ",
--     FindFile = "󰈞",
--     FindText = "󰊄",
--     Fire = "",
--     Folder = "󰉋 ",
--     FolderOpen = " ",
--     FolderSymlink = " ",
--     Forward = " ",
--     Gear = " ",
--     History = " ",
--     Lightbulb = " ",
--     LineLeft = "▏",
--     LineMiddle = "│",
--     List = " ",
--     Lock = " ",
--     NewFile = " ",
--     Note = " ",
--     Package = " ",
--     Pencil = "󰏫 ",
--     Plus = " ",
--     Project = " ",
--     Search = " ",
--     SignIn = " ",
--     SignOut = " ",
--     Tab = "󰌒 ",
--     Table = " ",
--     Target = "󰀘 ",
--     Telescope = " ",
--     Text = " ",
--     Tree = "",
--     Triangle = "󰐊",
--     TriangleShortArrowDown = "",
--     TriangleShortArrowLeft = "",
--     TriangleShortArrowRight = "",
--     TriangleShortArrowUp = "",
--   },
--   diagnostics = {
--     BoldError = "",
--     Error = "",
--     BoldWarning = "",
--     Warning = "",
--     BoldInformation = "",
--     Information = "",
--     BoldQuestion = "",
--     Question = "",
--     BoldHint = "",
--     Hint = "󰌶",
--     Debug = "",
--     Trace = "✎",
--   },
--   misc = {
--     Robot = "󰚩 ",
--     Squirrel = " ",
--     Tag = " ",
--     Watch = "",
--     Smiley = " ",
--     Package = " ",
--     CircuitBoard = " ",
--   },
-- }

