import 'package:flutter/material.dart';

class BoxTextField extends StatelessWidget {
  BoxTextField(
      {this.controller,
      this.hintText,
      this.lableText,
      this.obscure,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.icon});

  TextEditingController controller;
  String hintText;
  String lableText;
  FormFieldSetter<String> onSaved;
  FormFieldValidator<String> validator;
  ValueChanged<String> onFieldSubmitted;
  bool obscure;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return new Container(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: width / 30,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(
                top: 2.0, bottom: 2.0, left: 16.0, right: 16.0),
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            height: 55.0,
            decoration: new BoxDecoration(
                color: Colors.grey.shade100,
                border: new Border.all(color: Colors.grey.shade400, width: 1.0),
                borderRadius: new BorderRadius.circular(8.0)),
            child: new TextFormField(
              obscureText: obscure,
              onSaved: onSaved,
              validator: validator,
              onFieldSubmitted: onFieldSubmitted,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    icon,
                    size: 28.0,
                  ),
                  hintText: hintText),
            ),
          )),
        ],
      ),
      padding: EdgeInsets.only(
        bottom: 16.0,
      ),
      margin: EdgeInsets.only(
          top: height / 40, right: width / 20, left: width / 20),
    );
  }
}
