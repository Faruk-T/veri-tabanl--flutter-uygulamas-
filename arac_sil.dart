import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AracSil extends StatefulWidget {
  @override
  _AracSilState createState() => _AracSilState();
}

class _AracSilState extends State<AracSil> {
  List<dynamic> araclar = [];

  @override
  void initState() {
    super.initState();
    _getAraclar();
  }

  // Araçları veritabanından çekme fonksiyonu
  Future<void> _getAraclar() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/list_cars'));

    if (response.statusCode == 200) {
      setState(() {
        araclar = json.decode(response.body);
      });
    } else {
      throw Exception('Veritabanından araçlar çekilemedi');
    }
  }

  // Araç silme fonksiyonu
  Future<void> _silArac(int aracId) async {
    final response = await http.delete(Uri.parse('http://127.0.0.1:5000/delete_car/$aracId'));

    if (response.statusCode == 200) {
      // Başarılı silme işlemi sonrası veriyi güncelle
      _getAraclar();
    } else {
      throw Exception('Araç silinemedi');
    }
  }

  // Onay penceresini açan fonksiyon
  void _showDeleteConfirmationDialog(int aracId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aracı Sil'),
          content: Text('Aracı silmek istediğinizden emin misiniz?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _silArac(aracId); // Araç silinsin
                Navigator.of(context).pop(); // Dialogu kapat
              },
              child: Text('EVET'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialogu kapat
              },
              child: Text('HAYIR'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Araç Sil'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: araclar.length,
        itemBuilder: (context, index) {
          final arac = araclar[index];

          return Card(
            margin: EdgeInsets.all(8),
            elevation: 5,
            child: ListTile(
              title: Text('${arac['AracAdi']} ${arac['AracMarka']}'),
              subtitle: Text('${arac['AracModel']} - ${arac['UretimYili']}'),
              trailing: Icon(Icons.delete_forever, color: Colors.red),
              onTap: () {
                // Araç üzerine tıklanınca onay penceresini göster
                _showDeleteConfirmationDialog(arac['AracID']);
              },
            ),
          );
        },
      ),
    );
  }
}
