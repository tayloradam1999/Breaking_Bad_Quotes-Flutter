import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// Quote Screen Class

// ignore: must_be_immutable
class QuotesScreen extends StatelessWidget {
  final String name;

  // QuotesScreen constructor
  const QuotesScreen({Key? key, required this.name}) : super(key: key);

  // fetchQuotes method
  Future<List<String>> fetchQuote(String name) async {
    // all names from api
    final names = name.split(' ');
    // format authorName for api
    final authorName = names.join('+');
    // get response
    final response = await http.get(
      Uri.parse(
        'https://breakingbadapi.com/api/quote?author=$authorName',
      ),
    );
    // check response status
    if (response.statusCode == 200) {
      final quotes = json.decode(response.body);
      List<String> quotesList = [];
      // iterate over quotes
      for (var quote in quotes) {
        // add quote to list
        quotesList.add(quote['quote']);
      }
      // check if quotes list is empty
      if (quotesList.isEmpty) {
        // add error string to quotesList and return
        quotesList.add('No quotes found');
        return quotesList;
      }
      // else, return quotes list
      return quotesList;
    } else {
      // throw error
      throw Exception('Failed to load quotes');
    }
  }

  // build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name Quotes'),
        // navigate back to home screen
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List>(
        future: fetchQuote(name),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // check snapshot status
          if (snapshot.connectionState == ConnectionState.waiting) {
            // center widget with circular progress indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
            // if state is done, check for error
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // if has error, show error message
              return const Center(
                child: Text('Error'),
              );
            } else {
              // no error, show quotes
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  // return quote card
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snapshot.data?[index]),
                    ),
                  );
                },
              );
            }
          } else {
            // throw error
            throw Exception('Failed to load quotes');
          }
        },
      ),
    );
  }
}
