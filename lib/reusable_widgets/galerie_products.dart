import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../screens/add_product_screen.dart';
class GalleryProduct extends StatelessWidget{
  final String Image_URL;
  final int SelectedProductID;

  const GalleryProduct({Key? key, required this.Image_URL, required this.SelectedProductID}):super (key:key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.orange[300]
        ),
        child: ElevatedButton(
                      onPressed: () {
                        setState(){
                          
                        }
                      },
                      child: Image(image: NetworkImage(Image_URL), width: 110,),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          shadowColor: Colors.transparent,
                          primary: Colors.transparent,
                          ),
                    )
      ),
    );
  }
  
}