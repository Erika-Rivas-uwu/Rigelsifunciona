import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:rigel_application/models/shoppingcar_model.dart';
import 'package:rigel_application/helpers/database_helper_shoppingcar.dart';
import 'package:rigel_application/screens/product_details_screen.dart';

class ShoppingCarScreen extends StatefulWidget {
  late final int productQuantity;
  final int ProductPrice;
  final String ProductName;

  ShoppingCarScreen(
      {Key? key,
      required this.productQuantity,
      required this.ProductName,
      required this.ProductPrice})
      : super(key: key);
  @override
  State<ShoppingCarScreen> createState() => _ShoppingCarScreenState();
}

class _ShoppingCarScreenState extends State<ShoppingCarScreen> {
  double subtotal = 0;
  var total;
  int? shoppingId = 1;

  int newQuantity = 0;
  String pName = "Update a product";

  bool showUpdate = false;

  double subsub = 0;
  var listasub = [];
  int large = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(45))),
          backgroundColor: Colors.orange[300],
          toolbarHeight: 75,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(
                            productTitle: widget.ProductName.toString(),
                          )));
            },
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Cart",
                          style: TextStyle(color: Colors.white, fontSize: 20))
                    ],
                  )),
              FutureBuilder<List<ShoppingCar>>(
                  future: DatabaseHelper_ShoppingC.instance.getShoppingC(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ShoppingCar>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text("Loading..."),
                        ),
                      );
                    } else {
                      return snapshot.data!.isEmpty
                          ? Center(
                              child:
                                  Container(child: const Text("No products")))
                          : ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: snapshot.data!.map(
                                (shoppingcar) {
                                  shoppingcar.subtotal =
                                      shoppingcar.price * shoppingcar.quantity;

                                  shoppingId = shoppingcar.id;
                                  return Column(
                                    children: [
                                      Container(
                                        child: Row(children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Image(
                                              image: NetworkImage(shoppingcar
                                                  .imagepath
                                                  .toString()),
                                              width: 90),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  shoppingcar.title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "Subtotal ${shoppingcar.subtotal!.toStringAsFixed(2)}",
                                                    style: (TextStyle(
                                                        color: Colors.white)))
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                "x ${shoppingcar.quantity}",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          DatabaseHelper_ShoppingC
                                                              .instance
                                                              .deleteShoppingC(
                                                                  shoppingcar
                                                                      .id!);
                                                          setState() {
                                                            subsub = subsub -
                                                                shoppingcar
                                                                    .subtotal!;
                                                            large = large - 1;
                                                          }

                                                          ;
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      super
                                                                          .widget));
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                        color: Colors.white,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          showUpdate = true;
                                                          shoppingId =
                                                              shoppingcar.id;
                                                        });
                                                      },
                                                      icon: Icon(Icons.update,
                                                          color: Colors.white,
                                                          size: 20))
                                                ],
                                              )
                                            ],
                                          )
                                        ]),
                                      ),
                                    ],
                                  );
                                },
                              ).toList());
                    }
                  }),
              SizedBox(height: 25),
              FutureBuilder<List<ShoppingCar>>(
                  future: DatabaseHelper_ShoppingC.instance
                      .getShoppingCOneProduct(shoppingId),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ShoppingCar>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text("Loading..."),
                        ),
                      );
                    } else {
                      return snapshot.data!.isEmpty
                          ? Center(
                              child:
                                  Container(child: const Text("No products")))
                          : ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: snapshot.data!.map(
                                (shoppingcar) {
                                  return Visibility(
                                    visible: showUpdate,
                                    child: Card(
                                      color: Colors.white,
                                      // ignore: prefer_const_constructors
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.white),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                              bottomLeft: Radius.circular(25),
                                              bottomRight:
                                                  Radius.circular(25))),
                                      child: SizedBox(
                                          height: 170,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("${shoppingcar.title}"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(children: [
                                                  QuantityInput(
                                                      buttonColor: Colors.black,
                                                      acceptsZero: false,
                                                      minValue: 1,
                                                      value: newQuantity,
                                                      onChanged: (value) =>
                                                          setState(() =>
                                                              newQuantity =
                                                                  int.parse(
                                                                      value))),
                                                  Spacer(),
                                                  Text(
                                                    "\$${shoppingcar.price}",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )
                                                ]),
                                                SizedBox(height: 15),
                                                Row(
                                                  children: [
                                                    FloatingActionButton
                                                        .extended(
                                                            heroTag: "btn2",
                                                            onPressed:
                                                                () async {
                                                              //DUDAS Si hay dos objetos en la base de datos se actualiza el segundo
                                                              DatabaseHelper_ShoppingC.instance.updateShoppingC(ShoppingCar(
                                                                  price: shoppingcar
                                                                      .price
                                                                      .toInt(),
                                                                  title:
                                                                      shoppingcar
                                                                          .title,
                                                                  quantity:
                                                                      newQuantity,
                                                                  id: shoppingcar
                                                                      .id,
                                                                  imagepath:
                                                                      shoppingcar
                                                                          .imagepath));

                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          super
                                                                              .widget));
                                                            },
                                                            label: const Text(
                                                                "Update",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12)),
                                                            backgroundColor:
                                                                Colors.orange[
                                                                    200]),
                                                    Spacer(),
                                                    FavoriteButton(
                                                      iconSize: 30,
                                                      isFavorite: true,
                                                      // iconDisabledColor: Colors.white,
                                                      valueChanged:
                                                          (_isFavorite) {
                                                        print(
                                                            'Is Favorite : $_isFavorite');
                                                      },
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  );
                                },
                              ).toList());
                    }
                  })
            ]),
            SizedBox(height: 15),
            Card(
                // ignore: prefer_const_constructors
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      SizedBox(
                        width: 300,
                        height: 24,
                        child: FutureBuilder<List<ShoppingCar>>(
                            future: DatabaseHelper_ShoppingC.instance
                                .getShoppingC(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ShoppingCar>> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: const Text(""),
                                  ),
                                );
                              } else {
                                return snapshot.data!.isEmpty
                                    ? Center(
                                        child: Container(child: const Text("")))
                                    : ListView(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        children: snapshot.data!.map(
                                          (shoppingcar) {
                                            var list = [];
                                            shoppingcar
                                                .toMap()
                                                .forEach((key, value) {
                                              list.add(shoppingcar.subtotal);
                                            });
                                            print(list);
                                            subsub = list.first + subsub;
                                            print(subsub);

                                            listasub.add(subsub);

                                            large = listasub.length;
                                            print(large);
                                            return FutureBuilder<
                                                    List<ShoppingCar>>(
                                                future: DatabaseHelper_ShoppingC
                                                    .instance
                                                    .getShoppingCOneProduct(
                                                        shoppingId),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            List<ShoppingCar>>
                                                        snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: const Text(""),
                                                      ),
                                                    );
                                                  } else {
                                                    return snapshot
                                                            .data!.isEmpty
                                                        ? Center(
                                                            child: Container(
                                                                child:
                                                                    const Text(
                                                                        "")))
                                                        : ListView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            shrinkWrap: true,
                                                            children: snapshot
                                                                .data!
                                                                .map(
                                                              (shoppingcar) {
                                                                return Row(
                                                                    children: [
                                                                      Text(
                                                                          "Items: $large"),
                                                                      Spacer(),
                                                                      Text(
                                                                          "Total Price: \$${subsub.toStringAsFixed(2)}"),
                                                                    ]);
                                                              },
                                                            ).toList());
                                                  }
                                                });
                                          },
                                        ).toList());
                              }
                            }),
                      ),
                      SizedBox(width: 10),
                      FloatingActionButton.extended(
                          heroTag: "btn1",
                          onPressed: () {},
                          label: const Text("Buy",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                          backgroundColor: Colors.orange[200]),
                    ]),
                  ),
                ))
          ],
        ));
  }
}
