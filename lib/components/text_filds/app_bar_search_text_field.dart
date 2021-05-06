import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';
import 'package:rxdart/rxdart.dart';

class AppBarSearchTextField extends StatefulWidget {
  final String hintText;
  final Function(String searchText) onTextEnter;

  const AppBarSearchTextField({
    Key? key,
    required this.hintText,
    required this.onTextEnter,
  }) : super(key: key);

  @override
  _AppBarSearchTextFieldState createState() => _AppBarSearchTextFieldState();
}

class _AppBarSearchTextFieldState extends State<AppBarSearchTextField> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: BorderSide(color: Colors.transparent),
  );

  late TextEditingController textController;
  late FocusNode focusNode;

  bool showClearButton = false;

  final searchOnChange = BehaviorSubject<String>();

  void initListeners() {
    textController.addListener(() {
      if (textController.text.isNotEmpty) {
        setState(() {
          showClearButton = true;
        });
      }
    });

    searchOnChange.debounceTime(Duration(seconds: 1)).listen((queryString) {
      widget.onTextEnter(queryString);
    });
  }

  @override
  void initState() {
    textController = TextEditingController();
    focusNode = FocusNode();
    initListeners();

    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    searchOnChange.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        autofocus: true,
        onChanged: (value) => searchOnChange.add(value),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          filled: true,
          suffixIcon: showClearButton
              ? IconButton(
                  onPressed: () {
                    textController.clear();
                    focusNode.unfocus();
                    setState(() {
                      showClearButton = false;
                    });
                  },
                  icon: Icon(
                    RickMorty.close,
                    size: 12,
                    color: Theme.of(context).accentColor,
                  ),
                )
              : null,
          enabledBorder: border,
          errorBorder: border,
          focusedBorder: border,
          disabledBorder: border,
          focusedErrorBorder: border,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0,
          ),
        ),
      ),
    );
  }
}
