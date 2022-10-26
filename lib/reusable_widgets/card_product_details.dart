import 'package:flutter/material.dart';

class CardDetails extends StatelessWidget{
  final String detailItem;
  final String infoItem;

  const CardDetails({Key? key, required this.detailItem, required this.infoItem}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return
    Card(
      
      color: Colors.orange[200],
      // ignore: prefer_const_constructors
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
      child: SizedBox(
        height: 80,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(detailItem, style: const TextStyle(color: Colors.white),),
            SizedBox(height:8),
          Text(infoItem,style: const TextStyle(color: Colors.white))
          ]),
        ),
      ),
    );
  }
  
}