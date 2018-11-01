import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoxFeild extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle style;
  final TextAlign textAlign;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final int maxLines;
  final int maxLength;
  final bool maxLengthEnforced;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final IconData icon;
  final String hintText;
  final String lableText;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Color defaultBorderColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  final FormFieldSetter<String> onSaved;

  const BoxFeild({
    Key key,
    this.controller,
    this.focusNode,
    TextInputType keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.icon,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.maxLength,
    this.onSaved,
    this.hintText,
    this.lableText,
    this.maxLengthEnforced = true,
    this.onChanged,
    this.defaultBorderColor,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding,
    this.validator,
    this.onFieldSubmitted,
  })  : assert(textAlign != null),
        assert(autofocus != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(maxLengthEnforced != null),
        assert(maxLines == null || maxLines > 0),
        assert(maxLength == null || maxLength > 0),
        keyboardType = keyboardType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(key: key);

  @override
  _BoxFeildState createState() => _BoxFeildState();
}

class _BoxFeildState extends State<BoxFeild> {
  Color focusBorderColor =  Colors.grey.shade400;
  FocusNode _focusNode = FocusNode();
  ValueChanged<Colors> focusColorChange;
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

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
                top: 2.0, bottom: 2.0, left: 8.0, right: 8.0),
            padding: const EdgeInsets.all(6.0),
            alignment: Alignment.center,
            height: 52.0,
            decoration: new BoxDecoration(
                color: Colors.grey.shade100,
                border: new Border.all(color: focusBorderColor, width: 1.0),
                borderRadius: new BorderRadius.circular(8.0)),
            child: new TextFormField(
              obscureText: this.widget.obscureText,
              onSaved: this.widget.onSaved,
              validator: this.widget.validator,
              onFieldSubmitted: this.widget.onFieldSubmitted,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    this.widget.icon,
                    size: 24.0,
                  ),
                  hintText: this.widget.hintText),
            ),
          )),
        ],
      ),
      padding: EdgeInsets.only(
        bottom: 14.0,
      ),
      margin: EdgeInsets.only(
          top: height / 50, right: width / 20, left: width / 30),
    );
  }
}
