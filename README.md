git clone

mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mkdir -p ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim

rm -f ~/.gitconfig
ln -s ~/dotfiles/gitconfig ~/.gitconfig
