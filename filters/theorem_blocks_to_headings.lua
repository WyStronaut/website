-- filters/theorem_blocks_to_headings.lua
-- No pandoc.utils usage (works in restricted environments)

local DEFAULT_LEVEL = 3

local LABELS = {
  definition  = "Definition",
  claim       = "Claim",
  theorem     = "Theorem",
  lemma       = "Lemma",
  proposition = "Proposition",
  corollary   = "Corollary",
  remark      = "Remark",
  example     = "Example",
  note        = "Note",
  proof       = "Proof",
}

-- Convert a small inline sequence into plain text (minimal stringify)
-- Handles Str and Space; ignores other inline types safely.
local function inlines_to_text(inlines)
  local parts = {}
  for _, inline in ipairs(inlines) do
    if inline.t == "Str" then
      parts[#parts + 1] = inline.text
    elseif inline.t == "Space" then
      parts[#parts + 1] = " "
    end
  end
  return table.concat(parts)
end

-- If the first block is a paragraph starting with Emph("Proof.") (or similar),
-- remove that emph token so we don't duplicate the heading we add.
local function strip_leading_proof_prefix(blocks)
  if #blocks == 0 then return blocks end
  local b = blocks[1]
  if b.t ~= "Para" then return blocks end
  if #b.content == 0 then return blocks end

  local first = b.content[1]
  if first.t == "Emph" then
    local txt = inlines_to_text(first.content)
    -- Match "Proof." and also "Alternative Proof." etc.
    if txt:match("Proof%.") then
      -- remove the Emph
      table.remove(b.content, 1)
      -- remove a following Space if present
      if b.content[1] and b.content[1].t == "Space" then
        table.remove(b.content, 1)
      end
    end
  end

  return blocks
end

function Div(el)
  local matched = nil

  -- el.classes is list-like; find first known class
  for _, c in ipairs(el.classes) do
    if LABELS[c] then
      matched = c
      break
    end
  end

  if not matched then
    return nil
  end

  local label = LABELS[matched]
  local blocks = el.content

  if matched == "proof" then
    blocks = strip_leading_proof_prefix(blocks)
  end

  local heading = pandoc.Header(DEFAULT_LEVEL, label)

  local out = { heading }
  for _, b in ipairs(blocks) do
    out[#out + 1] = b
  end

  return out
end