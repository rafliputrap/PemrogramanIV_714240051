import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Pertemuan 4',
      theme: ThemeData.light(useMaterial3: false),
      home: const TugasScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TugasScreen extends StatelessWidget {
  const TugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Pertemuan 4'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Box 1 (Biru - Persegi panjang horizontal dengan shadow)
              Container(
                width: 250,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Box 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              
              // Bagian Bawah: Box 2 dan Box 3 berdampingan (Row)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Box 2 (Merah - Outline border, teks di pojok kiri atas)
                  Container(
                    width: 120,
                    height: 150,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Box 2',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  
                  // Box 3 (Hijau - Sudut asimetris, teks di pojok kanan bawah)
                  Container(
                    width: 120,
                    height: 150,
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    alignment: Alignment.bottomRight,
                    child: const Text(
                      'Box 3',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}