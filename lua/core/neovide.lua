local g = vim.g
local o = vim.o

if (g.neovide) then
  g.neovide_refresh_rate = 144

  -- Disable the cursor, it's annoying and has weird visual glitches with Trouble
  g.neovide_cursor_animation_length = 0
  o.guifont = 'Comic Code Ligatures, monospace:h13'
end
