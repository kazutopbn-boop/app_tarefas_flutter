import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../componentes/tarefa_card.dart';
import '../models/tarefa.dart';
import '../providers/tarefa_provider.dart';
import '../util/rotas.dart';

class TelaLista extends StatelessWidget {
  const TelaLista({super.key});

  List<Tarefa> _filtrar(List<Tarefa> tarefas, int index) {
    if (index == 1) {
      return tarefas.where((t) => t.importante).toList();
    }

    if (index == 2) {
      return tarefas.where((t) => !t.importante).toList();
    }

    if (index == 3) {
      return tarefas.where((t) => t.realizada).toList();
    }

    if (index == 4) {
      return tarefas.where((t) => !t.realizada).toList();
    }

    if (index == 5) {
      return tarefas.where((t) => t.atrasada).toList();
    }

    return tarefas;
  }

  @override
  Widget build(BuildContext context) {
    final tarefas = Provider.of<TarefaProvider>(context).tarefas;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Tarefas'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Todas'),
              Tab(text: 'Importantes'),
              Tab(text: 'Não importantes'),
              Tab(text: 'Realizadas'),
              Tab(text: 'Pendentes'),
              Tab(text: 'Atrasadas'),
            ],
          ),
        ),
        body: TabBarView(
          children: List.generate(6, (index) {
            final filtradas = _filtrar(tarefas, index);

            if (filtradas.isEmpty) {
              return const Center(
                child: Text('Nenhuma tarefa encontrada.'),
              );
            }

            return ListView.builder(
              itemCount: filtradas.length,
              itemBuilder: (context, i) {
                final tarefa = filtradas[i];

                return TarefaCard(
                  tarefa: tarefa,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Rotas.telaDetalhes,
                      arguments: tarefa,
                    );
                  },
                );
              },
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Rotas.telaCadastro);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}