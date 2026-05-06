import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tarefa.dart';

class DB {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    final caminhoBanco = await getDatabasesPath();
    final caminho = join(caminhoBanco, 'tarefas.db');

    _database = await openDatabase(
      caminho,
      version: 2,
      onCreate: (db, version) async {
        await _criarTabela(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS tarefas');
        await _criarTabela(db);
      },
    );

    return _database!;
  }

  static Future<void> _criarTabela(Database db) async {
    await db.execute('''
      CREATE TABLE tarefas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT NOT NULL,
        dataPrevista TEXT NOT NULL,
        importante INTEGER NOT NULL,
        realizada INTEGER NOT NULL,
        categoria TEXT NOT NULL
      )
    ''');
  }

  static Future<void> inserirTarefa(Tarefa tarefa) async {
    final db = await getDatabase();
    await db.insert('tarefas', tarefa.toMap());
  }

  static Future<List<Tarefa>> buscarTarefas() async {
    final db = await getDatabase();

    final dados = await db.query(
      'tarefas',
      orderBy: 'dataPrevista ASC',
    );

    return dados.map((item) {
      return Tarefa.fromMap(item);
    }).toList();
  }

  static Future<void> editarTarefa(Tarefa tarefa) async {
    final db = await getDatabase();

    await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  static Future<void> excluirTarefa(int id) async {
    final db = await getDatabase();

    await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> realizarTarefa(int id) async {
    final db = await getDatabase();

    await db.update(
      'tarefas',
      {'realizada': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}