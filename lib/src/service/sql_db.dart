// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages

import 'package:cassiere/src/models/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

// class ProductSQLService {
//   Database? _db;

//   Future<Database> initDB() async {
//     final db = _db;
//     if (db != null) return _db!;

//     return await _open();
//   }

//   Future _open() async {
//     final docsPath = await getApplicationSupportDirectory();
//     final dbPath = join(docsPath.path, dbName);
//     return openDatabase(dbPath, onCreate: _onCreate);
//   }

//   Future _onCreate(Database db, int vesion) async {
//     await db.execute(createProductTable);
//   }

//   Future<void> close() async {
//     await _db!.close();
//   }

//   Future<List<ProductModel>?> getAllProducts() async {
//     final database = await _db?.query(productTable);
//     List<ProductModel>? result =
//         database?.map((item) => ProductModel.fromMap(item)).toList();
//     return result;
//   }

//   Future<int?> insert(Map<String, dynamic> row) async {
//     final query = await _db?.insert(productTable, row);
//     return query;
//   }

//   Future<int> deleteProduct(int id) async {
//     return await _db!
//         .delete(productTable, where: "$idColumn = ? ", whereArgs: [id]);
//   }
// }

class SQLService {
  static final instance = SQLService._();
  SQLService._();

  static Database? _db;

  Future<Database> get database async {
    _db ??= await _openDB();
    return _db!;
  }

  Future<Database> _openDB() async {
    final docsPath = await getApplicationSupportDirectory();
    final dbPath = join(docsPath.path, "product.db");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
      onOpen: _onOpen,
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  Future _onCreate(Database db, int version) async {
    await _db!.execute('''CREATE TABLE product (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        price REAL,
        description TEXT,
        image TEXT
        )''');
  }

  Future _onOpen(Database db) async {
    // Database is open, print its version
    print('----db version--- ${await db.getVersion()}');
  }

  Future create(ProductModel product) async {
    final db = await instance.database;
    final query = await db.insert(
      "product",
      product.toMap(),
    );
    print("---create table---");
    return query;
  }

  Future<ProductModel> read(int id) async {
    final db = await instance.database;
    final maps = await db.query("product",
        columns: ProductField.values,
        where: "${ProductField.idColumn} = ?",
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ProductModel.fromMap(maps.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  // Future<List<ProductModel>> readAllProduct() async {
  //   final db = await instance.database;
  //   final maps = await db.query("product", columns: ProductField.values);
  //   return maps.map((e) => ProductModel.fromMap(e)).toList();
  // }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
