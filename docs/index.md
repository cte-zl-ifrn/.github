# Ecossistema AVA do IFRN

Este é o **ecossistema** de aplicações que integram os Ambientes Virtuais de Aprendizagem (AVA) do IFRN ao SUAP. O ecossistema é composto por 5 softwares, que integra um único SUAP a vários AVA. As partes que compõem esse ecossistema são:

1. **AVA** (RNP e IFRN): Implantado sobre a plataforma Learning Management System (LMS) Moodle, é o equivalente digital da sala de aula, NENHUM registro acadêmico existe ou deve existir lá, ou seja, É ONDE o processo de ensino/aprendizagem ocorre. Protocolos suportados: oficialmente `SGA`
    1. Protocolos suportados opcionalmente:
        1. [`Native Moodle Web Service`](https://docs.moodle.org/dev/Creating_a_web_service_client): plugin nativo com implementações `REST`, `SOAP` e `XML-RPC`.
        2. [`"RESTful"`](https://moodle.org/plugins/webservice_restful): plugin de terceiros com implementações `JSON`, `XML` e `Form`
        3. [`REST`](https://moodle.org/plugins/webservice_restjson): plugin de terceiros com implementações `JSON` e `XML`
        4. [`XML-RPC`](https://moodle.org/plugins/webservice_xmlrpc): plugin de terceiros para suporte a `XML-RPC`
        5. [`MCP`](https://moodle.org/plugins/webservice_mcp): plugin de terceiros com implementação do `Model Context Protocol` para uso por agentes de IA
    2. **Instância AVA**: Instância atendendo a um serviço AVA, no caso o IFRN oferece 5 instâncias:
        1. **[Acadêmico](https://academico.ava.ifrn.edu.br/)**: Sustenta o serviço AVA para os cursos com diário no SUAP do Campus Natal-Zona Leste (ZL). Versão 4.5.x. Hospedado em nuvem pela RNP.
        2. **[Presencial](https://presencial.ava.ifrn.edu.br/)**: Sustenta o serviço AVA para os cursos com diário no SUAP de todos que não seja do Campus ZL. Versão 4.5.x. Hospedado em nuvem pela RNP.
        3. **[Aberto](https://aberto.ava.ifrn.edu.br/)**: Sustenta o serviço AVA para os cursos aberto, ou seja, curso massivo online aberto (Massive Open Online Course - MOOC). Versão 4.5.x. Hospedado no datacenter do IFRN.
        4. **[Projetos](https://projetos.ava.ifrn.edu.br/)**: Se o curso não tem diário e não é aberto é um projeto, simples assim. Versão 4.5.x. Hospedado em nuvem pela RNP.
        5. **[Arquivo](https://ead.ava.ifrn.edu.br/)**: Os AVA Acadêmico com diários até 2022 foi arquivado. Hospedado no datacenter do ZL. Ativado sob demanda. Backup dos cursos disponível em nuvem (sob demanda, em breve online).
2. **[SUAP](https://portal.suap.ifrn.edu.br/) Edu** (IFRN): Módulo do Sistema Unificado de Administração Pública (SUAP) com função de Sistema de Gestão Acadêmica (SGA). é onde TODO o registro acadêmico do aluno, desde a matrícula até o egresso, ocorre, ou seja, NÃO É ONDE o processo ensino/aprendizagem ocorre. Protocolos suportados: `JSON REST`.
3. **SUAP IdP** (IFRN): Módulo difuso no SUAP para gestao de identidades  (Identity Provider - IdP), ou seja, é onde usuários (discentes, seus responsáveis, docentes, demais colaboradores e comunidade externa) têm suas identidade de usuários provisionadas. Protocolos suportados: _nenhum_.
4. **SUAP SSO** (IFRN): Módulo no SUAP para autenticação única de usuários (Single Sign-On - SSO), ou seja, é onde os usuários têm suas identidades confirmadas. Protocolos suportados: `oAuth2` e `JWT`.
5. [**Integrador AVA**](https://github.com/cte-zl-ifrn/integration-integrador_ava) (IFRN): Middleware entre o SUAP e o Moodleegue abaixo a lista de informações extras solicitadas, por processo (integração ou autenticação)
6. [**Painel AVA**](https://github.com/cte-zl-ifrn/integration-painel_ava) (IFRN): Portal entre o SUAP e os AVA, ou seja, é onde os usuários têm todos os seus cursos, de todos os AVA, de forma centralizada. Protocolos suportados: `SGA`, `JSON REST`, `oAuth2` e `JWT`.
7. [**AVA IFRN Mobile**](https://github.com/cte-zl-ifrn/moodle-app) (IFRN): Aplicativo Móvel para Android e iOS que faz interface para o AVA, Painel AVA e SUAP SSO em arquitetura móvel baseada em Ionic. Protocolos suportados: `Native Moodle Web Service`, `JSON RESTful`, `JWT` e `SGA`. Em construção.

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
> Para acompanhar o [status dos serviços](https://github.com/cte-zl-ifrn/.github/blob/main/profile/status.md)
