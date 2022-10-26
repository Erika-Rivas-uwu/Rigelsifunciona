import 'dart:io';
import 'package:rigel_application/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  //Metodo asincrono que regresa un Future de tipo Database, si la base de datos no ha sido creada llama al metodo _init..., primera vez que se corre se genera luego ya no
  Future<Database> get database async => _database ??= await _initDatase();

  Future<Database> _initDatase() async {
    //specify a location in your phone to store the data base
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print("--------Printing app directory-------------------------");
    print(documentsDirectory);
    //directorio donde se guardan los archivos
    String path = join(documentsDirectory.path, 'rigelv2.db');
    //si no existe openDatabase crea la base de datos
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print("Get Into CreateDatabase--------------------");
    await db.execute(
        //single ' tres veces para escribir en multilinea
        '''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY,
        category TEXT,
        price  INTEGER,
        ranking INTEGER,
        title TEXT,
        description TEXT,
        calories TEXT,
        aditives TEXT,
        vitamines TEXT,
        imagepath TEXT
      )
      
      ''');
    print("Table created!---");
  }

  Future<List<Product>> getProducts() async {
    Database db = await instance.database;
    var productquery = await db.query('products', orderBy: 'title');

    //si no es empty ? (entonces)... has esto :(else) si no se cumple regresame la lista vacia
    //Ternalia dicen
    List<Product> productList = productquery.isNotEmpty
        ? productquery.map((e) => Product.fromMap(e)).toList()
        : [];
    return productList;
  }

  Future<List<Product>> getProductsCategory(String Selectedcategory) async {
    print("getProduct by its category-.----------------");
    print(Selectedcategory);
    Database db = await instance.database;
    print(db);
    var productquery = await db.query('products',
        orderBy: 'title', where: 'category = ?', whereArgs: [Selectedcategory]);
    print(productquery);

    //si no es empty ? (entonces)... has esto :(else) si no se cumple regresame la lista vacia
    //Ternalia dicen
    List<Product> productList = productquery.isNotEmpty
        ? productquery.map((e) => Product.fromMap(e)).toList()
        : [];
    return productList;
  }

  Future<List<Product>> getOneProduct(String title) async {
    Database db = await instance.database;
    var productquery =
        await db.query('products', where: 'title = ?', whereArgs: [title]);

    //si no es empty ? (entonces)... has esto :(else) si no se cumple regresame la lista vacia
    //Ternalia dicen
    List<Product> productList = productquery.isNotEmpty
        ? productquery.map((e) => Product.fromMap(e)).toList()
        : [];
    return productList;
  }

  Future<int> addProduct(Product product) async {
    //esperar hasta la conexión
    Database db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<int> updateProducts(Product product) async {
    Database db = await instance.database;
    return await db.update('products', product.toMap(),
        where: 'id = ?', whereArgs: [product.id]);
  }
}
