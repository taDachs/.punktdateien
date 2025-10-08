vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/j-hui/fidget.nvim" },
})

require "fidget".setup({})

vim.lsp.enable({
  "lua_ls",
  "clangd",
  "basedpyright",
  "lemminx",
})

local completion_kind_styling = {
  Text = { icon = '󰉿', hl = "@lsp.type.string" },
  Method = { icon = '󰊕', hl = "@lsp.type.method" },
  Function = { icon = '󰊕', hl = "@lsp.type.function" },
  Constructor = { icon = '󰒓', hl = "@lsp.type.method" },

  Field = { icon = '󰜢', hl = "@lsp.type.property" },
  Variable = { icon = '󰆦', hl = "@lsp.type.variable" },
  Property = { icon = '󰖷', hl = "@lsp.type.property" },

  Class = { icon = '󱡠', hl = "@lsp.type.class" },
  Interface = { icon = '󱡠', hl = "@lsp.type.interface" },
  Struct = { icon = '󱡠', hl = "@lsp.type.struct" },
  Module = { icon = '󰅩', hl = "@lsp.type.module" },

  Unit = { icon = '󰪚', hl = "PmenuKind" },
  Value = { icon = '󰦨', hl = "PmenuKind" },
  Enum = { icon = '󰦨', hl = "@lsp.type.enum" },
  EnumMember = { icon = '󰦨', hl = "@lsp.type.enumMember" },

  Keyword = { icon = '󰻾', hl = "@lsp.type.keyword" },
  Constant = { icon = '󰏿', hl = "@lsp.type.enumMember" },

  Snippet = { icon = '󱄽', hl = "PmenuKind" },
  Color = { icon = '󰏘', hl = "PmenuKind" },
  File = { icon = '󰈔', hl = "PmenuKind" },
  Reference = { icon = '󰬲', hl = "PmenuKind" },
  Folder = { icon = '󰉋', hl = "PmenuKind" },
  Event = { icon = '󱐋', hl = "@lsp.type.event" },
  Operator = { icon = '󰪚', hl = "@lsp.type.operator" },
  TypeParameter = { icon = '󰬛', hl = "@lsp.type.typeParameter" },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("config-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    local ok, snacks = pcall(require, "snacks")
    local picker = (function()
      if ok then
        return {
          definition = snacks.picker.lsp_definitions,
          references = snacks.picker.lsp_references,
          implementation = snacks.picker.lsp_implementations,
          type_definition = snacks.picker.lsp_type_definitions,
          document_symbol = snacks.picker.lsp_symbols,
          workspace_symbol = snacks.picker.lsp_workspace_symbols,
        }
      else
        return vim.lsp.buf
      end
    end)()

    map("grd", picker.definition, "Goto Definition")
    map("grr", picker.references, "Goto References")
    map("gri", picker.implementation, "Goto Implementation")
    map("grD", vim.lsp.buf.declaration, "Goto Declaration")
    map("grt", picker.type_definition, "Type Definition")
    map("<leader>ds", picker.document_symbol, "Document Symbols")
    map("<leader>ws", picker.workspace_symbol, "Workspace Symbols")
    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("config-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("config-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "config-lsp-highlight", buffer = event2.buf }
        end,
      })
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, "Toggle Inlay Hints")
    end

    vim.lsp.completion.enable(true, client.id, event.buf, {
      autotrigger = false,
      convert = function(item)
        local abbr = item.label

        local kind = vim.tbl_get(vim.lsp.protocol.CompletionItemKind, item.kind) or ""
        local styling = vim.tbl_get(completion_kind_styling, kind) or {}
        local kind_icon = vim.tbl_get(styling, "icon") or ""
        local kind_hl = vim.tbl_get(styling, "hl") or ""

        return { abbr = abbr, kind = kind_icon .. " " .. kind, kind_hlgroup = kind_hl }
      end,
    })

    -- autocommand for showing documentation
    vim.api.nvim_create_autocmd('CompleteChanged', {
      buffer = event.buf,
      callback = function()
        local info = vim.fn.complete_info({ 'selected' })
        local completionItem = vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp', 'completion_item')
        if nil == completionItem then
          return
        end

        local cancel = vim.lsp.buf_request_all(
          event.buf,
          vim.lsp.protocol.Methods.completionItem_resolve,
          completionItem,
          function(resolvedItem)
            local docs = vim.tbl_get(resolvedItem[event.data.client_id], 'result', 'documentation', 'value')
            if nil == docs then
              return
            end

            local winData = vim.api.nvim__complete_set(info['selected'], { info = docs })
            if not winData.winid or not vim.api.nvim_win_is_valid(winData.winid) then
              return
            end

            vim.api.nvim_win_set_config(winData.winid, { border = 'rounded' })
            vim.treesitter.start(winData.bufnr, 'markdown')
            vim.wo[winData.winid].conceallevel = 3
          end
        )
      end
    })
  end,
})

-- prettier diagnostic signs
vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
  jump = {
    --- @param diagnostic? vim.Diagnostic
    --- @param bufnr integer
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then return end
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      })
    end,
  },
}
