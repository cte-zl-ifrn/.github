# Baixe o projeto na pasta de exemplo (se for outra, basta que altere os scripts)]
PRJ_DIR="${PROJECT_DIR:-$HOME/projetos/NEES/streaming-publico/telabrasil}"
WPS_DIR="${WORKSPACE_DIR:-$PRJ_DIR/front}"

mkdir -p $PRJ_DIR
git clone git@gitlab.ufal.br:nees/streaming-publico/telabrasil/front.git $WPS_DIR
