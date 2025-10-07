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

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map("grd", picker.definition, "Goto Definition")

    -- Find references for the word under your cursor.
    map("grr", picker.references, "Goto References")

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map("gri", picker.implementation, "Goto Implementation")

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map("grD", vim.lsp.buf.declaration, "Goto Declaration")

    map("grt", picker.type_definition, "Type Definition")
    map("<leader>ds", picker.document_symbol, "Document Symbols")
    map("<leader>ws", picker.workspace_symbol, "Workspace Symbols")
    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if not client then return end
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

    vim.o.complete = ".,o"   -- use buffer and omnifunc
    vim.o.completeopt = "fuzzy,menuone,noselect,popup"
    vim.o.autocomplete = true
    vim.o.pumheight = 7
    vim.lsp.completion.enable(true, client.id, event.buf, {
      autotrigger = true,
      convert = function(item)
        local abbr = item.label
        abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
        abbr = abbr:match("[%w_.]+.*") or abbr
        abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr

        -- Cap return value field to 15 chars
        local menu = item.detail or ""
        menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu

        return { abbr = abbr, menu = menu }
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
