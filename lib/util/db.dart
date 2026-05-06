import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tarefas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT NOT NULL,
            descricao TEXT NOT NULL,
            dataPrevista TEXT NOT NULL,
            importante INTEGER NOT NULL,
            realizada INTEGER NOT NULL
          )
        ''');
      },
    );

    return _database!;
  }
}
