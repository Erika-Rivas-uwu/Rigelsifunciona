class ShoppingCar {
  //int id
  final int? id;
  final String title;
  final int price;
  final int quantity;
  final String imagepath;
  var subtotal;

//no importa el orden en el que se pasen los parametros
  //required this.id, ver como le puedo quitar el id
  ShoppingCar(
      {this.id,
      required this.price,
      required this.title,
      required this.quantity,
      required this.imagepath,
      this.subtotal});

  factory ShoppingCar.fromMap(Map<String, dynamic> json) => ShoppingCar(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      quantity: json['quantity'],
      imagepath: json['imagepath'],
      subtotal: json['subtotal']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'title': title,
      'quantity': quantity,
      'imagepath': imagepath,
      'subtotal': price * quantity
    };
  }
}
