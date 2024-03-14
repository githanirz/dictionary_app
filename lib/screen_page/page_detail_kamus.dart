import 'package:dictionary_apps/model/model_dictionary.dart';
import 'package:flutter/material.dart';

class PageDetailKamus extends StatelessWidget {
  final Datum? data;

  const PageDetailKamus(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Kamus",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 16,
          bottom: 16,
        ),
        child: Container(
          color: Colors.blue.shade50,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.flag,
                    color: Colors.red.shade700,
                  ),
                  SizedBox(width: 8), // Spasi antara ikon dan teks
                  _buildDataLabel("Indonesian"),
                ],
              ),
              SizedBox(height: 8),
              Text(
                data?.kataIndo ?? "",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              Divider(),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.flag,
                    color: const Color.fromARGB(255, 3, 60, 118),
                  ),
                  SizedBox(width: 8), // Spasi antara ikon dan teks
                  _buildDataLabel("Belanda"),
                ],
              ),
              SizedBox(height: 8),
              Text(
                data?.kataBelanda ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 30),
              _buildDataLabel("Description"),
              SizedBox(height: 8),
              Text(
                data?.deskripsi ?? "",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }
}
