import 'dart:io';
import 'package:rigel_application/models/shoppingcar_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper_ShoppingC {
  DatabaseHelper_ShoppingC._privateConstructor();
  static final DatabaseHelper_ShoppingC instance =
      DatabaseHelper_ShoppingC._privateConstructor();

  static Database? _database;
  //Metodo asincrono que regresa un Future de tipo Database, si la base de datos no ha sido creada llama al metodo _init..., primera vez que se corre se genera luego ya no
  Future<Database> get database async => _database ??= await _initDatase();

  Future<Database> _initDatase() async {
    //specify a location in your phone to store the data base
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    //directorio donde se guardan los archivos
    String path = join(documentsDirectory.path, 'rigelv6.db');
    //si no existe openDatabase crea la base de datos
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        //single ' tres veces para escribir en multilinea
        '''
      
      CREATE TABLE shoppingCar
      (
        id INTEGER PRIMARY KEY,
        title TEXT,
        price INTEGER,
        quantity INTEGER,
        imagepath TEXT,
        subtotal INTEGER,
        TOTAL INTEGER
      )

      
      
      ''');
  }

  Future<List<ShoppingCar>> getShoppingC() async {
    Database db = await instance.database;
    var shoppingCquery = await db.query('shoppingCar', orderBy: 'title');

    //si no es empty ? (entonces)... has esto :(else) si no se cumple regresame la lista vacia
    //Ternalia dicen
    List<ShoppingCar> shoppingCList = shoppingCquery.isNotEmpty
        ? shoppingCquery.map((e) => ShoppingCar.fromMap(e)).toList()
        : [];
    return shoppingCList;
  }

  Future<List<ShoppingCar>> getShoppingCOneProduct(id) async {
    Database db = await instance.database;
    var shoppingCquery = await db.query('shoppingCar',
        where: 'id = ?', whereArgs: [id], limit: 1);

    //si no es empty ? (entonces)... has esto :(else) si no se cumple regresame la lista vacia
    //Ternalia dicen
    List<ShoppingCar> shoppingCList = shoppingCquery.isNotEmpty
        ? shoppingCquery.map((e) => ShoppingCar.fromMap(e)).toList()
        : [];
    return shoppingCList;
  }

  Future<int> addShoppingC(ShoppingCar shoppingCar) async {
    //esperar hasta la conección
    Database db = await instance.database;
    return await db.insert('shoppingCar', shoppingCar.toMap());
  }

  Future<int> deleteShoppingC(int id) async {
    Database db = await instance.database;
    return await db.delete('shoppingCar', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateShoppingC(ShoppingCar shoppingCar) async {
    Database db = await instance.database;
    return await db.update('shoppingCar', shoppingCar.toMap(),
        where: 'id = ?', whereArgs: [shoppingCar.id]);
  }

  Future<int?> countItems() async {
    Database db = await instance.database;
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM shoppingCar'));

    return count;
  }

  Future calculateTotal() async {
    Database db = await instance.database;
    var result =
        await db.rawQuery('SELECT SUM(subtotal) AS TOTAL FROM shoppingCar');

    return result.toList();
  }
}
