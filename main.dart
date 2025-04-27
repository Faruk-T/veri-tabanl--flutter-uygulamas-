import 'package:flutter/material.dart';
import 'arac_ekle.dart';
import 'arac_listele.dart';
import 'arac_sil.dart';

void main() {
  runApp(MaterialApp(
    title: 'Servise Gelen Araçlar',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue),
    home: AnaSayfa(),
  ));
}

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(18, 18, 18, 145),
      appBar: AppBar(
        title: Text(
          'Araç Servis Takip Sistemi',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: Icon(Icons.add, size: 50),
              label: Text(
                'Araç Ekle',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AracEkle()));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.list, size: 50),
              label: Text(
                'Araç Listele',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AracListele()));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.delete, size: 50),
              label: Text(
                'Araç Sil',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AracSil()));
              },
            ),

            // 🔸 Yeni eklenen buton
           
          

            const Spacer(),
            Center(
              child: Text(
                '© Faruk Tazeoğlu',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
