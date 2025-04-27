import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AracListele extends StatefulWidget {
  @override
  _AracListeleState createState() => _AracListeleState();
}

class _AracListeleState extends State<AracListele> {
  List<dynamic> araclar = [];

  @override
  void initState() {
    super.initState();
    _araclariGetir();
  }

  Future<void> _araclariGetir() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/list_cars'));
    if (response.statusCode == 200) {
      setState(() {
        araclar = jsonDecode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Araçlar alınırken hata oluştu")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Araç Listele"),
        centerTitle: true,
      ),
      body: araclar.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: araclar.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(araclar[index]['AracAdi'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text('Marka: ${araclar[index]['AracMarka']} - Model: ${araclar[index]['AracModel']}'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Araç detayına gitme işlevi
                    },
                  ),
                );
              },
            ),
    );
  }
}
