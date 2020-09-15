thisDir:=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
dotfiles:=${thisDir}dotfiles
drivers:=${thisDir}drivers
scripts:=${thisDir}scripts

install:=sudo dnf -y install
sudo:=sudo

# environment level

.PHONY: list
list:
	# 	touchpad-fix
	# 	sshd snap bash nord-terminal
	# 	trash ranger fzf ripgrep ctags git tig
	# 	vim neovim
	# 	cpp julia
	# 	telegram-cli

.PHONY: tester
tester:
	echo ${thisDir}

# app level

.PHONY: touchpad-fix
touchpad-fix:
	${sudo} cp ${drivers}/dell-touchpad/fix-touchpad.service /etc/systemd/system/
	${sudo} systemctl enable fix-touchpad.service

.PHONY: sshd
sshd:
	source ${scripts}/sshd_setup.sh
	# ETHTOOL_OPTS="wol g" >> /etc/sysconfig/network-scripts/ifcf-[conn]

.PHONY: snap
snap:
	type snap || ${install} snapd
	test -h /snap || sudo ln -s /var/lib/snapd/snap /snap

.PHONY: bash
bash:
	${scripts}/source.sh ${dotfiles}/bash/bash_profile.sh ${HOME}/.bash_profile
	${scripts}/source.sh ${dotfiles}/bash/bashrc.sh ${HOME}/.bashrc
	${scripts}/source.sh ${dotfiles}/shell/rc.sh ${HOME}/.bashrc

.PHONY: nord-terminal
nord-terminal:
	git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
	./nord-gnome-terminal/src/nord.sh
	rm -rf nord-gnome-terminal

.PHONY: trash
trash:
	type gio || ${install} glib-bin

.PHONY: ranger
ranger: #TODO remove dependency from bashrc
	type ranger || ${install} ranger
	test -d ${HOME}/.config/ranger || mkdir -p ${HOME}/.config/ranger
	${scripts}/source.sh ${dotfiles}/ranger/rc.conf ${HOME}/.config/ranger/rc.conf

.PHONY: fzf
fzf:
	type fzf || ${install} fzf

.PHONY: ripgrep
ripgrep:
	type rg || ${install} ripgrep

.PHONY: ctags
ctags:
	type ctags || ${install} ctags

.PHONY: git
git:
	type git || ${install} git
	git config --global user.name $(shell getMy name)
	git config --global user.email $(shell getMy mail)

.PHONY: tig
tig:
	type tig || ${install} tig

.PHONY: vim
vim:
	type vim || ${install} vim
	${scripts}/source.sh ${dotfiles}/vim/rc.vim ${HOME}/.vimrc
	${scripts}/slink.sh ${dotfiles}/vim ${HOME}/.vim
	export EDITOR="vim"

.PHONY: neovim
neovim:
	type nvim || ${install} neovim
	test -d ${HOME}/.config/nvim || mkdir -p ${HOME}/.config/nvim
	${scripts}/source.sh ${dotfiles}/vim/rc.vim ${HOME}/.config/nvim/init.vim
	${scripts}/slink.sh ${dotfiles}/vim ${HOME}/.vim
	export EDITOR="nvim"

.PHONY: vim-plugin
vim-plugin: ctags ranger fzf ripgrep

.PHONY: cpp
cpp:
	type clang || ${install} clang

.PHONY: julia
julia:
	type julia || ${install} julia

.PHONY: telegram-cli
telegram-cli: snap
	type telegram-cli || sudo snap install telegram-cli



.PHONY: logitech-m570-driver
logitech-m570-driver:
	${sudo} cp ${drivers}/libinput/41-libinput.conf /etc/X11/xorg.conf.d/

.PHONY: ag
ag:
	type ag || ${install} the_silver_searcher

