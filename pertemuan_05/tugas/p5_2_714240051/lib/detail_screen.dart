import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String nama;
  final String npm;

  const DetailScreen({super.key, required this.nama, required this.npm});

  @override
  Widget build(BuildContext context) {
    final List<String> listAktivitas = [
      'https://images.unsplash.com/photo-1517694712202-14dd9538aa97',
      'https://images.unsplash.com/photo-1498050108023-c5249f4df085',
      'https://images.unsplash.com/photo-1555066931-4365d14bab8c',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profil Mahasiswa'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nama,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'NPM: $npm',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            const Divider(height: 30, thickness: 1),
            const Text(
              'Tentang Saya',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Halo! Saya adalah seorang mahasiswa yang memiliki minat besar di bidang pengembangan aplikasi mobile (Flutter) dan pemograman web. Hobi saya meliputi ngoding eksplorasi teknologi baru, membaca buku pemrograman, serta mendesain antarmuka aplikasi.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15.0, height: 1.5),
            ),
            const SizedBox(height: 24),
            const Text(
              'Gallery Aktivitas',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: listAktivitas.map((url) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}