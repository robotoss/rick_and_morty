import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';

class AppBarSearchTextField extends StatefulWidget {
  final String hintText;
  const AppBarSearchTextField({
    Key? key,
    required this.hintText,
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
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          filled: true,
          prefixIcon: Icon(
            RickMorty.search,
            color: Theme.of(context).textTheme.overline!.color,
          ),
          suffixIcon: Container(
            width: 40,
            child: Row(
              children: [
                Container(
                  width: 1,
                  height: 24,
                  color: Theme.of(context).textTheme.overline!.color,
                ),
                const SizedBox(width: 10),
                Icon(
                  RickMorty.filter,
                  color: Theme.of(context).textTheme.overline!.color,
                ),
              ],
            ),
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
