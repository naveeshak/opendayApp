import 'package:flutter/material.dart';
import 'package:openday/screens/map_screen.dart';
import 'package:openday/screens/tour_screen.dart';
import 'package:openday/screens/contact_screen.dart';
import 'package:openday/screens/offers_screen.dart';
import 'package:openday/screens/qr_scanner_screen.dart';
import 'package:openday/screens/home_screen.dart';

class SimpleSearchDelegate extends SearchDelegate<String> {
  final List<String> dataList;

  SimpleSearchDelegate(this.dataList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = dataList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text('No results found.'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]); // or handle action
            _navigateToScreen(context, result);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = dataList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }

// Navigation logic based on tapped result
void _navigateToScreen(BuildContext context, String result) {
  Widget? screen;

  switch (result) {
    case 'Campus Map':
      screen = const MapScreen();
      break;
    case 'Virtual Tour':
      screen = const TourScreen();
      break;
    case 'Special Offers':
      screen = const OffersScreen();
      break;
    case 'Contact Us':
      screen = const ContactScreen();
      break;
    case 'QR Scanner':
      screen = const QRScreen();
      break;
    case 'Home':
      screen = const HomeScreen();
      break;
    case 'Event':
      screen = EventScreen();
      break;
    case 'QR':
      screen = const QRScreen();
      break;
    case 'Offers':
      screen = const OffersScreen();
      break;
    case 'Email':
      screen = const ContactScreen();
      break;
    case 'Phone':
      screen = const ContactScreen();
      break;
    case 'Fax':
      screen = const ContactScreen();
      break;
    case '360':
      screen = const TourScreen();
      break;
    case 'Virtual':
      screen = const TourScreen();
      break;
  }

  if (screen != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen!),
    );
  }
}
}