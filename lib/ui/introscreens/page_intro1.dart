import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  Color backgroundColor;
  String centerText;

  Page1(this.backgroundColor, this.centerText);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return new Container(
      height: double.infinity,
      width: double.infinity,
      color: backgroundColor,
      child: Stack(
        children: <Widget>[
          Text(
            centerText,
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          )
        ],
        alignment: FractionalOffset.center,
      ),
    );
  }
}
