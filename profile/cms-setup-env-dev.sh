# Baixe o projeto na pasta de exemplo (se for outra, basta que altere os scripts)
mkdir -p "${PROJECT_DIR:-$HOME/projetos/IFRN/cms}"
git clone git@github.com:cte-zl-ifrn/cms_workspace.git "${WORKSPACE_DIR:-$HOME/projetos/IFRN/cms/cms_workspace}"
cd "${WORKSPACE_DIR:-$HOME/projetos/IFRN/cms/cms_workspace}"

# Configura o teu /etc/hosts para atender por http://ava
./cms setup

if [[ "$SHELL" == '/bin/bash' ]]; then
    source ~/.bashrc
fi

if [[ "$SHELL" == '/bin/zsh' ]]; then
    source ~/.zshrc
fi
