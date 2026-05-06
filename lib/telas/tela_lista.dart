import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tarefa.dart';
import '../providers/tarefa_provider.dart';
import '../util/rotas.dart';

class TelaLista extends StatelessWidget {
  const TelaLista({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefas = Provider.of<TarefaProvider>(context).tarefas;

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tarefas')),
      body: tarefas.isEmpty
          ? const Center(child: Text('Nenhuma tarefa cadastrada.'))
          : ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final Tarefa tarefa = tarefas[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(tarefa.titulo),
                    subtitle: Text('Data prevista: ${tarefa.dataPrevista}'),
                    leading: Icon(
                      tarefa.realizada
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: tarefa.realizada ? Colors.green : Colors.grey,
                    ),
                    trailing: tarefa.importante
                        ? const Icon(Icons.priority_high, color: Colors.red)
                        : null,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Rotas.telaDetalhes,
                        arguments: tarefa,
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Rotas.telaCadastro);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
