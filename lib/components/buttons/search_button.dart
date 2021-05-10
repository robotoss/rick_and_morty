import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/rick_morty_icons.dart';

class SearchFilterButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const SearchFilterButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTap,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(100),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Icon(
                      RickMorty.search,
                      color: Theme.of(context).textTheme.overline!.color,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 56,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(100),
                ),
              ),
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
          )
        ],
      ),
    );
  }
}
