import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/api/models/list_characters_model.dart';
import 'package:rick_and_morty/screens/character_info/feature.dart';
import 'package:rick_and_morty/theme/app_text_styles.dart';
import 'package:rick_and_morty/data/extensions/character_extentions.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;
  const CharacterListItem({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => Navigator.of(context, rootNavigator: true).push(
          characterInfoRoute(character),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'CharacterAvatar_${character.id}',
              child: CircleAvatar(
                radius: 37,
                backgroundImage: NetworkImage(character.image),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.status.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .overline!
                        .copyWith(color: character.statusColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    character.name,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.charName.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${character.species}, ${character.gender}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
