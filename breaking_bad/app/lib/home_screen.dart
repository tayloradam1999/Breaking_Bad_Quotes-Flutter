import 'package:flutter/material.dart';
import 'character_tile.dart';
import 'models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// class HomeScreen - stateful widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // HomeScreenState - state class
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // _characters - list of characters
  late Future<List<Character>> _characters;

  @override
  void initState() {
    // init state
    super.initState();
    // set future to fetch characters
    _characters = fetchBbCharacters();
  }

  // fetch characters function
  Future<List<Character>> fetchBbCharacters() async {
    List<Character> characters = [];

    try {
      // fetch characters from api
      final response = await http.get(
        Uri.https('breakingbadapi.com', '/api/characters'),
      );

      // check response status
      if (response.statusCode == 200) {
        // parse json
        final jsonCharacters = json.decode(response.body);
        // iterate over json characters
        for (var jsonCharacter in jsonCharacters) {
          // add character to list
          characters.add(Character.fromJson(jsonCharacter));
        }
      } else {
        // throw error to catch
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      // throw error
      throw Exception('Failed to load characters');
    }

    // return characters
    return characters;
  }

  // build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breaking Bad Quotes'),
      ),
      body: FutureBuilder<List<Character>>(
        future: _characters,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // if loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            // center widget with circular progress indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
            // if no data in snapshot
          }
          if (snapshot.data == null) {
            // show error message
            return const Center(
              child: Text('Error'),
            );
            // if has data
          } else {
            return GridView.builder(
              // setup gridview
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
              ),
              // add characters to gridview
              // null check for snapshot data to avoid error
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (BuildContext contex, int index) {
                // return CharacterTile widget
                return CharacterTile(
                  character: snapshot.data[index],
                );
              },
              // add padding to gridview
              padding: const EdgeInsets.all(15),
              // add shrink wrap to gridview
              shrinkWrap: true,
            );
          }
        },
      ),
    );
  }
}
