class Product {
  //int id
  final int? id;
  final String category;
  final int price;
  final int ranking;
  final String title;
  final String description;
  final String calories;
  final String aditives;
  final String vitamines;
  final String imagepath;

//no importa el orden en el que se pasen los parametros
  //required this.id, ver como le puedo quitar el id
  Product(
      {this.id,
      required this.category,
      required this.price,
      required this.ranking,
      required this.title,
      required this.description,
      required this.calories,
      required this.aditives,
      required this.vitamines,
      required this.imagepath});

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      id: json['id'],
      category: json['category'],
      price: json['price'],
      ranking: json['ranking'],
      title: json['title'],
      description: json['description'],
      calories: json['calories'],
      aditives: json['aditives'],
      vitamines: json['vitamines'],
      imagepath: json['imagepath']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'price': price,
      'ranking': ranking,
      'title': title,
      'description': description,
      'calories': calories,
      'aditives': aditives,
      'vitamines': vitamines,
      'imagepath': imagepath
    };
  }
}
