local utils = {}

function utils.is_personal()
  local personal_machines = {
    "kekpad"
  }
  for _, machine in ipairs(personal_machines) do
    if vim.fn.hostname():lower() == machine then
      return true
    end
  end
  return false
end

function utils.is_docker()
  return vim.fn.filereadable("/.dockerenv") == 1
end

function utils.IF(cond, a, b)
  if cond then
    return a
  else
    return b
  end
end

function utils.if_personal(a, b)
  return utils.IF(utils.is_personal(), a, b)
end



function utils.filter_personal_plugins(plugins)
    if utils.is_personal() then
        return plugins
    end

    local keywords = {
      "copilot"
    }

    return vim.tbl_filter(function(p)
      -- check if plugin name contains any of the keywords
      for _, keyword in ipairs(keywords) do
        -- check if plugin is a string
        local plugin_name
        if type(p) == "string" then
          plugin_name = p
        else
          plugin_name = p[1]
        end
        if string.find(plugin_name, keyword) then
          return false
        end
      end
      return true
    end, plugins)
end
return utils

