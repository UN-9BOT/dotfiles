NVIM_PATH="~/.config/nvim/"

.PHONY: all test clean

upd_nvim:
	dotbare add ~/.config/nvim/
	dotbare status

push:
	zsh
	$(eval VAR_LOCAL := $(shell read -p "Commit message: " msg; echo $$msg))
	dotbare commit -m ${VAR_LOCAL}
	dotbare push
