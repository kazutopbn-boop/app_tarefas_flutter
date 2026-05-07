import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../componentes/botao_padrao.dart';
import '../models/tarefa.dart';
import '../providers/tarefa_provider.dart';
import '../util/rotas.dart';

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefa = ModalRoute.of(context)!.settings.arguments as Tarefa;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  tarefa.titulo,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text('ID: ${tarefa.id}'),
                const SizedBox(height: 8),
                Text('Descrição: ${tarefa.descricao}'),
                const SizedBox(height: 8),
                Text('Data prevista: ${tarefa.dataFormatada}'),
                const SizedBox(height: 8),
                Text('Categoria: ${tarefa.categoria}'),
                const SizedBox(height: 8),
                Text('Importante: ${tarefa.importante ? 'Sim' : 'Não'}'),
                const SizedBox(height: 8),
                Text('Realizada: ${tarefa.realizada ? 'Sim' : 'Não'}'),
                const SizedBox(height: 24),
                if (!tarefa.realizada)
                  BotaoPadrao(
                    texto: 'Realizar tarefa',
                    icone: Icons.check,
                    cor: Colors.green,
                    onPressed: () async {
                      await Provider.of<TarefaProvider>(
                        context,
                        listen: false,
                      ).realizarTarefa(tarefa.id!);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                  ),
                if (!tarefa.realizada) const SizedBox(height: 12),
                BotaoPadrao(
                  texto: 'Editar',
                  icone: Icons.edit,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Rotas.telaCadastro,
                      arguments: tarefa,
                    );
                  },
                ),
                const SizedBox(height: 12),
                BotaoPadrao(
                  texto: 'Excluir',
                  icone: Icons.delete,
                  cor: Colors.red,
                  onPressed: () async {
                    await Provider.of<TarefaProvider>(
                      context,
                      listen: false,
                    ).excluirTarefa(tarefa.id!);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}