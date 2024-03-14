import 'package:dictionary_apps/screen_page/login_screen.dart';
import 'package:dictionary_apps/utils/cek_session.dart';
import 'package:flutter/material.dart';
import 'package:dictionary_apps/model/model_dictionary.dart';
import 'package:dictionary_apps/screen_page/page_detail_kamus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageListKamus extends StatefulWidget {
  const PageListKamus({Key? key}) : super(key: key);

  @override
  State<PageListKamus> createState() => _PageListKamusState();
}

class _PageListKamusState extends State<PageListKamus> {
  String? id, username;
  late Future<List<Datum>?> _futureDictionary;
  late List<Datum> _dictionaryData = [];
  late List<Datum> _searchResult = [];
  final TextEditingController _searchController = TextEditingController();

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      print('id $id');
    });
  }

  @override
  void initState() {
    super.initState();
    _futureDictionary = getDictionary();
    getSession();
  }

  Future<List<Datum>?> getDictionary() async {
    try {
      http.Response res = await http.get(
          Uri.parse("http://10.126.243.55/dictionaryDb/getDictionary.php"));
      setState(() {
        _dictionaryData = modelDictionaryFromJson(res.body).data ?? [];
      });
      return _dictionaryData;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  void _filterSearchResults(String query) {
    List<Datum> searchResults = [];
    if (query.isNotEmpty) {
      _dictionaryData.forEach((datum) {
        if (datum.kataIndo!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(datum);
        }
      });
    }
    setState(() {
      _searchResult = searchResults;
    });
  }

  void _navigateToDetail(Datum data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageDetailKamus(data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180, // Tinggi kotak
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.book,
                  color: Colors.white,
                  size: 48, // Ukuran ikon
                ),
                SizedBox(height: 10),
                Text(
                  "Dictionary App Indonesian-Belanda",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20, // Ukuran teks judul
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 350,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          _filterSearchResults(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Hi.. ${username ?? ''}'),
                IconButton(
                  onPressed: () async {
                    // Tambahkan kode logout di sini
                    setState(() {
                      session.clearSession();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                      );
                    });
                  },
                  icon: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.isNotEmpty
                  ? _searchResult.length
                  : _dictionaryData.length,
              itemBuilder: (context, index) {
                Datum data = _searchResult.isNotEmpty
                    ? _searchResult[index]
                    : _dictionaryData[index];
                return Padding(
                  padding: EdgeInsets.all(2),
                  child: GestureDetector(
                    onTap: () {
                      _navigateToDetail(data);
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "${data.kataIndo}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: [
                                Icon(
                                  Icons.arrow_circle_right,
                                  color: Colors.blueAccent,
                                ),
                                Text(
                                  '${data.kataBelanda}',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
