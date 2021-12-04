<div align="center">
  <h1>akosnad/dotfiles</h1>
  <h3>My personal workflow/rice</h3>
</div>

## Components
- [Oh My Zsh](https://ohmyz.sh/) shell
- [base16](http://chriskempson.com/projects/base16/) color scheme system
- [Flavours](https://github.com/Misterio77/flavours) base16 color manager
- [Neovim](https://neovim.io/) text editor (more like and IDE with all the plugins)
- [Ranger](https://ranger.github.io/) Console file manager
- [awesome](https://awesomewm.org/) window manager
  - powerarrow-dark theme from [lcpz/awesome-copycats](https://github.com/lcpz/awesome-copycats)
- *...find more in the file tree*

## Install
- Clone to `$HOME/dotfiles`
  - *currently only this path is supported*
- You then have two choices
  - `setup.sh` - includes everything, full GUI experience
  - `setup-minimal.sh` - console-only components, suitable for remote and server usage
- The scripts are repeatable, meaning you can run them again to update things

## TL;DL
```
git clone https://github.com/akosnad/dotfiles $HOME/dotfiles
cd $HOME/dotfiles
./setup.sh
```
