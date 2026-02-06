# Novas Funcionalidades e Como Usar

Reinicie o Neovim para que as mudanças tenham efeito e o `lazy.nvim` possa instalar os novos plugins.

---

### 1. Múltiplos Terminais Integrados

Agora você pode gerenciar vários terminais como se fossem "abas" dentro do Neovim.

*   **Como usar:**
    *   `Ctrl + j`: Abre ou fecha o terminal principal (este atalho você já tinha).
    *   `Ctrl + t`: **Abre um novo terminal**. Você pode usar isso várias vezes para ter vários terminais rodando (ex: um para o back-end, um para o front-end, etc.).
    *   `<leader>tn`: Vai para o **próximo** terminal.
    *   `<leader>tp`: Vai para o terminal **anterior**.

#### 2. Comentários de Código Inteligentes (`Comment.nvim`)

Comente e descomente linhas ou blocos de código facilmente.

*   **Como usar:**
    *   `gcc`: Comenta/descomenta a linha atual.
    *   `gc` (em modo Visual): Comenta/descomenta o bloco de código selecionado.

#### 3. Depurador de Código (`nvim-dap`)

Você agora tem um depurador de código completo, similar ao de uma IDE.

*   **Atalhos:**
    *   `<F5>`: **Adiciona/Remove um breakpoint** na linha atual.
    *   `<F6>`: **Inicia ou continua** a execução do depurador.
    *   `<F10>`: Passa por cima da linha (Step Over).
    *   `<F11>`: Entra na função (Step Into).
    *   `<S-F11>`: Sai da função (Step Out).
    *   `<leader>du`: Abre/fecha a **interface gráfica do depurador**.
    *   `<leader>dr`: Abre o console de depuração (REPL).

*   **⚠️ Ação Necessária:** O depurador precisa de um "adaptador" para cada linguagem. Eu já pré-configurei como exemplo para **Go**. Se você programa em outras linguagens, como Python, JavaScript, etc., você precisa instalar o adaptador correspondente. Por exemplo, para Python, você precisaria adicionar um plugin como o `nvim-dap-python` e configurá-lo.

#### 4. Integração com `lazygit`

Acesse a poderosa interface do `lazygit` diretamente de dentro do Neovim.

*   **Como usar:**
    *   `<leader>lg`: Abre o `lazygit` em uma janela flutuante.

*   **⚠️ Ação Necessária:** Este atalho só funcionará se você tiver o `lazygit` instalado no seu sistema. Se não tiver, instale-o com o gerenciador de pacotes da sua distribuição (ex: `sudo pacman -S lazygit`, `sudo apt install lazygit`, etc.).

#### 5. Melhorias de UI e Extras

*   **`fidget.nvim`**: Um pequeno indicador aparecerá no canto superior direito mostrando o status dos seus servidores LSP (ex: "LSP: Indexing..."). Não requer nenhuma ação, apenas funciona.
*   **`mini.surround`**: Notei que você já tinha esta funcionalidade. Ela permite manipular "arredores" de texto. Por exemplo, em modo Normal, com o cursor sobre a palavra `"olá"`:
    *   `cs"'`: Troca aspas duplas por simples (`'olá'`).
    *   `ds"`: Deleta as aspas (`olá`).
    *   `ysiw)`: Adiciona parênteses em volta da palavra (`(olá)`).
