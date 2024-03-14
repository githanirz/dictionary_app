import 'package:dictionary_apps/screen_page/page_detail_kamus.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_apps/model/model_dictionary.dart';

class PageSearchListKamus extends StatelessWidget {
  final List<Datum> dictionaryData;
  final String searchQuery;

  const PageSearchListKamus({
    Key? key,
    required this.dictionaryData,
    required this.searchQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Datum> searchResults = [];

    // Filter data sesuai dengan query pencarian
    dictionaryData.forEach((datum) {
      if (datum.kataIndo!.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResults.add(datum);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          Datum data = searchResults[index];
          return ListTile(
            title: Text(data.kataIndo ?? ""),
            subtitle: Text(data.kataBelanda ?? ""),
            onTap: () {
              // Navigasi ke halaman detail untuk item yang dipilih
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDetailKamus(data),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
