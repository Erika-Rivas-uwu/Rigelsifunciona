import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rigel_application/helpers/database_helper_products.dart';
import 'package:rigel_application/screens/add_product_screen.dart';
import 'package:rigel_application/screens/product_details_screen.dart';
import '../models/product_model.dart';
import '../reusable_widgets/galerie_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String SelectedCategory = "Cookies";
  String ProductName = "Galletas Solidarias";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 230, 230),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Row(children: const [
                  Icon(Icons.menu, size: 40),
                  Spacer(),
                  Icon(Icons.shopping_bag, size: 35)
                ]),
                const SizedBox(height: 30),
                const Text("Hello"),
                const Text("What today's taste?",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              SelectedCategory = "Cookies";
                            });
                          },
                          child: Icon(
                            Icons.cookie_sharp,
                            color: Colors.grey[200],
                            size: 30,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.orange[200],
                          ),
                        ),
                        Text("Cookies"),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              SelectedCategory = "Fruit";
                              print(SelectedCategory);
                            });
                          },
                          child: Icon(
                            Icons.apple_sharp,
                            color: Colors.grey[200],
                            size: 30,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.orange[200],
                          ),
                        ),
                        const Text("Fruit"),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.search,
                      size: 40,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orange[300]),
                      child: FutureBuilder<List<Product>>(
                          future: DatabaseHelper.instance
                              .getOneProduct(ProductName),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Product>> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: const Text("Product list is empty",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20)),
                                ),
                              );
                            } else {
                              return snapshot.data!.isEmpty
                                  ? Center(
                                      child: Container(
                                          child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image(
                                              image: NetworkImage(
                                                  "https://i.pinimg.com/564x/bc/8d/10/bc8d10c875e56cfff230deb1db105c72.jpg"),
                                              height: 260,
                                            )),
                                        const Text("Select a product",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ],
                                    )))
                                  : ListView(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      children: snapshot.data!.map(
                                        (product) {
                                          return Row(
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(height: 10),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image(
                                                      image: NetworkImage(
                                                          product.imagepath),
                                                      height: 250.0,
                                                      width: 180,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            product.title
                                                                .replaceAll(
                                                                    " ", "\n"),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 22)),
                                                        Text(
                                                            product.price
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20)),
                                                        const SizedBox(
                                                            height: 10),
                                                        RatingBar.builder(
                                                            itemSize: 25,
                                                            initialRating:
                                                                product.ranking
                                                                    .toDouble(),
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            itemCount: 5,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        2.0),
                                                            itemBuilder: (context,
                                                                    _) =>
                                                                const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .white),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              print(rating);
                                                            }),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        FloatingActionButton
                                                            .extended(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ProductDetails(productTitle: product.title)));
                                                                },
                                                                label: const Text(
                                                                    "Add to the car",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                    )),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .shopping_cart,
                                                                  size: 20.0,
                                                                  color: Colors
                                                                      .black,
                                                                ))
                                                      ]))
                                            ],
                                          );
                                        },
                                      ).toList());
                            }
                          }),
                    ),
                  ],
                ),
                //SizedBox(
                //  height: 30,
                //),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FutureBuilder<List<Product>>(
                          future: DatabaseHelper.instance
                              .getProductsCategory(SelectedCategory),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Product>> snapshot) {
                            print(
                                "We are inside the thing that shows products if there are----");
                            print(DatabaseHelper.instance
                                .getProductsCategory(SelectedCategory));
                            if (!snapshot.hasData) {
                              return Center(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: const Text("Loading... no hay unu",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20)),
                                ),
                              );
                            } else {
                              print(
                                  "--- This is the case we have data------ si hay uwu");
                              return snapshot.data!.isEmpty
                                  ? Center(
                                      child: Container(
                                          child: const Text("No products",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20))))
                                  : Container(
                                      height: 120,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          children: snapshot.data!.map(
                                            (product) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    width: 90,
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Colors.orange[300]),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          ProductName =
                                                              product.title;
                                                        });
                                                        print(
                                                            "**************************** get some details from products*******************");
                                                        print(product.category);
                                                      },
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image(
                                                            image: NetworkImage(
                                                                product
                                                                    .imagepath),
                                                            width: 110,
                                                          )),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape: CircleBorder(),
                                                        shadowColor:
                                                            Colors.transparent,
                                                        primary:
                                                            Colors.transparent,
                                                      ),
                                                    )),
                                              );
                                            },
                                          ).toList()),
                                    );
                            }
                          }),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProductScreen()));
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 30,
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            primary: Colors.white,
                            side: BorderSide(width: 3.0, color: Colors.grey)),
                      )
                    ],
                  ),
                )
              ]),
        ));
  }
}
