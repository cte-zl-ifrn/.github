# Baixe o projeto na pasta de exemplo (se for outra, basta que altere os scripts)]
PRJ_DIR="${PROJECT_DIR:-$HOME/projetos/IFRN/infra}"
WPS_DIR="${WORKSPACE_DIR:-$PRJ_DIR/infra_workspace}"

mkdir -p $PRJ_DIR
git clone git@codelab.ifrn.edu.br:dead-zl/infra/infra_workspace.git $WPS_DIR

code $WPS_DIR/infra_workspace.code-workspace
