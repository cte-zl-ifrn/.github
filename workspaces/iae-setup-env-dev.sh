# Baixe o projeto na pasta de exemplo (se for outra, basta que altere os scripts)
mkdir -p ~/projetos/UFRN/iae
git clone ssh://git@git.lais.huol.ufrn.br:2222/AVAS/iae/iae_workspace.git ~/projetos/UFRN/iae/iae_workspace
cd ~/projetos/UFRN/iae/iae_workspace

# Configura o teu /etc/hosts para atender por http://ava
./iae setup

if [[ "$SHELL" == '/bin/bash' ]]; then
    source ~/.bashrc
fi

if [[ "$SHELL" == '/bin/zsh' ]]; then
    source ~/.zshrc
fi
