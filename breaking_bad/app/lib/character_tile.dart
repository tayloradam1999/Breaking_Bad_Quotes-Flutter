import 'package:flutter/material.dart';
import 'models.dart';
// class CharacterTile - stateless widget

class CharacterTile extends StatelessWidget {
  // character property to be displayed per tile
  final Character character;

  // CharacterTile constructor
  const CharacterTile({
    Key? key,
    required this.character,
  }) : super(key: key);

  // build method
  @override
  Widget build(BuildContext context) {
    return (GridTile(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(character.imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            character.name,
            // text color white
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ));
  }
}
