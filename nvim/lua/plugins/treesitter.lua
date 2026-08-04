-- Parsers installed on startup. Anything else is installed on demand by the
-- FileType handler below, so this only needs to cover what should be ready
-- before it is asked for.
local baseline = {
  "bash",
  "c",
  "cpp",
  "diff",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "json",
  "latex",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "toml",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

--- Enable treesitter highlighting, folds and indenting for a buffer.
--- Idempotent, and safe to call on a buffer with no parser.
---@param buf integer
local function attach(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  local ft = vim.bo[buf].filetype
  local lang = ft ~= "" and vim.treesitter.language.get_lang(ft) or nil
  if not lang or not vim.treesitter.language.add(lang) then
    return
  end
  if not pcall(vim.treesitter.start, buf, lang) then
    return
  end

  -- not every language ships an indents query
  if vim.treesitter.query.get(lang, "indents") then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end

  -- 'foldexpr' is window-local; the [0][0] form scopes it to this buffer so it
  -- does not leak to the next buffer shown in this window
  if buf == vim.api.nvim_get_current_buf() then
    vim.wo[0][0].foldmethod = "expr"
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end

  -- treesitter-backed mini.ai textobjects, only where a parser exists, so the
  -- pattern-based builtins keep working everywhere else
  if package.loaded["mini.ai"] then
    local spec = require("mini.ai").gen_spec.treesitter
    vim.b[buf].miniai_config = {
      custom_textobjects = {
        f = spec { a = "@function.outer", i = "@function.inner" },
        F = spec { a = "@call.outer", i = "@call.inner" },
        c = spec { a = "@class.outer", i = "@class.inner" },
        o = spec {
          a = { "@conditional.outer", "@loop.outer" },
          i = { "@conditional.inner", "@loop.inner" },
        },
        s = spec { a = "@block.outer", i = "@block.inner" },
      },
    }
  end
end

--- Retry every loaded buffer, for use after parsers land mid-session.
local function attach_loaded()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      attach(buf)
    end
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- Upstream does not support lazy-loading: plugin/filetypes.lua registers the
    -- filetype aliases (tex -> latex, jsonc -> json, sh -> bash) that the
    -- FileType handler relies on.
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        -- lazy runs a dependency's config exactly once, which is where these
        -- global keymaps belong. Selection is handled by mini.ai, so only the
        -- swap and move modules are used here.
        config = function()
          require("nvim-treesitter-textobjects").setup {
            move = { set_jumps = true },
          }

          local swap = require "nvim-treesitter-textobjects.swap"
          local move = require "nvim-treesitter-textobjects.move"

          vim.keymap.set("n", "<leader>.", function()
            swap.swap_next "@parameter.inner"
          end, { desc = "Swap parameter with next" })
          vim.keymap.set("n", "<leader>,", function()
            swap.swap_previous "@parameter.inner"
          end, { desc = "Swap parameter with previous" })

          -- Vim's own ]m/[m (method) and ]]/[[ (section) semantics, made to
          -- actually work. ]c/[c are left to gitsigns.
          local motions = {
            { "]m", move.goto_next_start, "@function.outer", "Next function" },
            { "[m", move.goto_previous_start, "@function.outer", "Previous function" },
            { "]M", move.goto_next_end, "@function.outer", "Next function end" },
            { "[M", move.goto_previous_end, "@function.outer", "Previous function end" },
            { "]]", move.goto_next_start, "@class.outer", "Next class" },
            { "[[", move.goto_previous_start, "@class.outer", "Previous class" },
            { "][", move.goto_next_end, "@class.outer", "Next class end" },
            { "[]", move.goto_previous_end, "@class.outer", "Previous class end" },
          }
          for _, motion in ipairs(motions) do
            local lhs, goto_, object, desc = motion[1], motion[2], motion[3], motion[4]
            vim.keymap.set({ "n", "x", "o" }, lhs, function()
              goto_(object, "textobjects")
            end, { desc = desc })
          end
        end,
      },
    },
    config = function()
      -- No setup() call: install_dir already defaults to stdpath("data")/site,
      -- which is on the runtimepath, and passing it explicitly prepends a
      -- duplicate runtimepath entry.
      local ts = require "nvim-treesitter"

      -- nvim-treesitter shells out to `tree-sitter build` for every parser, so
      -- nothing can be installed without the CLI. Existing parsers still attach.
      local can_install = vim.fn.executable "tree-sitter" == 1
      if not can_install then
        vim.notify(
          "tree-sitter CLI not found; parsers cannot be built.\n"
            .. "Install with `cargo install --locked tree-sitter-cli`.",
          vim.log.levels.WARN
        )
      end

      -- get_available() fires a User TSUpdate autocmd on every call, so cache it
      local available = ts.get_available()
      local requested = {} ---@type table<string, true>
      for _, lang in ipairs(baseline) do
        requested[lang] = true
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("config-treesitter", { clear = true }),
        desc = "Start treesitter, installing the parser on demand",
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end

          if vim.list_contains(ts.get_installed "parsers", lang) then
            attach(args.buf)
          elseif can_install and vim.list_contains(available, lang) and not requested[lang] then
            requested[lang] = true
            ts.install(lang):await(function(err)
              -- await may fire off the main loop
              vim.schedule(function()
                if err then
                  requested[lang] = nil
                else
                  attach_loaded()
                end
              end)
            end)
          else
            -- parser may exist outside nvim-treesitter's control
            attach(args.buf)
          end
        end,
      })

      if can_install then
        ts.install(baseline, { summary = true }):await(function()
          vim.schedule(attach_loaded)
        end)
      end
    end,
  },
}
