import 'dart:math';
import 'package:flutter/material.dart';
import 'widgets/botao.dart';
import 'widgets/texto.dart';

void main() {
  runApp(const SimuladorFinanceiroApp());
}

class SimuladorFinanceiroApp extends StatelessWidget {
  const SimuladorFinanceiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador Financeiro',
      debugShowCheckedModeBanner: false,
      home: const TelaSimulador(),
    );
  }
}

class TelaSimulador extends StatefulWidget {
  const TelaSimulador({super.key});

  @override
  State<TelaSimulador> createState() => TelaSimuladorState();
}

class TelaSimuladorState extends State<TelaSimulador> {
  final TextEditingController valorInicialController = TextEditingController();
  final TextEditingController aporteMensalController = TextEditingController();
  final TextEditingController taxaJurosController = TextEditingController();
  final TextEditingController mesesController = TextEditingController();
  final TextEditingController metaController = TextEditingController();

  double? montanteFinal;
  double? totalInvestido;
  double? lucro;
  String situacaoMeta = '';
  String perfilFinanceiro = '';

  void mostrarSnackbar(String mensagem, {bool isError = false}) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void calcular() {
    final double? valorInicial = double.tryParse(valorInicialController.text);
    final double? aporteMensal = double.tryParse(aporteMensalController.text);
    final double? taxaJuros = double.tryParse(taxaJurosController.text);
    final int? meses = int.tryParse(mesesController.text);
    final double? meta = double.tryParse(metaController.text);

    if (valorInicial == null ||
        aporteMensal == null ||
        taxaJuros == null ||
        meses == null ||
        meta == null ||
        valorInicial < 0 ||
        aporteMensal < 0 ||
        taxaJuros < 0 ||
        meses <= 0 ||
        meta < 0) {
      mostrarSnackbar('Preencha todos os campos', isError: true);
      return;
    }

    final double i = taxaJuros / 100.0;
    final double totalInvest = valorInicial + (aporteMensal * meses);

    double mFinal = valorInicial * pow(1 + i, meses);
    if (i > 0) {
      mFinal += aporteMensal * ((pow(1 + i, meses) - 1) / i);
    } else {
      mFinal += aporteMensal * meses;
    }

    final double calcLucro = mFinal - totalInvest;

    String situacao;
    if (mFinal >= meta) {
      situacao = 'Meta alcançada';
    } else {
      final double falta = meta - mFinal;
      situacao = 'Faltam R\$ ${falta.toStringAsFixed(2)} para atingir a meta';
    }

    String perfil;
    if (taxaJuros < 0.5) {
      perfil = 'Conservador';
    } else if (taxaJuros <= 1.5) {
      perfil = 'Moderado';
    } else {
      perfil = 'Agressivo';
    }

    setState(() {
      totalInvestido = totalInvest;
      montanteFinal = mFinal;
      lucro = calcLucro;
      situacaoMeta = situacao;
      perfilFinanceiro = perfil;
    });

    mostrarSnackbar('Simulação realizada com sucesso');
  }

  void carregarExemplo() {
    valorInicialController.text = '1000';
    aporteMensalController.text = '500';
    taxaJurosController.text = '1.2';
    mesesController.text = '24';
    metaController.text = '30000';

    mostrarSnackbar('Dados de exemplo carregados');
  }

  void limparTudo() {
    valorInicialController.clear();
    aporteMensalController.clear();
    taxaJurosController.clear();
    mesesController.clear();
    metaController.clear();

    setState(() {
      montanteFinal = null;
      totalInvestido = null;
      lucro = null;
      situacaoMeta = '';
      perfilFinanceiro = '';
    });

    mostrarSnackbar('Dados removidos com sucesso');
  }

  void abrirDialogoLimpar() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Limpar Dados'),
          content: const Text('Selecione a ação desejada:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('CANCELAR'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                limparTudo();
              },
              child: const Text('LIMPAR TUDO', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                carregarExemplo();
              },
              child: const Text('CARREGAR EXEMPLO'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Financeira'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: valorInicialController,
              label: 'Valor Inicial (R\$)',
            ),
            CustomTextField(
              controller: aporteMensalController,
              label: 'Aporte Mensal (R\$)',
            ),
            CustomTextField(
              controller: taxaJurosController,
              label: 'Taxa de Juros (%)',
            ),
            CustomTextField(
              controller: mesesController,
              label: 'Quantidade de Meses',
            ),
            CustomTextField(
              controller: metaController,
              label: 'Meta Financeira (R\$)',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Calcular',
                    onPressed: calcular,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Limpar Dados',
                    onPressed: abrirDialogoLimpar,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            if (montanteFinal != null) buildResultadosCard(),
          ],
        ),
      ),
    );
  }

  Widget buildResultadosCard() {
    final String resultadoTexto = '''

Resultados da Simulação:
• Montante Final: R\$ ${montanteFinal!.toStringAsFixed(2)}
• Total Investido: R\$ ${totalInvestido!.toStringAsFixed(2)}
• Lucro Obtido: R\$ ${lucro!.toStringAsFixed(2)}
• Situação da Meta: $situacaoMeta
• Perfil Financeiro: $perfilFinanceiro''';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        resultadoTexto,
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}