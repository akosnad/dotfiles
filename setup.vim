call appendbufline(bufname(), 0, "NVim is updating, please don't close it. It will close automatically")
call execute('PlugUpgrade')
call execute('PlugUpdate')
source $MYVIMRC
call execute('CocInstall coc-json coc-lua coc-rls coc-sh coc-tsserver coc-spell-checker coc-toml coc-stylelint coc-discord-rpc coc-cmake')
call coc#util#update_extensions()
qa!
