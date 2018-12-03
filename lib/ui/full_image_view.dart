import 'package:flutter/material.dart';

class FullImageView extends StatelessWidget {
  String imageURL;
  String name;

  FullImageView(this.name,this.imageURL);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Container(
        color: Colors.black38,
        child: Image.network(imageURL,
          fit: BoxFit.contain,
          height:
          double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }


}
