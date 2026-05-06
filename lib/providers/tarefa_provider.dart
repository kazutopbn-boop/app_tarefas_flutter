import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../util/db.dart';

class TarefaProvider with ChangeNotifier {
  List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas {
    return [..._tarefas];
  }

  TarefaProvider() {
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    final db = await DB.getDatabase();

    final dados = await db.query('tarefas');

    _tarefas = dados.map((item) {
      return Tarefa.fromMap(item);
    }).toList();

    notifyListeners();
  }

  Future<void> adicionarTarefa(Tarefa tarefa) async {
    final db = await DB.getDatabase();

    await db.insert('tarefas', tarefa.toMap());

    await carregarTarefas();
  }

  Future<void> editarTarefa(Tarefa tarefa) async {
    final db = await DB.getDatabase();

    await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );

    await carregarTarefas();
  }

  Future<void> excluirTarefa(int id) async {
    final db = await DB.getDatabase();

    await db.delete('tarefas', where: 'id = ?', whereArgs: [id]);

    await carregarTarefas();
  }
}
