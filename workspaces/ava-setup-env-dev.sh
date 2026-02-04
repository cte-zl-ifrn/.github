# Baixe o projeto na pasta de exemplo (se for outra, basta que altere os scripts)
mkdir -p ~/projetos/IFRN/ava
git clone git@codelab.ifrn.edu.br:dead-zl/ava/ava_workspace.git ~/projetos/IFRN/ava/workspace
cd ~/projetos/IFRN/ava/workspace

# Configura o teu /etc/hosts para atender por http://ava
./ava setup

if [[ "$SHELL" == '/bin/bash' ]]; then
    source ~/.bashrc
fi

if [[ "$SHELL" == '/bin/zsh' ]]; then
    source ~/.zshrc
fi
