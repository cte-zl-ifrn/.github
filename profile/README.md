# Sobre esta organização

[Esta organização](https://cte-zl-ifrn.github.io/) concentra diversos projetos público compartilhados pela CTE/ZL/IFRN com a comunidade acadêmica, especialmente os relacionados ao Moodle e à integração deste com o SUAP. Os principais projetos são:


Os projetos são:

## AVA-Portal

O AVA-Portal é um middleware integrador entre SUAP e diversos Moodles, além disso, também tem um dashboard com todas  inscrições, notificações e mensagens do usuário, desta forma cada usuário tem acesso aos cursos/diários em que está inscrito sem precisar procurar em vários Moodles. É um projeto em Python/Django já disponibilizado com o Docker Compose.

https://github.com/cte-zl-ifrn/portal__ava

## Plugin Local para Moodle: SUAP

Este plugin tem as API responsáveis pela comunicação entre o SUAP e o Moodle em que foi instalado e configurado. É um plugin do tipo local para Moodle, ou seja, em PHP.

https://github.com/cte-zl-ifrn/moodle__local_suap

## Moodle Auth SUAP

O plugin padrão do Moodle dá problemas com o oAuth do SUAP, este aqui resolve este problemas. É um plugin do tipo auth para Moodle, ou seja, em PHP.
https://github.com/cte-zl-ifrn/moodle__auth_suap

## Moodle Block SUAP Attendance

AINDA EM CONSTRUÇÃO. Fará a configuração do diário e ao sincronizar baixará o planejamento das aulas e o registro de faltas. É um plugin do tipo block para Moodle, ou seja, em PHP.

https://github.com/cte-zl-ifrn/moodle__block_suapattendance

## Imagem Docker

Para facilitar o desenvolvimento a equipe da CTE/ZL/IFRN usa uma imagem Docker chamado [ctezlifrn/moodle](https://hub.docker.com/r/ctezlifrn/moodle), com projeto em Docker Compose. Se você não quiser usar a imagem já disponilizad você pode acessar o fonte no repositório abaixo.

https://github.com/cte-zl-ifrn/moodle__image


## Documentação

Mais detalhes estão documentados em https://cte-zl-ifrn.github.io/ .
