import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/account.dart';

class DB {
  // Construtor com acesso privado
  DB._();
  // Criar uma instância de DB
  static final DB instance = DB._();
  // Instancia do SQLite
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'totalpass.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Future<Account> create(Account conta) async {
  //   final db = await instance.database;
  //   final id =
  //       await db.insert('"id", "nome", "login", "senha"', conta.toJson());
  // }

  _onCreate(db, versao) async {
    //await db.execute(_conta);
    await db.execute(_contas);
  }

  String get _contas => ''' 
    CREATE TABLE contas (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      login TEXT,
      senha TEXT
    );
  ''';
}
