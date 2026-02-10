# Baixe o projeto na pasta de exemplo (se for outra, basta que altere os scripts)
mkdir -p ~/projetos/IFRN/ava
git clone git@github.com:cte-zl-ifrn/ava_workspace.git ~/projetos/IFRN/ava/workspace
cd ~/projetos/IFRN/ava/workspace

# Configura o teu /etc/hosts para atender por http://ava
./ava setup

if [[ "$SHELL" == '/bin/bash' ]]; then
    source ~/.bashrc
fi

if [[ "$SHELL" == '/bin/zsh' ]]; then
    source ~/.zshrc
fi
