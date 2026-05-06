import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tarefa.dart';
import '../providers/tarefa_provider.dart';
import '../util/rotas.dart';

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefa = ModalRoute.of(context)!.settings.arguments as Tarefa;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tarefa.titulo,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Descrição: ${tarefa.descricao}'),
                const SizedBox(height: 8),
                Text('Data prevista: ${tarefa.dataPrevista}'),
                const SizedBox(height: 8),
                Text('Importante: ${tarefa.importante ? 'Sim' : 'Não'}'),
                const SizedBox(height: 8),
                Text('Realizada: ${tarefa.realizada ? 'Sim' : 'Não'}'),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            Rotas.telaCadastro,
                            arguments: tarefa,
                          );
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Editar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await Provider.of<TarefaProvider>(
                            context,
                            listen: false,
                          ).excluirTarefa(tarefa.id!);

                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Excluir'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
