thisDir:=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
dotfiles:=${thisDir}dotfiles
drivers:=${thisDir}drivers
scripts:=${thisDir}scripts

install:=sudo dnf -y install
sudo:=sudo

.PHONY: list
list:
	# 	touchpad-fix logitech-m570-driver
	# 	sshd snap bash nord-terminal rime-boshiamy
	# 	trash ranger fzf ripgrep ag ctags tig
	# 	vim neovim
	# 	cpp julia
	# 	telegram-cli

.PHONY: ag
ag:
	type ag || ${install} the_silver_searcher

.PHONY: bash
bash:
	${scripts}/source.sh ${dotfiles}/bash/bash_profile.sh ${HOME}/.bash_profile
	${scripts}/source.sh ${dotfiles}/bash/bashrc.sh ${HOME}/.bashrc
	${scripts}/source.sh ${dotfiles}/shell/rc.sh ${HOME}/.bashrc
	${scripts}/slink.sh ${scripts} ${HOME}/.local/scripts

.PHONY: cpp
cpp:
	type clang || ${install} clang

.PHONY: ctags
ctags:
	type ctags || ${install} ctags

.PHONY: fzf
fzf:
	type fzf || ${install} fzf

.PHONY: julia
julia:
	type julia || ${install} julia

.PHONY: logitech-m570-driver
logitech-m570-driver:
	${sudo} cp ${drivers}/libinput/41-libinput.conf /etc/X11/xorg.conf.d/

.PHONY: neovim
neovim:
	type nvim || ${install} neovim
	test -d ${HOME}/.config/nvim || mkdir -p ${HOME}/.config/nvim
	${scripts}/source.sh ${dotfiles}/vim/rc.vim ${HOME}/.config/nvim/init.vim
	${scripts}/slink.sh ${dotfiles}/vim ${HOME}/.vim
	export VISUAL="$(which nvim)"

.PHONY: nord-terminal
nord-terminal:
	git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
	./nord-gnome-terminal/src/nord.sh
	rm -rf nord-gnome-terminal

.PHONY: ranger
ranger: #TODO remove dependency from bashrc
	type ranger || ${install} ranger
	test -d ${HOME}/.config/ranger || mkdir -p ${HOME}/.config/ranger
	${scripts}/source.sh ${dotfiles}/ranger/rc.conf ${HOME}/.config/ranger/rc.conf

.PHONY: rime-boshiamy
rime-boshiamy:
	$(install) ibus-rime
	test -f ${HOME}/.config/ibus/rime || mkdir -p ${HOME}/.config/ibus/rime
	cp $(thisDir)/rime/* ${HOME}/.config/ibus/rime/
	# TODO

.PHONY: ripgrep
ripgrep:
	type rg || ${install} ripgrep

.PHONY: snap
snap:
	type snap || ${install} snapd
	test -h /snap || sudo ln -s /var/lib/snapd/snap /snap

.PHONY: sshd
sshd:
	source ${scripts}/sshd_setup.sh
	# ETHTOOL_OPTS="wol g" >> /etc/sysconfig/network-scripts/ifcf-[conn]

.PHONY: telegram-cli
telegram-cli: snap
	type telegram-cli || sudo snap install telegram-cli

.PHONY: tig
tig:
	type tig || ${install} tig

.PHONY: touchpad-fix
touchpad-fix:
	${sudo} cp ${drivers}/dell-touchpad/fix-touchpad.service /etc/systemd/system/
	${sudo} systemctl enable fix-touchpad.service

.PHONY: trash
trash:
	type gio || ${install} glib-bin

.PHONY: vim
vim:
	type vim || ${install} vim
	${scripts}/source.sh ${dotfiles}/vim/rc.vim ${HOME}/.vimrc
	${scripts}/slink.sh ${dotfiles}/vim ${HOME}/.vim



