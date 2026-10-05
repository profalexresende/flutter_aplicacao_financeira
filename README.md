# Simulador Financeiro em Flutter

Aplicativo mobile desenvolvido em Flutter para realização de simulações de investimentos e cálculos financeiros com juros compostos, validação de entradas, identificação de perfil de investidor e interface modularizada.

## 🚀 Funcionalidades

- **Cálculos Financeiros**:
  - **Montante Final**: Cálculo de juros compostos considerando valor inicial e aportes mensais.
  - **Total Investido**: Soma do valor inicial com o acumulado dos aportes mensais.
  - **Lucro Obtido**: Diferença entre o montante final e o total investido.
  - **Acompanhamento de Meta**: Verificação automática para checar se a meta foi alcançada ou quanto falta para atingi-la.
- **Perfil do Investidor**:
  - Classificação automática com base na taxa de juros informada:
    - **Conservador**: Taxa < 0,5%
    - **Moderado**: Taxa entre 0,5% e 1,5%
    - **Agressivo**: Taxa > 1,5%
- **Feedback ao Usuário**:
  - Mensagens de confirmação e erro via `SnackBar`.
  - Caixa de diálogo `AlertDialog` com 3 ações: Cancelar, Limpar Tudo e Carregar Exemplo.
- **Modularização**:
  - Componentes reutilizáveis para botões e campos de entrada de texto.

---

## 📁 Estrutura do Projeto

```text
lib/
├── widgets/
│   ├── botao.dart       # Widget reutilizável para botões
│   └── texto.dart       # Widget reutilizável para campos de texto
└── main.dart            # Lógica de cálculo, gestão de estado e interface principal
```

---

## 🛠️ Tecnologias Utilizadas

- **Flutter** - Framework de desenvolvimento multiplataforma
- **Dart** - Linguagem de programação
- **dart:math** - Biblioteca nativa para cálculos matemáticos (`pow`)

---

## 📋 Pré-requisitos

Antes de começar, garante que tens instalado na tua máquina:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versão 3.x ou superior)
- [Dart SDK](https://dart.dev/get-dart)
- IDE recomendada: VS Code ou Android Studio

---

## 🔧 Como Executar o Projeto

1. **Clonar o repositório**:
   ```bash
   git clone [https://github.com/seu-usuario/simulador_financeiro.git](https://github.com/seu-usuario/simulador_financeiro.git)
   ```

2. **Aceder à pasta do projeto**:
   ```bash
   cd simulador_financeiro
   ```

3. **Instalar as dependências**:
   ```bash
   flutter pub get
   ```

4. **Executar a aplicação**:
   ```bash
   flutter run
   ```

---

## 🧪 Valores de Teste (Exemplo Padrão)

Para testar o funcionamento da aplicação, podes utilizar o botão **CARREGAR EXEMPLO** no aplicativo ou inserir manualmente os seguintes valores:

| Campo | Valor |
| :--- | :--- |
| **Valor Inicial (R$)** | `1000` |
| **Aporte Mensal (R$)** | `500` |
| **Taxa de Juros (%)** | `1.2` |
| **Quantidade de Meses** | `24` |
| **Meta Financeira (R$)** | `30000` |

**Resultado Esperado:**
- **Montante Final**: R$ 15.142,84
- **Total Investido**: R$ 13.000,00
- **Lucro Obtido**: R$ 2.142,84
- **Situação da Meta**: Faltam R$ 14.857,16 para atingir a meta
- **Perfil Financeiro**: Moderado
