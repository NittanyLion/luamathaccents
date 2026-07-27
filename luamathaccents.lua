-- luamathaccents.lua
-- Copyright 2026 Joris Pinkse
--
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either version 1.3c
-- of this license or (at your option) any later version.
-- The latest version of this license is in
--   https://www.latex-project.org/lppl.txt
--
-- Part of the luamathaccents package; see luamathaccents.sty for details.
--
-- Rewrites input lines so that a Unicode combining character following a
-- base character becomes the corresponding TeX accent command, e.g. the
-- two characters "x" + U+0302 (combining circumflex) become "\hat x".

luamathaccents = luamathaccents or {}

-- Combining character -> accent command.  Commands beyond the classic
-- TeX/LaTeX math accents (\ovhook, \candra, \oturnedcomma, ...) are
-- provided by the unicode-math package.
local mappings = {
  [0x0300] = "\\grave ",              -- combining grave accent
  [0x0301] = "\\acute ",              -- combining acute accent
  [0x0302] = "\\hat ",                -- combining circumflex accent
  [0x0303] = "\\tilde ",              -- combining tilde
  [0x0304] = "\\bar ",                -- combining macron
  [0x0305] = "\\bar ",                -- combining overline
  [0x0306] = "\\breve ",              -- combining breve
  [0x0307] = "\\dot ",                -- combining dot above
  [0x0308] = "\\ddot ",               -- combining diaeresis
  [0x0309] = "\\ovhook ",             -- combining hook above
  [0x030A] = "\\ocirc ",              -- combining ring above
  [0x030C] = "\\check ",              -- combining caron
  [0x0310] = "\\candra ",             -- combining candrabindu
  [0x0312] = "\\oturnedcomma ",       -- combining turned comma above
  [0x0315] = "\\ocommatopright ",     -- combining comma above right
  [0x031A] = "\\droang ",             -- combining left angle above
  [0x0331] = "\\underline ",          -- combining macron below
  [0x20D0] = "\\leftharpoonaccent ",  -- combining left harpoon above
  [0x20D1] = "\\rightharpoonaccent ", -- combining right harpoon above
  [0x20D6] = "\\overleftarrow ",      -- combining left arrow above
  [0x20D7] = "\\vec ",                -- combining right arrow above
  [0x20DB] = "\\dddot ",              -- combining three dots above
  [0x20E1] = "\\overleftrightarrow ", -- combining left right arrow above
  [0x20E7] = "\\annuity ",            -- combining annuity symbol
  [0x20E9] = "\\widebridgeabove ",    -- combining wide bridge above
  [0x20F0] = "\\asteraccent ",        -- combining asterisk above
}

local function process(line)
  -- Leave lines that are not valid UTF-8 (e.g. from non-UTF-8 input
  -- files) untouched.
  if not utf8.len(line) then return line end
  local found = false
  for _, c in utf8.codes(line) do
    if mappings[c] then found = true break end
  end
  if not found then return line end
  local out = {}
  local pending -- previous codepoint, held back until we know what follows
  for _, c in utf8.codes(line) do
    local repl = mappings[c]
    if repl then
      if pending then
        out[#out + 1] = repl .. utf8.char(pending)
        pending = nil
      else
        -- a combining character with no base character (or following
        -- another combining character) is passed through unchanged
        out[#out + 1] = utf8.char(c)
      end
    else
      if pending then out[#out + 1] = utf8.char(pending) end
      pending = c
    end
  end
  if pending then out[#out + 1] = utf8.char(pending) end
  return table.concat(out)
end

local enabled = false

function luamathaccents.enable()
  if enabled then return end
  luatexbase.add_to_callback("process_input_buffer", process, "luamathaccents")
  enabled = true
end

function luamathaccents.disable()
  if not enabled then return end
  luatexbase.remove_from_callback("process_input_buffer", "luamathaccents")
  enabled = false
end
