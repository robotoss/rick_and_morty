import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/api/models/all_characters_model.dart';

class CharacterInfoScreen extends StatelessWidget {
  final Character character;
  const CharacterInfoScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'CharacterAvatar_${character.id}',
          child: CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(character.image),
          ),
        ),
      ),
    );
  }
}
