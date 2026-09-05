# Aquazen

### Sistema de Gerenciamento de Aquários (SPA)

O **Aquazen** é uma Single Page Application (SPA) robusta e profissional, desenvolvida inteiramente em um único arquivo HTML, projetada para auxiliar aquaristas (Low Tech e High Tech) no monitoramento e gestão completa de seus ecossistemas aquáticos.

## Sobre o Projeto

O objetivo do Aquazen é fornecer uma ferramenta acessível, sem necessidade de instalação de servidores ou bancos de dados complexos, para registrar parâmetros da água, controlar manutenções, gerenciar inventário e visualizar a evolução do aquário através de dashboards intuitivos.

### Funcionalidades Principais

* **Dashboard:** Visão geral com KPIs (Temperatura Média, Patrimônio, Volume) e gráficos interativos (SVG nativo) de temperatura, pH e Nitrato.

* **Registros Diários:** Formulário completo para inserção de parâmetros (pH, Amônia, Nitrito, Fosfato, Ferro, Oxigênio Dissolvido, Cobre, Silicatos, etc.) e tarefas de manutenção (TPA, Fertilização), com validação de dados e feedback visual. Importação/exportação em CSV para integração com planilhas.

* **Cronograma Inteligente:** Geração automática de calendário de tarefas baseada em um plano de manutenção configurável (Diário, Semanal, Quinzenal, etc.), com suporte a exportação para agenda (.ics).

* **Inventário Financeiro:** Controle de fauna, flora, equipamentos e insumos, com cálculo automático de custos e gestão de itens ativos/inativos.

* **Galeria de Evolução:** Linha do tempo visual construída a partir das fotos anexadas aos registros diários.

* **Calculadora Integrada (Aquazen Calc):** Página dedicada (`calculadora.html`, acessível pelo menu "Calculadora") com calculadoras e conversores para aquários de água doce, salgada e salobra — volume, substrato, CO2, dosagem e mais.

* **Alertas Dinâmicos:** Notificações automáticas sobre atrasos em manutenções e níveis críticos de parâmetros químicos (alertas de atraso e de emergência funcionam de forma independente).

* **Consultor IA:** Menu "IA" com diagnóstico assistido por Gemini para dúvidas sobre saúde de peixes, plantas e parâmetros da água (requer uma chave de API do Gemini, configurada em Configuração &gt; Sistema).

* **Identidade do Tanque:** Suporte a água doce, salgada e salobra, estilo de montagem (comunitário, plantado, biótopo, etc.) e ID do tanque para organizar backups de múltiplos aquários.

* **Backup & Restore:** Sistema completo de exportação e importação de dados em formato JSON, garantindo a portabilidade entre navegadores e dispositivos.

## Tecnologias Utilizadas

O projeto segue a filosofia **Single-File**, onde toda a estrutura, estilo e lógica residem em um único arquivo `.html`.

* **HTML5:** Estrutura semântica e acessível.

* **Tailwind CSS (via CDN):** Estilização completa e responsiva. O sistema utiliza variáveis CSS (`:root`) mapeadas para permitir a troca de temas em tempo real.

* **JavaScript Puro (Vanilla JS):** Lógica de negócio modularizada (Padrão Namespace: `App`, `Store`, `Modules`, `UI`), sem dependência de frameworks.

* **Persistência de Dados:** `localStorage` do navegador, com gestão de cotas e tratamento de erros.

* **FontAwesome (via CDN):** Ícones vetoriais para interface e identificação de tarefas.

* **Google Fonts:** Tipografia 'Inter' para uma interface limpa e moderna.

## Padrões de Cores e Temas

O Aquazen possui um motor de temas dinâmico que permite ao usuário alterar a aparência da aplicação instantaneamente. As paletas foram pensadas para o conforto visual e contexto do aquarismo.

| Tema | Nome Visual | Descrição | 
 | ----- | ----- | ----- | 
| **Dark** (Padrão) | *Deep Ocean* | Tons de cinza escuro e azulados, ideal para ambientes com pouca luz. | 
| **Ciano** | *Deep Blue* | Foco em tons profundos de ciano e azul marinho. | 
| **Verde** | *Planted Tank* | Paleta baseada em verdes e tons terrosos, remetendo a aquários plantados. | 
| **Light** | *Lab* | Fundo claro com alto contraste, estilo clínico e limpo. | 

## Como Usar

### Uso Local

Para utilizar o Aquazen diretamente no seu computador, sem necessidade de internet (após o primeiro carregamento das CDNs) ou servidor:

1. Baixe os arquivos `index.html` e `calculadora.html` (mantenha-os na mesma pasta — o menu "Calculadora" do `index.html` abre o `calculadora.html`).

2. Crie uma pasta dedicada para o projeto (ex: `MeusAquarios`).

3. **Imagens:** Dentro desta pasta, crie um subdiretório chamado `imagens`. Embora o sistema suporte conversão para Base64, organizar suas fotos originais localmente facilita a gestão caso opte por usar URLs relativas.

4. Abra o arquivo `index.html` em qualquer navegador moderno (Chrome, Firefox, Edge, Safari).

5. Configure o nome do seu tanque e parâmetros ideais no menu **Configuração**.

### Uso Remoto (Hospedagem)

Para acessar seus dados de qualquer lugar (via celular ou outros computadores), recomenda-se hospedar o arquivo:

1. Faça o upload dos arquivos `index.html` e `calculadora.html` para serviços de hospedagem estática gratuitos como GitHub Pages, Vercel ou Netlify.

2. **Diretório de Imagens:** Se for utilizar referências de imagens por URL (ao invés do upload direto que salva no navegador), certifique-se de criar a estrutura de pastas `/imagens` no seu repositório e subir os arquivos para lá.

3. Acesse a URL gerada pelo provedor.

> **Nota Importante:** O sistema utiliza o `localStorage` do navegador. Se você acessar por dispositivos diferentes (ex: PC e Celular), os dados **não** estarão sincronizados automaticamente, a menos que você utilize a função de **Backup (Exportar JSON)** em um dispositivo e **Restore (Importar JSON)** no outro.

## Autoria

Desenvolvido por **Alexsandro Cardoso Carvalho**.

* **GitHub:** [alexsandroccarv](https://github.com/alexsandroccarv)

* **Apoie o Projeto:** [Me Apoie](https://ccarvalho.net/meapoie.html)

## Licença

Este projeto está licenciado sob a **GNU Affero General Public License v3.0 (AGPLv3)**.

Isso significa que você tem a liberdade de usar, estudar, modificar e distribuir o software, desde que as versões modificadas que rodam em rede também tenham seu código-fonte disponibilizado sob a mesma licença.

[Ler a licença completa (GNU.org)](https://www.gnu.org/licenses/agpl-3.0.html)
