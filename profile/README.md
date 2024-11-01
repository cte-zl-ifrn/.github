# Ecossistema do CTE/ZL/IFRN


## Apresentação

Este é um **ecossistema** de aplicações que integra os Ambientes Virtuais de Aprendizagem (AVA) do IFRN ao SUAP. O ecossistema usa uma integração com o mínimo de três partes para integrar um único SUAP a vários AVA. As partes que compõem esse ecossistema são: [SUAP](https://gitlab.ifrn.edu.br/cosinf/suap), [Painel](https://github.com/cte-zl-ifrn/painel__ava) AVA e Plugin Modoel ([local_suap](https://github.com/cte-zl-ifrn/moodle__local_suap/)). A unidade de integração é o diário do SUAP, ou seja, exporta do SUAP para o AVA os dados dos diários e importa as notas dos alunos nos diários do AVA para o SUAP.

> Primeiro sua organização deverá ter um termo de cooperação com o IFRN antes que você tenha acesso ao fonte do SUAP.

1. **[SUAP](https://gitlab.ifrn.edu.br/cosinf/suap)** - Sistema acadêmico, mais ligado à parte burocrática do curso.
2. **[Painel AVA](https://github.com/cte-zl-ifrn/painel__ava)** - Orquestrador da integração, dado que pode haver mais de um AVA, ele é responsável por escolher qual AVA será integrado para cada diário, como um **middleware**. Também oferece interface única para acesso a todos os diários de todos os AVA integrados, como um **Painel**.
3. Moodle's plugin **[local_suap](https://github.com/cte-zl-ifrn/moodle__local_suap)** - Recebe a requisição de um Painel AVA, faz todo o trabalho e responde o resultado da integração (importação de diários e exportação de notas).

![Visão do ecossistema](https://github.com/cte-zl-ifrn/.github/blob/main/painel_ava-visao-geral.png)

O objetivo desta página é dar-lhe uma visão de como este ecossistema foi arquitetado a fim de que você possa tentar se inspirar e reproduzir em seu ambiente com o propósito de melhorar a oferta de serviços AVA à comunidade acadêmica.

A integração é composta de duas partes: **diários** e **notas**.

1. **Diários** (TESTADO NO POSTGRESQL)
   1. Sincronamente (caso não exista, cria, caso exista, atualiza se for necessário atualizar):
      1. Sincroniza o Moodle:
         1. contas dos usuários do alunos, professores, tutores e demais colaboradores
         2. coortes:
            1. Sincroniza os colaboradores da coorte
         3. Sincroniza as categorias, na composição: "campus -> curso -> ano/período de oferta -> turma"
      1. Sincroniza o diário na categoria do "campus -> curso -> ano/período de oferta -> turma":
         1. enrols
         2. matriculas dos professores e tutores
         3. matriculas dos alunos
         4. vínculos das coortes (só existe em diário)
         5. grupos por **período de entrada**, **turma**, **polo** e **programa** (deixa para colocar os alunos no grupo de forma assíncrona)
      2. Sincroniza a sala de coordenação na categoria do "campus -> curso":
         1. enrols
         2. matriculas dos professores e tutores
         3. matriculas dos alunos
         4. grupos por **período de entrada**, **turma**, **polo** e **programa** (deixa para colocar os alunos no grupo de forma assíncrona)
   2. Sincronamente (caso não exista, cria, caso exista, atualiza se for necessário atualizar):
      1. agrupamento dos alunos nos seus repectivos grupos no **diário**
      1. agrupamento dos alunos nos seus repectivos grupos na **sala de coordenação**
2. **Notas** (TESTADO NO POSTGRESQL)
   1. Baixa, para cada categoria de notas com idnumber "N1, N2, N3, N4, N5, N6, N7, N8, N9, NAF", a respectiva nota de cada aluno, onde N1..N9 é a nota final de uma avaliação e NAF é a nota da avaliação final, para os alunos que ficaram em recuperação


## Instalação e configuração

Se você não tem tempo e já tem noção do que é este ecossistema, segue a documentação rápida do que fazer a instalação e configuração do ecossistema em 3 passos. 

> Aqui não teremos os manuais de instalação do Moodle, do Plugin local_suap ou do SUAP, para isso, consulte os manuais dos mesmos.

![Visão do ecossistema](https://github.com/cte-zl-ifrn/.github/blob/main/painel_ava-applications.png)

### 1. No Moodle

Instale o Plugin **local_suap** direto do fonte no GitHub conforme o README do software. Acesse a página de configurações do plugin em `%MOODLE_ROOT_URL%/admin/settings.php?section=authsettingsuap` e copie o valor da configuração `sync_up_auth_token` que foi gerado automaticamente na instalação (lembre que você pode informar outro, se quiser). Repita este passo para cada Moodle que você tem instalado.

### 2. No Painel AVA

Depois de colocar o [Painel AVA](https://github.com/cte-zl-ifrn/painel__ava) para executar conforme o README do software, configure ao menos a variável de ambiente `SUAP_EAD_KEY` em `confs/enabled/painel.env`. Outras configurações serão necessárias, esta é necessária para a autenticação do SUAP neste serviço.

Copie a URL raiz do Moodle e o token de autenticação do passo anterior e cadastre em `%PAINEL_ROOT_URL%/painel/admin/painel/ambiente/`. Faça isso para cada Moodle com o qual queres integrar.

> Atualmente é necessário cadastrar um Moodle por campi, se você tem um mesmo Moodle para mais de um campus, cadastre cada campi individualmente e informe a mesma URL e o mesmo token.

### 3. No SUAP

Edite o `local_settings.py` de tua instalação e defina ao menos as configurações:

* `MOODLE_SYNC_URL` com a URL raiz do middleware do Painel AVA (ex.: "https://ava.ifbr.edu.br/api/moodle_suap/").
* `MOODLE_SYNC_TOKEN` com o valor que foi o que você especificou no **Painel AVA**, arquivo `confs/enabled/painel.env`, variável de ambiente `SUAP_EAD_KEY`.

## Arquitetura

Estes diagramas foram construídos usando o https://app.diagrams.net/ e podem ser [baixado daqui](media/integracao_suap_moodle.drawio) para sua própria edição. Ele se baseia no [C4 Model](c4_model) com a descrição dos tipos de diagramas descritos de forma super simplificada aqui.


## Identificando um código de diário

> No SUAP um curso é formado por vários componentes currículares que são ofertados em períodos na forma de turmas, isto gera um código único de diário.
>
> O código do diário é formado pela concateção do código da turma e pelo código do componente currícular, separados por ".", mais o ID do diário. No exemplo abaixo o código do diário seria "20212.1.011001.1P.FIC007#123456", onde:
>
> * **20212.1.011001.1P** - *código da turma*, onde:
>   * **20212** - *ano/período de oferta do componente*, no caso, ofertado em 2021, período 2.
>   * **1** - *período da turma*, no caso, esta e é o primeiro perído do turma, ou seja, a turma se iniciou no 2º período de 2021 mesmo.
>   * **011001** - *código do curso*, no caso, é o código do curso de "Operador de sistemas".
>   * **1P** - *identificação da turma*, no caso, é arbitrado pela área acadêmica do campus/instituição.
> * **FIC007** - *código do componente currícular*, no caso, FIC007 indicaria o componente "Planilhas eletrônicas - Fundamental".
> * **#123456** - *ID do diário no SUAP*, no caso, #123456 indicaria o diário cujo ID é "123456". *Antes não tinha este elemento, foi adicionado pois um diário pode ser dividido e isso causaria inconsistência.
>

## Quem somos

* **CTE** - [Coordenação de Tecnologias da Educação](https://ead.ifrn.edu.br/Painel/institucional/estrutura-administrativa/dg/dead/te/)
* **DEAD** - [Diretoria de Educação a Distância](https://ead.ifrn.edu.br/Painel/institucional/estrutura-administrativa/dg/dead/)
* **ZL** - [Campus Avançado Nata-Zona Leste](https://ead.ifrn.edu.br/Painel/)
* **IFRN** - [Instituto Federal de Educação, Ciência e Tecnologia do Rio Grande do Norte](https://ifrn.edu.br/).

# Status
## Status de produção

| Serviço CMS<br>cotic.ead@ifrn.edu.br | [Status CMS](https://ava-ifrn.betteruptime.com/) | Serviço AVA<br>cte.ead@ifrn.edu.br | [Status AVA](https://ead-ifrn.betteruptime.com/) |
| ------- | ------ | ------- | ------ |
| [Portal ZL](https://ead.ifrn.edu.br/portal/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1im.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | [Painel AVA](https://ava.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i45y.svg)](https://uptime.betterstack.com/?utm_source=status_badge) |
| [Ajuda](https://ajuda.ead.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1ji.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | Agendador | - -
| [Cultura Potiguar](https://culturapotiguar.ead.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1jl.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | [Integrador](https://integrador.ava.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1mtdm.svg)](https://uptime.betterstack.com/?utm_source=status_badge)
| [CAID](https://caid.ead.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1jq.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | Notificador | - -
| [SEMEAD](https://semead.ead.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1js.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | Login | - -
| [Colóquio](https://coloquio.ead.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1k0.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | [Acadêmico](https://academico.ava.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i46g.svg)](https://uptime.betterstack.com/?utm_source=status_badge) 
| [Leitor](https://leitor.ead.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1k2.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | [Presencial](https://presencial.ava.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i475.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  
| [Suporte](https://suporte.ead.ifrn.edu.br/#login) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1k7.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | [Projetos](https://projetos.ava.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i47c.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  
| [SUAP](https://suap.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1kc.svg)](https://uptime.betterstack.com/?utm_source=status_badge) | [Aberto](https://aberto.ava.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i49w.svg)](https://uptime.betterstack.com/?utm_source=status_badge) |

## Status de teste

| Serviço CMS<br>teste.cte.zl.ifrn@gmail.com | [Status CMS](https://ifrn.betteruptime.com/) | Serviço AVA<br>cte.zl.ifrn@gmail.com | Status AVA |
| ------- | ------ | ------- | ------ |
| [Portal ZL](https://teste.portal.ead.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7jo.svg)](https://uptime.betterstack.com/?utm_source=status_badge) | [Painel AVA](https://ava.ifrn.edu.br) |[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i45y.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  |
| [Ajuda](https://teste.ajuda.ead.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7kc.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | Agendador | - -
| [Cultura Potiguar](https://teste.culturapotiguar.ead.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7kl.svg)](https://uptime.betterstack.com/?utm_source=status_badge) | [Integrador](https://integrador.ava.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i4a0.svg)](https://uptime.betterstack.com/?utm_source=status_badge)
| [CAID](https://teste.caid.ead.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7ks.svg)](https://uptime.betterstack.com/?utm_source=status_badge) | Notificador | - -
| [SEMEAD](https://teste.semead.ead.ifrn.edu.br/) |[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7l4.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | Login | - -
| [Colóquio](https://teste.coloquio.ead.ifrn.edu.br/) |[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7ld.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | [Teste](https://academico.ava.ifrn.edu.br/) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i46g.svg)](https://uptime.betterstack.com/?utm_source=status_badge)
| [Leitor](https://teste.leitor.ead.ifrn.edu.br/) |[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7ll.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  | [Próximo](https://presencial.ava.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i475.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  
| [Suporte]() | - - | [Aberto](https://projetos.ava.ifrn.edu.br) | [![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i47c.svg)](https://uptime.betterstack.com/?utm_source=status_badge)  
| [SUAP]() | - - |  |  |
