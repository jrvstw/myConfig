thisDir:=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
dotfiles:=${thisDir}dotfiles
drivers:=${thisDir}drivers
scripts:=${thisDir}scripts


.PHONY: bash
bash:
	${scripts}/source.sh ${dotfiles}/bash/bash_profile.sh ${HOME}/.bash_profile
	${scripts}/source.sh ${dotfiles}/bash/bashrc.sh ${HOME}/.bashrc
	${scripts}/source.sh ${dotfiles}/shell/rc.sh ${HOME}/.bashrc
	${scripts}/slink.sh ${scripts} ${HOME}/.local/scripts

.PHONY: neovim
neovim:
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
	test -d ${HOME}/.config/ranger || mkdir -p ${HOME}/.config/ranger
	test -d ${HOME}/Starred || mkdir -p ${HOME}/Starred
	${scripts}/source.sh ${dotfiles}/ranger/rc.conf ${HOME}/.config/ranger/rc.conf

.PHONY: vim
vim:
	${scripts}/source.sh ${dotfiles}/vim/rc.vim ${HOME}/.vimrc
	${scripts}/slink.sh ${dotfiles}/vim ${HOME}/.vim



