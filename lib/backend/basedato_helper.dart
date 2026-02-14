import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('ocean_eyes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Tabla reportes
    await db.execute('''
    CREATE TABLE reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      dni TEXT NOT NULL,
      is_anonymous INTEGER NOT NULL,
      step TEXT,
      created_at TEXT
    )
    ''');
  }

  Future<int> createReport(String dni, bool isAnonymous) async {
    final db = await instance.database;
    final data = {
      'dni': dni,
      'is_anonymous': isAnonymous ? 1 : 0, //Simulamos un booleano con un entero
      'step': 'camera_capture',
      'created_at': DateTime.now().toIso8601String(),
    };
    return await db.insert('reports', data);
  }
  Future<List<Map<String, dynamic>>> getReports() async {
    final db = await instance.database;
    return await db.query('reports', orderBy: 'created_at DESC'); 
  }
}
