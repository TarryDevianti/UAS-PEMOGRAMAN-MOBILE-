import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(KalkulatorPinkApp());

class KalkulatorPinkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: Color(0xFFFFF0F5),
      ),
      home: KalkulatorScreen(),
    );
  }
}

class KalkulatorScreen extends StatefulWidget {
  @override
  _KalkulatorScreenState createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  final TextEditingController input1 = TextEditingController();
  final TextEditingController input2 = TextEditingController();
  String hasil = "0";

  void hitung(String operasi) {
    double n1 = double.tryParse(input1.text) ?? 0;
    double n2 = double.tryParse(input2.text) ?? 0;
    double res = 0;

    setState(() {
      switch (operasi) {
        case "+": res = n1 + n2; break;
        case "-": res = n1 - n2; break;
        case "x": res = n1 * n2; break;
        case "/": res = n2 != 0 ? n1 / n2 : 0; break;
        case "%": res = n1 * (n2 / 100); break;
        case "^": res = pow(n1, n2).toDouble(); break;
        case "C": 
          input1.clear(); 
          input2.clear(); 
          res = 0; 
          break;
      }
      hasil = res.toStringAsFixed(res.truncateToDouble() == res ? 0 : 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pinky Calculator ✨", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.pink[300],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            // Card Tampilan Hasil
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.pink.withOpacity(0.1), blurRadius: 10, spreadRadius: 5)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("HASIL", style: TextStyle(color: Colors.pink[200], fontWeight: FontWeight.bold, letterSpacing: 2)),
                  Text(hasil, style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.pink[400])),
                ],
              ),
            ),
            SizedBox(height: 30),
            
            inputCard(input1, "Angka Pertama", Icons.looks_one),
            SizedBox(height: 15),
            inputCard(input2, "Angka Kedua", Icons.looks_two),
            SizedBox(height: 30),

            // Bagian Tombol yang Dirapatkan
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Grup 6 tombol operasi (3 kiri, 3 kanan)
                Column(
                  children: [
                    Row(
                      children: [
                        tombolOperasi("+", Colors.pink[300]!),
                        SizedBox(width: 8),
                        tombolOperasi("-", Colors.pink[300]!),
                        SizedBox(width: 8),
                        tombolOperasi("x", Colors.pink[300]!),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        tombolOperasi("/", Colors.pink[300]!),
                        SizedBox(width: 8),
                        tombolOperasi("%", Colors.orange[300]!),
                        SizedBox(width: 8),
                        tombolOperasi("^", Colors.purple[300]!),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 12),
                // Tombol CLEAR dengan teks horizontal dan ukuran pas
                SizedBox(
                  height: 148, // Menyamai tinggi tumpukan tombol kiri
                  width: 85,  // Lebar netral agar tulisan CLEAR muat menyamping
                  child: ElevatedButton(
                    onPressed: () => hitung("C"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[300],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text("CLEAR", 
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget inputCard(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.pink[700], fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.pink[300]),
        labelText: label,
        labelStyle: TextStyle(color: Colors.pink[200]),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.pink[50]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.pink[200]!),
        ),
      ),
    );
  }

  Widget tombolOperasi(String simbol, Color warna) {
    return Container(
      width: 65,
      height: 70,
      child: ElevatedButton(
        onPressed: () => hitung(simbol),
        style: ElevatedButton.styleFrom(
          backgroundColor: warna,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
        ),
        child: Text(simbol, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}