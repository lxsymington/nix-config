local cmd = vim.cmd

-- Builtin –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
cmd([[runtime ftplugin/man.vim]])
cmd([[runtime macros/matchit.vim]])

-- Config ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
require('lxs.config').setup()