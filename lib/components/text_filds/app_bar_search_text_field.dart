import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';

class AppBarSearchTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  const AppBarSearchTextField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.focusNode,
  }) : super(key: key);

  @override
  _AppBarSearchTextFieldState createState() => _AppBarSearchTextFieldState();
}

class _AppBarSearchTextFieldState extends State<AppBarSearchTextField> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: BorderSide(color: Colors.transparent),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextField(
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          filled: true,
          prefixIcon: Icon(
            RickMorty.search,
            color: Theme.of(context).textTheme.overline!.color,
          ),
          suffixIcon: Icon(
            RickMorty.close,
            size: 12,
            color: Theme.of(context).accentColor,
          ),
          enabledBorder: border,
          errorBorder: border,
          focusedBorder: border,
          disabledBorder: border,
          focusedErrorBorder: border,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 16.0,
          ),
        ),
      ),
    );
  }
}
