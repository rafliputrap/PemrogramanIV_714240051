import 'package:flutter/material.dart';

import 'models/contact_store.dart';
import 'pages/contact_page.dart';
import 'pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00BCD4)),
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}

/// Shell dengan navigasi bawah. Store dimiliki di sini dan IndexedStack menjaga
/// kedua halaman tetap hidup, sehingga data & isi formulir tidak hilang.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final ContactStore _store = ContactStore();
  int _index = 0;

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTS'),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
      body: IndexedStack(
        index: _index,
        children: [
          HomePage(store: _store, onOpenContacts: () => setState(() => _index = 1)),
          ContactPage(store: _store),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.contacts_outlined), selectedIcon: Icon(Icons.contacts), label: 'Daftar Kontak'),
        ],
      ),
    );
  }
}
