require('filetype').setup({
  overrides = {
    extensions = {
      prisma = 'prisma',
    },
    literal = {},
    complex = {},
    -- The same as the ones above except the keys map to functions
    function_extensions = {},
    function_literal = {},
    function_complex = {},

    shebang = {},
  },
})
