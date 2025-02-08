-- lua/ai_rewrite.lua
local M = {}
local Popup = require("nui.popup")

-- Helper: Extract the current visual selection using getpos() with column info.
local function get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then
    return "", start_line, end_line
  end

  -- Adjust the first and last lines to capture only the selected text.
  lines[1] = string.sub(lines[1], start_col)
  if #lines == 1 then
    lines[1] = string.sub(lines[1], 1, end_col - start_col + 1)
  else
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  end

  return table.concat(lines, "\n"), start_line, end_line
end

-- Call Anthropic's API with the given prompt using curl.
local function call_llm(prompt_text, callback)
  local Job = require("plenary.job")
  local payload = {
    model = "claude-3-5-sonnet-20241022",
    max_tokens = 1024,
    system = "Respond ONLY with requested code nothing else do not include ``` code fences. Just the code.",
    messages = {
      { role = "user", content = prompt_text },
    },
  }
  local json_payload = vim.fn.json_encode(payload)
  local api_key = os.getenv("ANTHROPIC_API_KEY")
  if not api_key or api_key == "" then
    vim.schedule(function()
      vim.notify("ANTHROPIC_API_KEY not set", vim.log.levels.ERROR)
    end)
    return
  end

  Job:new({
    command = "curl",
    args = {
      "--silent", -- suppress curl’s progress meter
      "https://api.anthropic.com/v1/messages",
      "--header", "x-api-key: " .. api_key,
      "--header", "anthropic-version: 2023-06-01",
      "--header", "content-type: application/json",
      "--data", json_payload,
    },
    on_exit = function(j, _)
      local result = table.concat(j:result(), "\n")
      vim.schedule(function()
        local decoded = vim.json.decode(result)
        if not decoded then
          vim.notify("Failed to decode API response", vim.log.levels.ERROR)
          return
        end

        local completion = nil
        if decoded.completion then
          completion = decoded.completion
        elseif decoded.content then
          local parts = {}
          for _, segment in ipairs(decoded.content) do
            if segment.text then
              table.insert(parts, segment.text)
            end
          end
          completion = table.concat(parts, "\n")
        end

        if not completion or completion == "" then
          vim.notify("No completion returned from API", vim.log.levels.ERROR)
          return
        end
        callback(completion)
      end)
    end,
    on_stderr = function(_, data)
      if data and data ~= "" then
        vim.schedule(function()
          vim.notify("LLM error: " .. data, vim.log.levels.ERROR)
        end)
      end
    end,
  }):start()
end

--------------------------------------------------------------------------------
-- Function for Visual Mode (Rewrite Selection)
--------------------------------------------------------------------------------
function M.prompt_ai_rewrite()
  -- Capture the visual selection immediately while still in visual mode.
  local selection_text, start_line, end_line = get_visual_selection()
  if selection_text == "" then
    vim.notify("No selection found!", vim.log.levels.WARN)
    return
  end
  -- Now exit visual mode reliably using feedkeys.
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<ESC>", true, false, true),
    "n",
    true
  )

  -- Capture the entire current file's content.
  local file_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local file_context = table.concat(file_lines, "\n")

  local Input = require("nui.input")
  local input = Input({
    position = "50%",
    size = { width = 50 },
    border = {
      style = "rounded",
      text = { top = "Enter LLM Instructions", top_align = "center" },
    },
    win_options = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
  }, {
    prompt = "> ",
    default_value = "",
    on_submit = function(instructions)
      if instructions == "" then
        vim.notify("No instructions provided!", vim.log.levels.WARN)
        return
      end

      -- Build the prompt with full file context, instructions, and the selected snippet.
      local prompt_text = "Full File Context:\n" .. file_context .. "\n\n"
      prompt_text = prompt_text .. "Rewrite the following code snippet using these instructions:\n\n"
      prompt_text = prompt_text .. "Instructions: " .. instructions .. "\n\n"
      prompt_text = prompt_text .. "Selected Code Snippet:\n" .. selection_text

      -- Create a loading popup.
      local loading_popup = Popup({
        relative = "editor",
        position = "50%",
        size = { width = 30, height = 3 },
        border = {
          style = "rounded",
          text = { top = "Loading...", top_align = "center" },
        },
      })
      loading_popup:mount()

      call_llm(prompt_text, function(result)
        loading_popup:unmount()  -- remove the loading popup when done
        local new_lines = vim.split(result, "\n")
        vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
        vim.notify("AI Rewrite complete!", vim.log.levels.INFO)
      end)
    end,
  })

  input:mount()
end

--------------------------------------------------------------------------------
-- Function for Normal Mode (Insert at Cursor)
--------------------------------------------------------------------------------
function M.prompt_ai_insert()
  -- Capture the entire current file's content.
  local file_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local file_context = table.concat(file_lines, "\n")

  -- Get the current cursor position (row, col)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  local Input = require("nui.input")
  local input = Input({
    position = "50%",
    size = { width = 50 },
    border = {
      style = "rounded",
      text = { top = "Enter LLM Instructions", top_align = "center" },
    },
    win_options = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
  }, {
    prompt = "> ",
    default_value = "",
    on_submit = function(instructions)
      if instructions == "" then
        vim.notify("No instructions provided!", vim.log.levels.WARN)
        return
      end

      -- Build the prompt with full file context and the instructions.
      local prompt_text = "Full File Context:\n" .. file_context .. "\n\n"
      prompt_text = prompt_text .. "Generate code according to these instructions and insert it at the current cursor position.\n\n"
      prompt_text = prompt_text .. "Instructions: " .. instructions

      -- Create a loading popup.
      local loading_popup = Popup({
        relative = "editor",
        position = "50%",
        size = { width = 30, height = 3 },
        border = {
          style = "rounded",
          text = { top = "Loading...", top_align = "center" },
        },
      })
      loading_popup:mount()

      call_llm(prompt_text, function(result)
        loading_popup:unmount()
        local new_lines = vim.split(result, "\n")
        -- Get the current cursor position again (in case it has changed)
        local pos = vim.api.nvim_win_get_cursor(0)
        -- Insert the generated code at the cursor using nvim_buf_set_text.
        vim.api.nvim_buf_set_text(0, pos[1] - 1, pos[2], pos[1] - 1, pos[2], new_lines)
        vim.notify("AI Code insertion complete!", vim.log.levels.INFO)
      end)
    end,
  })

  input:mount()
end

return M
