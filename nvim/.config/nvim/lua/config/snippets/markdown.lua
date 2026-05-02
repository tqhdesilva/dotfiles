local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s({ trig = "mk" }, fmt("${}$", { i(1) })),
  s({ trig = "dm" }, fmt("$$\n{}\n$$", { i(1) })),
  s({ trig = "ff" }, fmt("\\frac{<>}{<>}", { i(1), i(2) }, { delimiters = "<>" })),
}
