import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// Quote Screen Class

// ignore: must_be_immutable
class QuotesScreen extends StatelessWidget {
  List quotes = [];

  // QuotesScreen constructor
  QuotesScreen({Key? key}) : super(key: key);

  // fetchQuotes method
  Future<List> fetchQuote() async {
    // url to be used in the request + quotes variable
    const url = 'https://breakingbadapi.com/api/quotes';

    // request to be sent
    try {
      // response from request
      final response = await http.get(
        Uri.parse(url),
      );
      // check response status
      if (response.statusCode == 200) {
        // parse json
        final jsonQuotes = json.decode(response.body);
        // iterate over json quotes
        for (var jsonQuote in jsonQuotes) {
          quotes.add(jsonQuotes[jsonQuote]['quote']);
        }
        // return quotes
        return quotes;
      } else {
        // throw error to catch
        throw Exception('Failed to load quotes');
      }
    } catch (e) {
      // throw error
      throw Exception('Failed to load quotes');
    }
  }

  // build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breaking Bad Quotes'),
        // navigate back to home screen
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List>(
        future: fetchQuote(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          // check snapshot status
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
            // return list view with quotes
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                // get quote
                final quote = snapshot.data?[index];
                // return quote
                return ListView.builder(
                  itemCount: quote?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      quote[index]['quote'],
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    );
                  },
                );
              },
              padding: const EdgeInsets.all(12),
            );
          }
        },
      ),
    );
  }
}
