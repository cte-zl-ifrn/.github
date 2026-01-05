# Baixe o projeto na pasta de exemplo (se for outra, basta que altere os scripts)]
PRJ_DIR="${PROJECT_DIR:-$HOME/projetos/NEES/streaming-publico/telabrasil}"
WPS_DIR="${WORKSPACE_DIR:-$PRJ_DIR/back}"

mkdir -p $PRJ_DIR
git clone git@gitlab.ufal.br:nees/streaming-publico/telabrasil/back.git $WPS_DIR

code $WPS_DIR/infra_workspace.code-workspace
