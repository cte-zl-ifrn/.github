[Esta organização](https://cte-zl-ifrn.github.io/) concentra diversos projetos público compartilhados pela CTE/ZL/IFRN com a comunidade acadêmica, especialmente os relacionados ao Moodle e à integração deste com o SUAP. Os principais projetos são:

1. [portal__ava](https://github.com/cte-zl-ifrn/portal__ava) - middleware/portal, ele faz o meio campo entre o SUAP e os vários Moodles.
2. [moodle__local_suap](https://github.com/cte-zl-ifrn/moodle__local_suap) - sincronizador, este aqui sincroniza os diários, alunos e professores. Ele recebe a requisição mediada pelo portal__ava.
3. [moodle__auth_suap](https://github.com/cte-zl-ifrn/moodle__auth_suap) - autenticação oAuth2 com SUAP, o plugin padrão do Moodle dá problemas com o oAuth do SUAP, este aqui resolve este problemas.
4. [moodle__block_suapattendance](https://github.com/cte-zl-ifrn/moodle__block_suapattendance) - ainda em construção, fará a configuração do diário e ao sincronizar baixará o planejamento das aulas e o registro de faltas
5. Docker [moodle__image](https://github.com/cte-zl-ifrn/moodle__image), [que também fica disponível aqui](https://hub.docker.com/r/ctezlifrn/moodle) - é uma imagem docker já com o Moodle instalado e configurável via VENV
