-- Load snipmate snippets
require("luasnip.loaders.from_snipmate").lazy_load()

-- Map '_' all type to luasnip 'all' type
require('luasnip').filetype_extend("all", { "_" })
