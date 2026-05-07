import 'package:flutter/material.dart';

import '../models/tarefa.dart';

class TarefaCard extends StatelessWidget {
  final Tarefa tarefa;
  final VoidCallback onTap;

  const TarefaCard({
    super.key,
    required this.tarefa,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: onTap,
        title: Text(tarefa.titulo),
        subtitle: Text(
          'Data prevista: ${tarefa.dataFormatada}\nCategoria: ${tarefa.categoria}',
        ),
        leading: Icon(
          tarefa.realizada ? Icons.check_circle : Icons.radio_button_unchecked,
          color: tarefa.realizada ? Colors.green : Colors.grey,
        ),
        trailing: tarefa.importante
            ? const Icon(Icons.priority_high, color: Colors.red)
            : null,
      ),
    );
  }
}