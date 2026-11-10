import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),

      drawer: Drawer(
        child: ListView(
          children: const [
            ListTile(
              title: Text('Home Page'),
            ),
            ListTile(
              title: Text('About Page'),
            ),
          ],
        ),
      ),

      body: const Center(
        child: BiggerText(
          teks: 'Halo, Praktikum 3!',
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// StatelessWidget
class Heading extends StatelessWidget {
  final String text;

  const Heading({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// StatefulWidget
class BiggerText extends StatefulWidget {
  final String teks;

  const BiggerText({
    super.key,
    required this.teks,
  });

  @override
  State<BiggerText> createState() => _BiggerTextState();
}

class _BiggerTextState extends State<BiggerText> {
  double _textSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.teks,
          style: TextStyle(
            fontSize: _textSize,
          ),
        ),

        ElevatedButton(
          child: Text(
            _textSize == 16.0 ? 'Perbesar' : 'Perkecil',
          ),

          onPressed: () {
            setState(() {
              _textSize =
                  _textSize == 16.0 ? 32.0 : 16.0;
            });
          },
        ),
      ],
    );
  }
}
