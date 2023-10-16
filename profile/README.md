# Ecossistema do CTE/ZL/IFRN


## Apresentação

Este é um **ecossistema** de aplicações que integra os Ambientes Virtuais de Aprendizagem (AVA) do IFRN ao SUAP. O ecossistema usa uma integração com o mínimo de três partes para integrar um único SUAP a vários AVA. As partes que compõem esse ecossistema são: [SUAP](https://gitlab.ifrn.edu.br/cosinf/suap), [Painel](https://github.com/cte-zl-ifrn/painel__ava) AVA e Plugin Modoel ([local_suap](https://github.com/cte-zl-ifrn/moodle__local_suap/)). A unidade de integração é o diário do SUAP, ou seja, exporta do SUAP para o AVA os dados dos diários e importa as notas dos alunos nos diários do AVA para o SUAP.

> Primeiro sua organização deverá ter um termo de cooperação com o IFRN antes que você tenha acesso ao fonte do SUAP.

1. **[SUAP](https://gitlab.ifrn.edu.br/cosinf/suap)** - Sistema acadêmico, mais ligado à parte burocrática do curso.
2. **[Painel AVA](https://github.com/cte-zl-ifrn/painel__ava)** - Orquestrador da integração, dado que pode haver mais de um AVA, ele é responsável por escolher qual AVA será integrado para cada diário, como um **middleware**. Também oferece interface única para acesso a todos os diários de todos os AVA integrados, como um **Painel**.
3. Moodle's plugin **[local_suap](https://github.com/cte-zl-ifrn/moodle__local_suap)** - Recebe a requisição de um Painel AVA, faz todo o trabalho e responde o resultado da integração (importação de diários e exportação de notas).

O objetivo desta página é dar-lhe uma visão de como este ecossistema foi arquitetado a fim de que você possa tentar se inspirar e reproduzir em seu ambiente com o propósito de melhorar a oferta de serviços AVA à comunidade acadêmica.

A integração é composta de duas partes: **diários** e **notas**.

1. **Diários** - 
   1. Sincronamente (caso não exista, cria, caso exista, atualiza se for necessário atualizar):
      1. Sincroniza o Moodle:
         1. Sincroniza os cadastros dos usuários do alunos, professores, tutores e demais colaboradores
         2. Sincroniza as coortes:
            3. Sincroniza os colaboradores da coorte
         3. Sincroniza as categorias, na composição campus, curso, ano/período de oferta e turma
      1. Sincroniza course para o diário na categoria do campus->curso->ano/período->turma:
         1. Sincroniza os enrols no diário 
         2. Sincroniza as matriculas dos professores e tutores
         3. Sincroniza as matriculas dos alunos
         4. Sincroniza os vínculos das coortes (só existe em diário)
         5. Sincroniza os grupos (deixa para colocar os alunos no grupo de forma assíncrona)
      2. Quanto à sala de coordenação, na categoria do campus->curso:
         1. Sincroniza cria os enrols na sala de coordenação
         2. Sincroniza as matriculas dos professores e tutores
         3. Sincroniza as matriculas dos alunos
         5. Sincroniza os grupos por **período de entrada**, **turma**, **polo** e **programa** (deixa para colocar os alunos no grupo de forma assíncrona) 
   2. Sincronamente (caso não exista, cria, caso exista, atualiza se for necessário atualizar):
      1. Sincroniza o agrupamento dos alunos nos seus repectivos grupos no **diário**
      1. Sincroniza o agrupamento dos alunos nos seus repectivos grupos na **sala de coordenação**
2. **Notas** - 
   1. Baixa, para cada categoria de notas com idnumber "N1, N2, N3, N4, N5, N6, N7, N8, N9, NAF", a respectiva nota de cada aluno


## Instalação e configuração

Se você não tem tempo e já tem noção do que é este ecossistema, segue a documentação rápida do que fazer a instalação e configuração do ecossistema em 3 passos. 

> Aqui não teremos os manuais de instalação do Moodle, do Plugin local_suap ou do SUAP, para isso, consulte os manuais dos mesmos.

### 1. No Moodle

Instale o Plugin **local_suap** direto do fonte no GitHub conforme o README do software. Acesse a página de configurações do plugin em `%MOODLE_ROOT_URL%/admin/settings.php?section=authsettingsuap` e copie o valor da configuração `sync_up_auth_token` que foi gerado automaticamente na instalação (lembre que você pode informar outro, se quiser). Repita este passo para cada Moodle que você tem instalado.

### 2. No Painel AVA

Depois de colocar o [Painel AVA](https://github.com/cte-zl-ifrn/painel__ava) para executar conforme o README do software, configure ao menos a variável de ambiente `SUAP_EAD_KEY` em `confs/enabled/painel.env`. Outras configurações serão necessárias, esta é necessária para a autenticação do SUAP neste serviço.

Copie a URL raiz do Moodle e o token de autenticação do passo anterior e cadastre em `%PAINEL_ROOT_URL%/painel/admin/painel/ambiente/`. Faça isso para cada Moodle com o qual queres integrar.

> Atualmente é necessário cadastrar um Moodle por campi, se você tem um mesmo Moodle para mais de um campus, cadastre cada campi individualmente e informe a mesma URL e o mesmo token.

### 3. No SUAP

Edite o `local_settings.py` de tua instalação e defina ao menos as configurações:

* `MOODLE_SYNC_URL` com a URL raiz do Painel AVA (ex.: "https://campus1.ava.ifbr.edu.br/").
* `MOODLE_SYNC_TOKEN` com o valor que foi o que você especificou no **Painel AVA**, arquivo `confs/enabled/painel.env`, variável de ambiente `SUAP_EAD_KEY`.

## Arquitetura

Estes diagramas foram construídos usando o https://app.diagrams.net/ e podem ser [baixado daqui](media/integracao_suap_moodle.drawio) para sua própria edição. Ele se baseia no [C4 Model](c4_model) com a descrição dos tipos de diagramas descritos de forma super simplificada aqui.


### Contexto

.. image:: media/diario.jpg

### Containers

.. image:: media/integracao_suap_moodle-container.svg

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
> A imagem abaixo facilita a identificação de onde as partes do código do diário ficam apresentadas no SUAP.
>
> .. image:: media/diario.jpg

## Quem somos

* **CTE** - [Coordenação de Tecnologias da Educação](https://ead.ifrn.edu.br/Painel/institucional/estrutura-administrativa/dg/dead/te/)
* **DEAD** - [Diretoria de Educação a Distância](https://ead.ifrn.edu.br/Painel/institucional/estrutura-administrativa/dg/dead/)
* **ZL** - [Campus Avançado Nata-Zona Leste](https://ead.ifrn.edu.br/Painel/)
* **IFRN** - [Instituto Federal de Educação, Ciência e Tecnologia do Rio Grande do Norte](https://ifrn.edu.br/).
