-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ts_utils = require("nvim-treesitter.ts_utils")

local function add(x, y)
  return x + y
end

local function pow(x)
  return x * x
end

local function t()
  local a = 1
  local b = 2

  print(a)
  print(a)
  if b then
    a = 3
    b = 4
    local _ = add(a, pow(b))

    print(b)
    print(a)
  end
end

local function _set_cursor(node)
  -- TODO: check the validity of range
  local start_row, start_col, _, _ = node:range()
  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
end

local call_exprs = { "function_call", "call_expression" }

local function _is_call_expr(type)
  for i = 1, #call_exprs do
    if call_exprs[i] == type then
      return true
    end
  end
  return false
end

function JumpToNextFuncCall()
  local node = ts_utils.get_node_at_cursor()
  local ctr = 0 -- ugly prevention of endless loop

  while node do
    ctr = ctr + 1

    -- local sibling = node:next_sibling()
    -- print(sibling)
    -- -- if the current node does not have a leftmore sibling then we traverse its parent node
    -- if not sibling then
    --   node = node:parent()
    --   goto continue
    -- end
    -- node = sibling

    if node:type() == "function_declaration" then
      print("return due to type==function_declaration")
      return
    end

    -- TODO: which kinds of nodes contain function_call? (for performance enhancement)
    -- currently, for all next nodes we do a DFS traverse to find the first "function_call"
    local first_function_call_node = nil
    local stack = { node }

    while #stack > 0 do
      local current_node = table.remove(stack)

      if _is_call_expr(current_node:type()) then
        first_function_call_node = current_node
        break
      end

      local children = {}
      for child in current_node:iter_children() do
        table.insert(children, 1, child)
      end

      for _, child in ipairs(children) do
        table.insert(stack, child)
      end
    end

    if first_function_call_node then
      _set_cursor(first_function_call_node)
      print("return due to found first function call")
      return
    end

    if ctr > 1000 then
      print("endless loop...")
      break
    end

    next = node:next_sibling()
    while not next do
      node = node:parent()
      next = node:next_sibling()
    end
    node = next
    print(node)

    ::continue::
  end
  print("return due to node=nil")
end

function JumpToLastFuncCall()
  local node = ts_utils.get_node_at_cursor()
  local ctr = 0 -- ugly prevention of endless loop

  while node do
    ctr = ctr + 1

    local sibling = node:prev_sibling()
    print(sibling)
    -- if the current node does not have a leftmore sibling then we traverse its parent node
    if not sibling then
      node = node:parent()
      goto continue
    end

    node = sibling

    if node:type() == "function_declaration" then
      return
    end

    -- TODO: which kinds of nodes contain function_call? (for performance enhancement)
    -- currently, for all previous nodes we do a DFS traverse to find the last "function_call"
    local last_function_call_node = nil
    local stack = { node }

    while #stack > 0 do
      local current_node = table.remove(stack)

      if _is_call_expr(current_node:type()) then
        last_function_call_node = current_node
      end

      local children = {}
      for child in current_node:iter_children() do
        table.insert(children, 1, child)
      end

      for _, child in ipairs(children) do
        table.insert(stack, child)
      end
    end

    if last_function_call_node then
      _set_cursor(last_function_call_node)
      return
    end

    if ctr > 1000 then
      print("endless loop...")
      break
    end

    ::continue::
  end
end

local function JumpToNextFuncCallByRegex() end

vim.api.nvim_set_keymap("n", "]n", "<cmd>lua JumpToNextFuncCall()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[n", "<cmd>lua JumpToLastFuncCall()<CR>", { noremap = true, silent = true })
