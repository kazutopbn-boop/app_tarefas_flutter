import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tarefa_provider.dart';
import '../util/rotas.dart';

class TelaInicio extends StatelessWidget {
  const TelaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarefaProvider>(context);
    final proxima = provider.proximaTarefa;

    return Scaffold(
      appBar: AppBar(
        title: const Text('App de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.task_alt, size: 60),
                  const SizedBox(height: 16),
                  const Text(
                    'Bem-vindo ao App de Tarefas',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  if (proxima == null)
                    const Text('Nenhuma tarefa pendente cadastrada.')
                  else
                    Column(
                      children: [
                        const Text(
                          'Tarefa mais perto de vencer:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(proxima.titulo),
                        Text('Data prevista: ${proxima.dataFormatada}'),
                      ],
                    ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Rotas.telaLista);
                    },
                    icon: const Icon(Icons.list),
                    label: const Text('Ver tarefas'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}