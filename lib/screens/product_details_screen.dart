import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rigel_application/helpers/database_helper_shoppingcar.dart';
import 'package:rigel_application/models/shoppingcar_model.dart';
import 'package:rigel_application/reusable_widgets/card_product_details.dart';
import 'package:rigel_application/screens/home_screen.dart';
import 'package:favorite_button/favorite_button.dart';
import '../helpers/database_helper_products.dart';
import '../models/product_model.dart';
import 'package:quantity_input/quantity_input.dart';
import 'shopping_car_screen.dart';

class ProductDetails extends StatefulWidget {
  final String productTitle;

  ProductDetails({Key? key, required this.productTitle}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int productQuantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      appBar: AppBar(
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
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<List<Product>>(
              future:
                  DatabaseHelper.instance.getOneProduct(widget.productTitle),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text("Loading...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20)),
                    ),
                  );
                } else {
                  return snapshot.data!.isEmpty
                      ? Center(
                          child: Container(
                              child: const Text("No products",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20))))
                      : Container(
                          child: ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: snapshot.data!.map(
                                (product) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image(
                                                  image: NetworkImage(
                                                      product.imagepath),
                                                  width: 400,
                                                  height: 300,
                                                )),
                                            Text(product.title,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24)),
                                            Row(
                                              children: [
                                                Flexible(
                                                    child: Text(
                                                  product.description,
                                                  maxLines: 3,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                                RatingBar.builder(
                                                    itemSize: 20,
                                                    initialRating: product
                                                        .ranking
                                                        .toDouble(),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(Icons.star,
                                                            color:
                                                                Colors.white),
                                                    onRatingUpdate:
                                                        (rating) {}),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            const Text("Capacity",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                CardDetails(
                                                    detailItem: "Calories",
                                                    infoItem: product.calories),
                                                CardDetails(
                                                    detailItem: "Vitamines",
                                                    infoItem:
                                                        product.vitamines),
                                                CardDetails(
                                                    detailItem: "Aditives",
                                                    infoItem: product.aditives)
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            // ignore: prefer_const_constructors
                                          ],
                                        ),
                                      ),
                                      Card(
                                        color: Colors.white,
                                        // ignore: prefer_const_constructors
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.white),
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25),
                                                bottomLeft: Radius.circular(25),
                                                bottomRight:
                                                    Radius.circular(25))),
                                        child: SizedBox(
                                            height: 170,
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Quantity (g)"),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(children: [
                                                    QuantityInput(
                                                        buttonColor:
                                                            Colors.black,
                                                        acceptsZero: false,
                                                        minValue: 1,
                                                        value: productQuantity,
                                                        onChanged: (value) => setState(
                                                            () => productQuantity =
                                                                int.parse(value
                                                                    .replaceAll(
                                                                        ',',
                                                                        '')))),
                                                    Spacer(),
                                                    Text(
                                                      "\$${product.price}",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    )
                                                  ]),
                                                  SizedBox(height: 15),
                                                  Row(
                                                    children: [
                                                      FloatingActionButton
                                                          .extended(
                                                              onPressed:
                                                                  () async {
                                                                DatabaseHelper_ShoppingC.instance.addShoppingC(ShoppingCar(
                                                                    price: product
                                                                        .price,
                                                                    title: product
                                                                        .title,
                                                                    quantity:
                                                                        productQuantity,
                                                                    imagepath:
                                                                        product
                                                                            .imagepath));
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => ShoppingCarScreen(
                                                                            ProductPrice: product
                                                                                .price,
                                                                            productQuantity:
                                                                                productQuantity,
                                                                            ProductName:
                                                                                product.title)));
                                                              },
                                                              label: const Text(
                                                                  "Add to the car",
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
                                      Card(
                                        color: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.black),
                                            borderRadius: const BorderRadius
                                                    .only(
                                                topLeft: Radius.circular(25),
                                                topRight: Radius.circular(25),
                                                bottomLeft: Radius.circular(25),
                                                bottomRight:
                                                    Radius.circular(25))),
                                        child: SizedBox(
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.shopping_bag_outlined,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Car",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Spacer(),
                                                Image(
                                                  image: NetworkImage(
                                                      product.imagepath),
                                                  height: 30,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ).toList()),
                        );
                }
              })
        ],
      ),
    );
  }
}
