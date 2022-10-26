import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rigel_application/helpers/database_helper_products.dart';
import 'package:rigel_application/models/product_model.dart';
import 'package:rigel_application/screens/home_screen.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var dropDownValueGlobal = "[Unselected Category]";
  var itemsCategory = ['[Unselected Category]', 'Cookies', 'Fruit'];
  final textControllerTitle = TextEditingController();

  //final textControllerCategory = TextEditingController();
  final textControllerPrice = TextEditingController();
  final textControllerDescription = TextEditingController();
  final textControllerCalories = TextEditingController();
  final textControllerAditives = TextEditingController();
  final textControllerVitaminas = TextEditingController();
  final textControllerImagePath = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int ratingvalue = 5;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        title: Text(
          "Add a new Product",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            TextFormField(
                controller: textControllerTitle,
                decoration: const InputDecoration(
                    icon: Icon(Icons.abc_sharp),
                    labelText: "Input the product title")),
            TextFormField(
                controller: textControllerDescription,
                decoration: const InputDecoration(
                    icon: Icon(Icons.abc_sharp),
                    labelText: "Input the product description")),
            DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                items: itemsCategory.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                value: dropDownValueGlobal,
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValueGlobal = newValue!;
                  });
                }),
            SizedBox(height: 10),
            Text(
              "Rating",
              style: TextStyle(color: Colors.grey),
            ),
            RatingBar.builder(
                itemSize: 25,
                initialRating: 1,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.orange),
                onRatingUpdate: (rating) {
                  ratingvalue = rating.toInt();
                }),
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Write the Price';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: textControllerPrice,
                decoration: const InputDecoration(
                    icon: Icon(Icons.attach_money),
                    labelText: "Input the product price")),
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Write the Calories';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: textControllerCalories,
                decoration: const InputDecoration(
                    icon: Icon(Icons.food_bank),
                    labelText: "Input the product calories")),
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Write the Aditives';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: textControllerAditives,
                decoration: const InputDecoration(
                    icon: Icon(Icons.add),
                    labelText: "Input the product aditives")),
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Write the Vitamines';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: textControllerVitaminas,
                decoration: const InputDecoration(
                    icon: Icon(Icons.check),
                    labelText: "Input the product vitamines")),
            TextFormField(
                controller: textControllerImagePath,
                decoration: const InputDecoration(
                    icon: Icon(Icons.image),
                    labelText: "Input the product image link")),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
                label: const Text("Save the new product",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                backgroundColor: Colors.orange[300],
                icon: const Icon(
                  Icons.save_alt_rounded,
                  size: 25.0,
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (dropDownValueGlobal == "[Unselected Category]" ||
                      textControllerPrice.text == "" ||
                      textControllerTitle.text == "" ||
                      textControllerCalories.text == "" ||
                      textControllerAditives.text == "" ||
                      textControllerVitaminas.text == "" ||
                      textControllerImagePath.text == "") {
                    print("----- You need to add something xdxd");

                    final snackBar = SnackBar(
                      content:
                          const Text('One or more fields might be empty...'),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    DatabaseHelper.instance.addProduct(Product(
                        category: dropDownValueGlobal,
                        price: int.parse(textControllerPrice.text),
                        ranking: ratingvalue,
                        title: textControllerTitle.text,
                        description: textControllerDescription.text,
                        calories: textControllerCalories.text,
                        aditives: textControllerAditives.text,
                        vitamines: textControllerVitaminas.text,
                        imagepath: textControllerImagePath.text));
                    setState(() {
                      print("------Created new Product------");
                      print(textControllerPrice.text);
                      print(dropDownValueGlobal);
                      print(textControllerAditives.text);
                      print(textControllerCalories.text);
                      print(textControllerDescription.text);
                      print(textControllerImagePath.text);
                      print(textControllerTitle.text);
                      print(textControllerVitaminas.text);
                      textControllerPrice.clear();
                      dropDownValueGlobal = '[Unselected Category]';
                      textControllerAditives.clear();
                      textControllerCalories.clear();
                      textControllerDescription.clear();
                      textControllerImagePath.clear();
                      textControllerTitle.clear();
                      textControllerVitaminas.clear();
                    });
                    final snackBar = SnackBar(
                      content: const Text('Product Added'),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            SizedBox(height: 5),
            FutureBuilder<List<Product>>(
                future: DatabaseHelper.instance.getProducts(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Product>> snapshot) {
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
                            child: Container(child: const Text("No products")))
                        : ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!.map(
                              (product) {
                                return Center(
                                  child: Card(
                                      child: ListTile(
                                    title: Text(
                                        'Title: ${product.title}, Category: ${product.category}'),
                                  )),
                                );
                              },
                            ).toList());
                  }
                })
          ],
        ),
      ),
    );
  }
}
