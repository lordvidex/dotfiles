#install neovim
sudo snap install nvim
# neovim related tools

# install fzf
sudo apt install fzf
# install ripgrep
sudo apt-get install ripgrep
# install fd
sudo apt-get install fd-find

#install tmux
sudo apt-get install -y tmux
# install tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install configuration sync-er
sh -c "$(curl -fsLS get.chezmoi.io)"
