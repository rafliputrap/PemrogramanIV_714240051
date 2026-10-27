import 'package:flutter/material.dart';
import 'bottom_navbar.dart'; // Menghubungkan ke navbar bawah praktikum

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false, // Sesuai modul praktikum
      ),
      home: const DynamicBottomNavbar(), // Mengarahkan home ke DynamicBottomNavbar
    );
  }
}

// ==========================================
// KELAS MYINPUT (Praktikum Bagian A. TextField)
// ==========================================
class MyInput extends StatefulWidget {
  const MyInput({super.key});

  @override
  State<MyInput> createState() => MyInputState();
}

class MyInputState extends State<MyInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Widget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Write your name here...',
                labelText: 'Your Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Hello, ${_controller.text}'),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}