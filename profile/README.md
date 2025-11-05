# Ecossistema de integração Moodle <-> SUAP (Painel, Integrador, Plugins Moodle e Moodle App)

## Apresentação

Este é um **ecossistema** de aplicações que integram os Ambientes Virtuais de Aprendizagem (AVA) do IFRN ao SUAP. O ecossistema usa uma integração de 3 partes para integrar um único SUAP a vários AVA. As partes que compõem esse ecossistema são: [SUAP](https://gitlab.ifrn.edu.br/cosinf/suap), [Integrador AVA](https://github.com/cte-zl-ifrn/integration__integrador) e [Plugin Moodle local_suap](https://github.com/cte-zl-ifrn/moodle__local_suap). Também fazem parte do ecossistema o [Painel AVA]([https://gitlab.ifrn.edu.br/cosinf](https://github.com/cte-zl-ifrn)/ava__painel), plugins Moodle [auth_suap](https://github.com/cte-zl-ifrn/moodle__auth_suap) e [theme_suap](https://github.com/cte-zl-ifrn/moodle__theme_suap), além de outros menos procurados pela comunidade.

> Primeiro sua organização deverá ter um termo de cooperação com o IFRN antes que você tenha acesso ao fonte do SUAP.

## Sobre o SUAP

> **Neste ecosssistema** o [SUAP](https://portal.suap.ifrn.edu.br/) é o Sistema de Gestão Acadêmica (SGA), estando, portanto, mais ligado à parte burocrática do curso.

1. É um ERP desenvolvida pelo IFRN
2. Conveniado em 86 instituições pelo Brasil, sendo 29 delas  institutos federais e​ 16 universidades.
3. Modular, abrange o acadêmico, pessoal, protocolos e documentos eletrônicos e diversas áreas da administração pública.
4. Seu módulo acadêmico permite administração de cursos, turmas, diários, frequência... Enfim, a vida acadêmico dos estudantes e ​egresso.
5. Além, é claro, de integração com o Moodle.

## Sobre o Integrador AVA

> **Neste ecossistema** o Integrador AVA é o middleware responsável por orquestrar a integração. Dado que pode haver mais de um AVA, ele é responsável por escolher qual AVA será integrado para cada diário.

1. Envia
   1. Diários
      1. Professores
      2. Tutores
      3. Alunos
      4. Inscrições
      5. Grupos
      6. Coortes
         1. Coordenadores
         2. Interprete de Libras
         3. etc...
   2. Sala de coordenação do curso
3. Recebe
   1. Notas
4. Em breve
   1. Baixará presença e completude
   2. Criará curso usando modelos
   3. Será oferecido como um serviço em nuvem via RNP

## Sobre plugin Moodle local_suap

> **Neste ecossistema** o local_suap é o responsável por receber a requisição de um Integrador AVA e fazer todo o trabalho pesado no Moodle.

Para funcionar usamos um modelo de equivalência, conforme.

| No SUAP             | No Moodle            |
|---------------------|----------------------|
| 1 diário            | 1 curso              |
| 1 usuário           | 1 usuário            |
| 1 papel no diário   | 1 inscrição          |
| 1 período           | 1 categoria de notas |
| 1 coorte            | 1 coorte             |
| 1 vinculo na coorte | 1 vinculo na coorte  |
| 1 polo              | 1 grupo              |

## Sobre o Painel AVA

> **Neste ecossistema** o Painel AVA oferece interface única para acesso a todos os diários de todos os AVA integrados, mesmo os que não foram criados pelo integrador.


## Visão do ecossistema

![Visão do ecossistema](https://github.com/cte-zl-ifrn/.github/blob/main/painel_ava-visao-geral.png)

O objetivo desta página é dar-lhe uma visão de como este ecossistema foi arquitetado a fim de que você possa tentar se inspirar e reproduzir em seu ambiente com o propósito de melhorar a oferta de serviços AVA à comunidade acadêmica.

A integração é composta de duas partes: **diários** e **notas**.

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

* **IFRN** - [Instituto Federal de Educação, Ciência e Tecnologia do Rio Grande do Norte](https://ifrn.edu.br/).
   - O IFRN é referência nacional em educação técnica em 23 campi, com 59 mil alunos e atuação em diversos níveis de ensino.
   - Forte tradição em inovação educacional e uso de tecnologias.
* **DEAD** - [Diretoria de Educação a Distância](https://ead.ifrn.edu.br/Painel/institucional/estrutura-administrativa/dg/dead/)
   - Coordena, desenvolve e suporta ações de EAD no IFRN, integrando presencial e EAD.
   - Atua na produção de conteúdos e no suporte tecnológico.
* **Nossos Moodles**
   1. Aberto (MOOC)
   2. Acadêmico (ZL)
   3. Presencial (basta ter diário)
   4. Projetos (demais, como por exemplo: projetos de extensão)

# Status
## Status de produção

| Serviço CMS<br>cotic.ead@ifrn.edu.br | [Status CMS](https://ava-ifrn.betteruptime.com/) | Serviço AVA<br>kelson.costa@escolar.ifrn.edu.br | [Status AVA](https://ead-ifrn.betteruptime.com/) |
| ------- | ------ | ------- | ------ |
|Portal ZL|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1im.svg)](https://ead.ifrn.edu.br/portal/)                 | Painel AVA|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i45y.svg)](https://ava.ifrn.edu.br)|
|Ajuda|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1ji.svg)](https://ajuda.ead.ifrn.edu.br/)                      | Integrador AVA|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1mtdm.svg)](https://integrador.ava.ifrn.edu.br)|
|Cultura Potiguar|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1jl.svg)](https://culturapotiguar.ead.ifrn.edu.br/) | Notificador|-|
|CAID|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1jq.svg)](https://caid.ead.ifrn.edu.br/)                        | Login|-|
|SEMEAD|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1js.svg)](https://semead.ead.ifrn.edu.br/)                    | Aberto|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i49w.svg)](https://aberto.ava.ifrn.edu.br)|
|Colóquio|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1k0.svg)](https://coloquio.ead.ifrn.edu.br/)                | Acadêmico|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i46g.svg)](https://academico.ava.ifrn.edu.br/)|
|Leitor|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1k2.svg)](https://leitor.ead.ifrn.edu.br/)                    | Presencial|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i475.svg)](https://presencial.ava.ifrn.edu.br)|
|Suporte|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i1k7.svg)](https://suporte.ead.ifrn.edu.br/)                  | Projetos|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v2/monitor/1i47c.svg)](https://projetos.ava.ifrn.edu.br)|
|SUAP|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v3/monitor/1i1kc.svg)](https://suap.ifrn.edu.br/)                            | 

## Status de teste

| Serviço CMS<br>teste.cte.zl.ifrn@gmail.com | [Status CMS](https://ifrn.betteruptime.com/) | Serviço AVA<br>cte.zl.ifrn@gmail.com | Status AVA |
| ------- | ------ | ------- | ------ |
|Portal ZL|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7jo.svg)](https://teste.portal.ead.ifrn.edu.br)                  | Painel AVA|[-](https://teste.painel.ava.ifrn.edu.br)|
|Ajuda|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7kc.svg)](https://teste.ajuda.ead.ifrn.edu.br/)                      | Integrador AVA|-|
|Cultura Potiguar|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7kl.svg)](https://teste.culturapotiguar.ead.ifrn.edu.br/) | Notificador|-|
|CAID|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7ks.svg)](https://teste.caid.ead.ifrn.edu.br)                         | Login|-|
|SEMEAD|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7l4.svg)](https://teste.semead.ead.ifrn.edu.br/)                    | Aberto|[-](https://projetos.ava.ifrn.edu.br)|
|Colóquio|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7ld.svg)](https://teste.coloquio.ead.ifrn.edu.br/)                | Teste|[-](https://teste.ava.ifrn.edu.br/)|
|Leitor|[![Better Stack Badge](https://uptime.betterstack.com/status-badges/v1/monitor/1i7ll.svg)](https://teste.leitor.ead.ifrn.edu.br/)                    | Próximo|[-](https://proximo.ava.ifrn.edu.br)|
|Suporte|-                                                                                                                                                   | -|-|
|-|-                                                                                                                                                         | -|-|
