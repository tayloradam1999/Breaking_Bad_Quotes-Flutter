import 'package:flutter/material.dart';
import 'quotes_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuotesScreen(name: character.name),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          // image
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(character.imgUrl),
              fit: BoxFit.cover,
            ),
          ),
          // character name
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              character.name,
              // text color white
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
