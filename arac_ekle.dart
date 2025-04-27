import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AracEkle extends StatefulWidget {
  @override
  _AracEkleState createState() => _AracEkleState();
}

class _AracEkleState extends State<AracEkle> {
  final _formKey = GlobalKey<FormState>();

  final aracAdiController = TextEditingController();
  final aracMarkaController = TextEditingController();
  final aracModelController = TextEditingController();
  final uretimYiliController = TextEditingController();
  final plakaController = TextEditingController();

  Future<void> _aracEkle() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/add_car'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'AracAdi': aracAdiController.text,
        'AracMarka': aracMarkaController.text,
        'AracModel': aracModelController.text,
        'UretimYili': uretimYiliController.text,
        'Plaka': plakaController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Araç başarıyla eklendi")));
      aracAdiController.clear();
      aracMarkaController.clear();
      aracModelController.clear();
      uretimYiliController.clear();
      plakaController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bir hata oluştu: ${response.body}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Araç Ekle"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: aracAdiController,
                decoration: InputDecoration(
                  labelText: "Araç Adı",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen araç adını girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: aracMarkaController,
                decoration: InputDecoration(
                  labelText: "Araç Markası",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen araç markasını girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: aracModelController,
                decoration: InputDecoration(
                  labelText: "Araç Modeli",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen araç modelini girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: uretimYiliController,
                decoration: InputDecoration(
                  labelText: "Üretim Yılı (yyyy-mm-dd)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen üretim yılını girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: plakaController,
                decoration: InputDecoration(
                  labelText: "Plaka",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.blue[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen plakayı girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _aracEkle();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Kaydet", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
