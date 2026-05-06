import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../util/db.dart';

class TarefaProvider with ChangeNotifier {
  List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas {
    return [..._tarefas];
  }

  Tarefa? get proximaTarefa {
    final pendentes = _tarefas.where((t) => !t.realizada).toList();

    if (pendentes.isEmpty) {
      return null;
    }

    pendentes.sort((a, b) => a.data.compareTo(b.data));
    return pendentes.first;
  }

  TarefaProvider() {
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    _tarefas = await DB.buscarTarefas();
    notifyListeners();
  }

  Future<void> adicionarTarefa(Tarefa tarefa) async {
    await DB.inserirTarefa(tarefa);
    await carregarTarefas();
  }

  Future<void> editarTarefa(Tarefa tarefa) async {
    await DB.editarTarefa(tarefa);
    await carregarTarefas();
  }

  Future<void> excluirTarefa(int id) async {
    await DB.excluirTarefa(id);
    await carregarTarefas();
  }

  Future<void> realizarTarefa(int id) async {
    await DB.realizarTarefa(id);
    await carregarTarefas();
  }
}